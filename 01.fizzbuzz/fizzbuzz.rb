#!/usr/bin/env ruby

# 定数の定義
Three = 3
Five = 5
# Stringを宣言
str_print = String.new

20.times do |count|
    str_print = ""  # 初期化
    count += 1      # 1から始める
    if count % Three == 0 || count % Five == 0  # 3または5の倍数の時の処理
        str_print = "Fizz" if count % 3 == 0    # 3の倍数なら必ず"Fizz"
        str_print += "Buzz" if count % 5 == 0   # 5の倍数なら"Buzz"を追加
    else                                
        str_print = count.to_s                  # 3の倍数でも5の倍数でもなければ1から始まるcountを表示
    end
    puts str_print                              # 出力
end