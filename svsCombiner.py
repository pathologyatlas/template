import os
import sys
import platform

def add_vips_to_path():
    system = platform.system()
    if system == "Windows":
        vips_path = r'C:\\vips\\bin'
    elif system == "Darwin":  # macOS
        vips_path = '/usr/local/lib'
    elif system == "Linux":
        vips_path = '/usr/lib'
    else:
        print(f"Unsupported operating system: {system}")
        return

    if os.path.exists(vips_path):
        os.environ['PATH'] = f"{vips_path}{os.pathsep}{os.environ['PATH']}"
        if system != "Windows":
            # For macOS and Linux, we also need to set LD_LIBRARY_PATH
            os.environ['LD_LIBRARY_PATH'] = f"{vips_path}{os.pathsep}{os.environ.get('LD_LIBRARY_PATH', '')}"
    else:
        print(f"VIPS directory not found at {vips_path}")

# Call the function to add VIPS to PATH
add_vips_to_path()


# The paths for macOS and Linux are based on common installation locations. If VIPS is installed in a different location on your system, you may need to adjust these paths.
# On macOS, if you installed VIPS using Homebrew, the path might be /usr/local/opt/vips/lib instead.
# On Linux, the path might vary depending on your distribution and how VIPS was installed. Common alternatives include /usr/local/lib or /opt/vips/lib.
# You may need to run sudo ldconfig on Linux after installation to update the shared library cache.

# To make this work across different systems:

# Place this code at the beginning of your script, before any other imports that depend on VIPS.
# Ensure that VIPS is installed on each system where you run the script.
# If necessary, adjust the paths in the add_vips_to_path() function to match the actual installation locations on your systems.


import tkinter as tk
from tkinter import filedialog, messagebox, ttk
import pyvips
import os

class SVSCombinerApp:
    def __init__(self, master):
        self.master = master
        master.title("SVS Combiner")
        master.geometry("500x400")  # Set window size
        master.resizable(False, False)  # Disable resizing

        self.files = []
        self.output_file = tk.StringVar()
        self.reduction_factor = tk.DoubleVar(value=1.0)
        self.grid_option = tk.StringVar()

        # Create main frame
        main_frame = ttk.Frame(master, padding="10")
        main_frame.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))
        main_frame.columnconfigure(0, weight=1)

        # File selection
        ttk.Button(main_frame, text="Select SVS Files", command=self.select_files).grid(row=0, column=0, sticky=tk.W, pady=5)
        self.file_label = ttk.Label(main_frame, text="No files selected")
        self.file_label.grid(row=1, column=0, sticky=tk.W, pady=5)

        # Grid option selection
        ttk.Label(main_frame, text="Select grid arrangement:").grid(row=2, column=0, sticky=tk.W, pady=5)
        self.grid_dropdown = ttk.Combobox(main_frame, textvariable=self.grid_option, state="readonly")
        self.grid_dropdown.grid(row=3, column=0, sticky=(tk.W, tk.E), pady=5)

        # Output file name
        ttk.Label(main_frame, text="Output file name:").grid(row=4, column=0, sticky=tk.W, pady=5)
        ttk.Entry(main_frame, textvariable=self.output_file).grid(row=5, column=0, sticky=(tk.W, tk.E), pady=5)

        # Reduction factor
        ttk.Label(main_frame, text="Reduction factor (0.1-1.0):").grid(row=6, column=0, sticky=tk.W, pady=5)
        ttk.Entry(main_frame, textvariable=self.reduction_factor).grid(row=7, column=0, sticky=(tk.W, tk.E), pady=5)

        # Process button
        ttk.Button(main_frame, text="Combine and Resize", command=self.process_images).grid(row=8, column=0, sticky=(tk.W, tk.E), pady=20)

    def select_files(self):
        self.files = filedialog.askopenfilenames(filetypes=[("SVS files", "*.svs")])
        self.file_label.config(text=f"{len(self.files)} files selected")
        self.update_grid_options()

    def update_grid_options(self):
        num_files = len(self.files)
        options = []
        for rows in range(1, num_files + 1):
            for cols in range(1, num_files + 1):
                if rows * cols >= num_files:
                    options.append(f"{rows}x{cols}")
        self.grid_dropdown['values'] = options
        if options:
            self.grid_dropdown.set(options[0])

    def process_images(self):
        if not self.files:
            messagebox.showerror("Error", "No files selected")
            return
        if not self.output_file.get():
            messagebox.showerror("Error", "No output file specified")
            return
        if not self.grid_option.get():
            messagebox.showerror("Error", "No grid arrangement selected")
            return
        
        try:
            reduction = float(self.reduction_factor.get())
            if not 0.1 <= reduction <= 1.0:
                raise ValueError
        except ValueError:
            messagebox.showerror("Error", "Invalid reduction factor. Use a number between 0.1 and 1.0")
            return

        try:
            self.combine_and_resize()
            messagebox.showinfo("Success", "Images combined and resized successfully!")
        except Exception as e:
            messagebox.showerror("Error", f"An error occurred: {str(e)}")

    def combine_and_resize(self):
        # Load images
        images = [pyvips.Image.new_from_file(f, level=0) for f in self.files]

        # Get grid size from user selection
        rows, cols = map(int, self.grid_option.get().split('x'))

        # Create blank image
        total_width = sum(img.width for img in images[:cols])
        total_height = sum(max(images[i:i+cols], key=lambda x: x.height).height 
                           for i in range(0, len(images), cols))
        combined = pyvips.Image.black(total_width, total_height)

        # Insert images
        x, y = 0, 0
        for i, img in enumerate(images):
            if i > 0 and i % cols == 0:
                x = 0
                y += max(images[i-cols:i], key=lambda x: x.height).height
            combined = combined.insert(img, x, y)
            x += img.width

        # Resize
        resized = combined.resize(self.reduction_factor.get(), kernel='lanczos3')

        # Save
        output_path = os.path.join(os.path.dirname(self.files[0]), self.output_file.get())
        resized.write_to_file(output_path, compression='lzw', pyramid=True)

root = tk.Tk()
app = SVSCombinerApp(root)
root.mainloop()