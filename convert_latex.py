import re
import sys

def convert_latex_format(md_text):
    # Replace block math (\\[ ... \\])
    md_text = re.sub(r'\\\[(.*?)\\\]', r'$$\1$$', md_text, flags=re.DOTALL)

    # Replace inline math with \(\) or $ and remove extra spaces
    md_text = re.sub(r'\\\(\s*(.*?)\s*\\\)', r'$\1$', md_text, flags=re.DOTALL)  # for \(\)
    md_text = re.sub(r'\$\s*(.*?)\s*\$', r'$\1$', md_text, flags=re.DOTALL)  # for $

    return md_text

def main():
    if len(sys.argv) != 3:
        print("Usage: python convert_latex.py <input_file.md> <output_file.md>")
        sys.exit(1)

    input_file = sys.argv[1]
    output_file = sys.argv[2]

    try:
        with open(input_file, 'r', encoding='utf-8') as f:
            md_content = f.read()
    except FileNotFoundError:
        print(f"Error: Input file '{input_file}' not found.")
        sys.exit(1)

    converted_content = convert_latex_format(md_content)

    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(converted_content)

    print(f"✅ Conversion completed. Output saved to '{output_file}'.")

if __name__ == "__main__":
    main()
