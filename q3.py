import os

folder_name = input("Enter folder name to create: ")

if not os.path.exists(folder_name):
    os.mkdir(folder_name)
    print(f"Directory '{folder_name}' created.")
else:
    print(f"Directory '{folder_name}' already exists.")
