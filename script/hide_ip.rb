require "csv"

INPUT_FILE  = "src/fg.csv".freeze
OUTPUT_FILE = "src/fg_out.csv".freeze

def build_substitution_table(*columns)
  unique_ips = columns.flatten.uniq.sort
  unique_ips.each_with_index.to_h do |ip, index|
    [ip, format("IP%010d", index)]
  end
end

def transform_column(column, table)
  column.map { |ip| table[ip] }
end

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

main(INPUT_FILE, OUTPUT_FILE)
