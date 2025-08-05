import os


working_dir = input("Enter the working directory path: ")


reports_dir = os.path.join(working_dir, "reports")


if not os.path.exists(reports_dir):
    os.mkdir(reports_dir)
    print("Created 'reports' directory.")
else:
    print("'reports' directory already exists.")

txt_files = [f for f in os.listdir(working_dir) if os.path.isfile(os.path.join(working_dir, f)) and f.endswith('.txt')]

for file in txt_files:
    print("Found .txt file:", file)
    source = os.path.join(working_dir, file)
    destination = os.path.join(reports_dir, file)
    os.rename(source, destination)
    print(f"Moved '{file}' to 'reports/'")
