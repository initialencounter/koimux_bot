echo 5秒后开始重装koishi,数据将丢失！！ctrl+c结束运行
sleep 1
echo 4秒后开始重装koishi,数据将丢失！！ctrl+c结束运行
sleep 1
echo 3秒后开始重装koishi,数据将丢失！！ctrl+c结束运行
sleep 1
echo 2秒后开始重装koishi,数据将丢失！！ctrl+c结束运行
sleep 1
echo 1秒后开始重装koishi,数据将丢失！！ctrl+c结束运行

echo "正在重装 koishi"
rm ~/koishi -rf
bash -c "$(curl -L https://my.initencunter.com/koishi.sh)"