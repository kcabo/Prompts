#!/bin/bash

# 東京都の天気予報を取得するスクリプト
# API: https://weather.tsukumijima.net/
# 東京都のID: 130010

CITY_ID="130010"
API_URL="https://weather.tsukumijima.net/api/forecast?city=${CITY_ID}"

# APIから天気データを取得
weather_data=$(curl -s "${API_URL}")

# エラーチェック
if [ -z "$weather_data" ]; then
    echo "❌ 天気情報の取得に失敗しました"
    exit 1
fi

# 予報データは3日分固定
forecast_count=3

# 各日の天気予報を表示
for i in $(seq 0 $((forecast_count - 1))); do
    date=$(echo "$weather_data" | jq -r ".forecasts[$i].date")
    date_label=$(echo "$weather_data" | jq -r ".forecasts[$i].dateLabel")
    telop=$(echo "$weather_data" | jq -r ".forecasts[$i].telop")

    # 気温情報
    temp_min_c=$(echo "$weather_data" | jq -r ".forecasts[$i].temperature.min.celsius // \"---\"")
    temp_max_c=$(echo "$weather_data" | jq -r ".forecasts[$i].temperature.max.celsius // \"---\"")

    # 降水確率
    rain_t00_06=$(echo "$weather_data" | jq -r ".forecasts[$i].chanceOfRain.T00_06 // \"---\"")
    rain_t06_12=$(echo "$weather_data" | jq -r ".forecasts[$i].chanceOfRain.T06_12 // \"---\"")
    rain_t12_18=$(echo "$weather_data" | jq -r ".forecasts[$i].chanceOfRain.T12_18 // \"---\"")
    rain_t18_24=$(echo "$weather_data" | jq -r ".forecasts[$i].chanceOfRain.T18_24 // \"---\"")

    # 天気に応じた絵文字
    weather_emoji="☁️"
    if [[ $telop == *"晴"* ]]; then
        weather_emoji="☀️"
    elif [[ $telop == *"雨"* ]]; then
        weather_emoji="☔"
    elif [[ $telop == *"雪"* ]]; then
        weather_emoji="❄️"
    fi

    echo "【${date_label}】 ${date}"
    echo "${weather_emoji}  天気: ${telop}"

    # 気温表示
    if [ "$temp_min_c" != "---" ] || [ "$temp_max_c" != "---" ]; then
        echo "🌡️  気温: 最低 ${temp_min_c}℃ / 最高 ${temp_max_c}℃"
    fi

    # 降水確率表示
    echo "💧 降水確率:"
    echo "    00-06時: ${rain_t00_06}"
    echo "    06-12時: ${rain_t06_12}"
    echo "    12-18時: ${rain_t12_18}"
    echo "    18-24時: ${rain_t18_24}"

    # 最後の要素以外は区切り線を表示
    if [ $i -lt $((forecast_count - 1)) ]; then
        echo ""
        echo "────────────────────────────────"
        echo ""
    fi
done
