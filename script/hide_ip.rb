require "csv"

INPUT_FILE  = "src/fg.csv".freeze
OUTPUT_FILE = "src/fg_out.csv".freeze

# Builds a substitution table mapping original IPs to their hidden counterparts.
# @param columns [Array<Array<String>>] Arrays of IP addresses from different columns
# @return [Hash<String, String>] The substitution table
def build_substitution_table(*columns)
  unique_ips = columns.flatten.uniq.sort
  unique_ips.each_with_index.to_h do |ip, index|
    [ip, format("IP%010d", index)]
  end
end

# @param column [Array<String>] The column to transform
# @param table [Hash<String, String>] The substitution table
# @return [Array<String>] The transformed column
def transform_column(column, table) = column.map { |ip| table[ip] }

def main(input_file, output_file)
  data = CSV.read(input_file, headers: true)

  substitution_table = build_substitution_table(data["dstip"][0...-1], data["srcip"][0...-1])

  data["dstip"] = transform_column(data["dstip"], substitution_table)
  data["srcip"] = transform_column(data["srcip"], substitution_table)

  CSV.open(output_file, "w") do |csv|
    csv << data.headers
    data.each { |row| csv << row }
  end
end

main(INPUT_FILE, OUTPUT_FILE) if __FILE__ == $PROGRAM_NAME
