require "csv"

INPUT_FILE  = "src/fg.csv".freeze
OUTPUT_FILE = "src/fg_out.csv".freeze

# 一度目の走査でユニークIPを収集
unique_ips = []
CSV.foreach(INPUT_FILE, headers: true) do |row|
  unique_ips << row["dstip"] if row["dstip"]
  unique_ips << row["srcip"] if row["srcip"]
end
unique_ips = unique_ips.uniq.sort
substitution_table = unique_ips.each_with_index.to_h { |ip, idx| [ip, format("IP%010d", idx)] }

# 二度目の走査で変換しながら書き出し
CSV.open(OUTPUT_FILE, "w") do |csv|
  csv << CSV.open(INPUT_FILE, &:readline)
  CSV.foreach(INPUT_FILE, headers: true) do |row|
    row["dstip"] = substitution_table[row["dstip"]] if row["dstip"]
    row["srcip"] = substitution_table[row["srcip"]] if row["srcip"]
    csv << row
  end
end
