import os

directory = input("Enter directory to search for .txt files: ")

if os.path.isdir(directory):
    txt_files = [f for f in os.listdir(directory) if os.path.isfile(os.path.join(directory, f)) and f.endswith('.txt')]
    print("Text files found:", txt_files)
else:
    print(f"'{directory}' is not a valid directory.")
