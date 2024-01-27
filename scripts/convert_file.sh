#!/bin/bash

convert_file() {
    local input_file="$1"
    local output_extension="$2"

    # Extracting the filename without extension
    local base_name=$(basename -- "$input_file")
    local name="${base_name%.*}"

    # Constructing the output filename
    local output_file="${name}.${output_extension}"

    # Performing the conversion
    duckdb -c "copy (select * from '${input_file}') to '${output_file}'"

    echo "Conversion complete: ${output_file}"
}

# Check if the number of arguments is less than 2
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <input_file> <output_extension>"
    echo "Example: $0 example.parquet csv"
    exit 1
fi

# Call the conversion function with the provided arguments
convert_file "$1" "$2"

