import os


input_folder = 'data_input'
output_folder = 'data_output'


if not os.path.exists(input_folder):
    os.makedirs(input_folder)
    print(f"'{input_folder}' folder created. Please add .txt files to it and re-run the script.")
    exit()


if not os.path.exists(output_folder):
    os.makedirs(output_folder)

summary_lines = []


for filename in os.listdir(input_folder):
    if filename.endswith('.txt'):
        input_path = os.path.join(input_folder, filename)
        output_path = os.path.join(output_folder, filename)

        line_count = 0
        word_count = 0
        modified_lines = []

        with open(input_path, 'r', encoding='utf-8') as file:
            for line in file:
                if line.strip().startswith('#'):
                    continue 
                line_count += 1
                words = line.strip().split()
                word_count += len(words)
                modified_line = line.replace('temp', 'permanent')
                modified_lines.append(modified_line)

    
        with open(output_path, 'w', encoding='utf-8') as out_file:
            out_file.writelines(modified_lines)

     
        summary_lines.append(f"{filename}\tLines: {line_count}\tWords: {word_count}")


summary_path = os.path.join(output_folder, 'summary.txt')
with open(summary_path, 'w', encoding='utf-8') as summary_file:
    summary_file.write("Summary of Processed Files\n")
    summary_file.write("----------------------------\n")
    for line in summary_lines:
        summary_file.write(line + '\n')

print("✅ Processing complete. Modified files and summary are saved in the 'data_output' folder.")
