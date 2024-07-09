import os
import subprocess
import tkinter as tk
from tkinter import filedialog, messagebox

def convert_svs_to_dzi():
    # Open file dialog to select SVS files
    file_paths = filedialog.askopenfilenames(
        title="Select SVS files",
        filetypes=[("SVS files", "*.svs")]
    )

    if not file_paths:
        messagebox.showinfo("Info", "No files selected.")
        return

    for file_path in file_paths:
        # Get the directory and filename without extension
        directory = os.path.dirname(file_path)
        filename = os.path.splitext(os.path.basename(file_path))[0]
        
        # Construct the output path
        output_path = os.path.join(directory, filename)

        # Run the VIPS command
        try:
            subprocess.run(["vips", "dzsave", file_path, output_path], check=True)
            # messagebox.showinfo("Success", f"Converted {filename}.svs to DZI format.")
        except subprocess.CalledProcessError as e:
            messagebox.showerror("Error", f"Failed to convert {filename}.svs: {str(e)}")

# Create the main window
root = tk.Tk()
root.title("SVS to DZI Converter")
root.geometry("300x100")

# Create and pack the convert button
convert_button = tk.Button(root, text="Select and Convert SVS Files", command=convert_svs_to_dzi)
convert_button.pack(expand=True)

# Start the GUI event loop
root.mainloop()
