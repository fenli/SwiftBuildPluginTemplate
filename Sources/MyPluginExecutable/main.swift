import Foundation

func printHelp() {
    print("""
    USAGE: my-plugin-executable -i input_file -o output_file
    ARGUMENTS:
      -i input_file           The input file path
      -o output_file          The output generated file path
    OPTIONS:
      -h, --help              Show help information.
    """)
}

printHelp()
