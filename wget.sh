cd app/assets/images
for i in `seq 1 1100`
do
    wget -O $i.jpg https://s.akb48.co.jp/members/profile/renew200410/$i.jpg &
done
wait
find . -empty | xargs rm
