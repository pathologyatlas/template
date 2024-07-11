#!/bin/bash

# chmod +x remove-files.sh
# ./remove-files.sh


# Base path of your project
base_path="."  # Assumes script is run from the project directory

# Array to store items to remove
items_to_remove=(
    "./all.html" "./app.R" "./app2.R" "./generate_html.R" "./generate_qmd.R"
    "./git_push.sh" "./HE_annotated-deneme.html" "./HE_annotated.html"
    "./HE-deneme.html" "./multiple.html" "./openseadragon-plugins.qmd"
    "./svs_to_dzi.py" "./svsCombiner.py" "./remove-files.sh" "./sablon.md"
)

# Function to list all files and folders in the project
list_items() {
    echo "Files and folders in the project:"
    find "$base_path" -maxdepth 1 -type f -o -type d | sed "s|$base_path/||"
}

# Function to display current removal list
show_removal_list() {
    echo "Current removal list:"
    for i in "${!items_to_remove[@]}"; do
        echo "$i: ${items_to_remove[$i]}"
    done
}

# Function to add an item to the removal list
add_item() {
    echo "Enter the file or folder name to add:"
    read item
    if [ -e "$base_path/$item" ]; then
        items_to_remove+=("$item")
        echo "Added $item to removal list."
    else
        echo "Item not found: $item"
    fi
}

# Function to remove an item from the removal list
remove_from_list() {
    if [ ${#items_to_remove[@]} -eq 0 ]; then
        echo "Removal list is empty."
        return
    fi
    show_removal_list
    echo "Enter the index of the item to remove from the list:"
    read index
    if [ "$index" -ge 0 ] && [ "$index" -lt ${#items_to_remove[@]} ]; then
        unset "items_to_remove[$index]"
        items_to_remove=("${items_to_remove[@]}")
        echo "Item removed from the list."
    else
        echo "Invalid index."
    fi
}

# Function to execute item removal
execute_removal() {
    if [ ${#items_to_remove[@]} -eq 0 ]; then
        echo "No items to remove."
        return
    fi
    echo "The following items will be removed:"
    printf '%s\n' "${items_to_remove[@]}"
    echo "Are you sure you want to proceed? (y/n)"
    read confirm
    if [ "$confirm" = "y" ]; then
        for item in "${items_to_remove[@]}"; do
            if [ -e "$base_path/$item" ]; then
                rm -rf "$base_path/$item"
                echo "Removed: $item"
            else
                echo "Skipped: $item"
            fi
        done
        # Remove empty directories
        find "$base_path" -type d -empty -delete
        echo "Removal process completed."
        echo "Empty directories have been removed."
        items_to_remove=()
    else
        echo "Removal cancelled."
    fi
}

# Main menu
while true; do
    echo ""
    echo "File and Folder Removal Interface"
    echo "1. List all files and folders"
    echo "2. Show current removal list"
    echo "3. Add item to removal list"
    echo "4. Remove item from removal list"
    echo "5. Execute removal"
    echo "6. Exit"
    echo "Enter your choice:"
    read choice

    case $choice in
        1) list_items ;;
        2) show_removal_list ;;
        3) add_item ;;
        4) remove_from_list ;;
        5) execute_removal ;;
        6) echo "Exiting program."; exit 0 ;;
        *) echo "Invalid choice. Please try again." ;;
    esac
done