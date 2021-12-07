#!/usr/bin/env ruby

require "optparse"
require "date"

# 変数の初期化
year = 0
month = 0
day = 0
output = ""

# コマンドラインのオプションを取り込む
opt = OptionParser.new
opt.on('-y [VAL]') {|v| year = v}
opt.on('-m [VAL]') {|v| month = v}
opt.parse!(ARGV)
# オプションがついていない場合は現在の年月を設定
year = Date.today.year if year == 0
month = Date.today.month if month == 0

# 対象月のカレンダーを作成する
calendar = Date.new(year.to_i,month.to_i)           # 対象月の朔日を取得
days_of_month = calendar.next_month.prev_day.day    # その月の日数を取得
day_of_week = calendar.cwday + 1                    # 日曜日始まりにする

# タイトル行と曜日行を追加
output = "      " + year.to_s + "年　" + month.to_s + "月\n日 月 火 水 木 金 土\n"
# 朔日の曜日-1日分の字下げ
(day_of_week - 1).times do
    output += "   "
end

# 対象月の日数分だけ繰り返して日付を記入する
days_of_month.times do |day|
    day += 1                                    # 1から開始する
    output += sprintf("%2d ",day)               # 右揃えに桁を合わせる
    output += "\n" if day_of_week  % 7 == 0     # 土曜日の後に改行を追加
    day_of_week += 1                            # 曜日を進める
end

# 出力
puts output
