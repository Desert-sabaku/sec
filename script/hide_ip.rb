require "csv"

FILE = "src/fg.csv"
DATA = CSV.read(FILE, headers: true)

# 一番最後の行を削除したものを取得
i = 0
DSTIP = DATA["dstip"][...-1]
SRCPIP = DATA["srcip"][...-1]
SUBSTITUTION_TABLE = [*DSTIP, *SRCPIP].uniq.sort.each_with_object({}) do |key, h|
  h[key] = i.to_s.rjust(10, "0")
  i += 1
end

DSTIP.each do |item|
  item.gsub!(item, SUBSTITUTION_TABLE[item])
  item.gsub!(/^/, "IP")
end

SRCPIP.each do |item|
  item.gsub!(item, SUBSTITUTION_TABLE[item])
  item.gsub!(/^/, "IP")
end

pp DSTIP, SRCPIP
# 加工後のdstip, srcip列で元のCSVファイルを上書き保存
DATA["dstip"][...-1] = DSTIP
DATA["srcip"][...-1] = SRCPIP
CSV.open("src/fg_out.csv", "w") do |csv|
  csv << DATA.headers
  DATA.each do |row|
    csv << row
  end
end
