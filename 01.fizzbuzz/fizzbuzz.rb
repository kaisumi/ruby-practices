#!/usr/bin/env ruby

# 定数
Three = 3
Five = 5
Iteration = 20      # 繰り返し回数

# 変数
str_print = String.new  # Stringを宣言

Iteration.times do |count|
    str_print = ""                              # 初期化
    count += 1                                  # 1から始める
    if count % Three == 0 || count % Five == 0  # 3または5の倍数の場合
        str_print = "Fizz" if count % 3 == 0        # 3の倍数なら必ず"Fizz"
        str_print += "Buzz" if count % 5 == 0       # 5の倍数なら"Buzz"を追加
    else                                        # 3の倍数でも5の倍数でもない場合
        str_print = count.to_s                      # 1から始まるcountを表示
    end
    puts str_print                              # 出力
end
