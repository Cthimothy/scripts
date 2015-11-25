#!/bin/bash
# # Generate current down- and upstream speed

exec 1> >(logger -s -t $(basename $0)) 2>&1

# Re-write this mess in something else
# Nadger plot times
# Add code to pritn averages and stats

if [ ! -d "/tmp/bw/" ]; then
    mkdir /tmp/bw/
fi

# Delete plot images older than 6 hours (720 minutes)
find /var/www/html/apps/flask/bwmon/static/images/*.png -mmin +720 -exec rm {} \;

t=$(mktemp)
echo "[bwmon.sh] Running speedtest"
/usr/local/bin/speedtest > ${t}
# d=$(date +"%H:%M_%d-%m-%Y")
plot_date=$(date +"%d%m%y%H%M")
plot_time=$(date +"%H%M")
echo -n "${plot_time} " >> /tmp/bw/bd.tmp; grep ^Download ${t} | sed -e "s/^Download: //" -e "s/Mbit\/s//" >> /tmp/bw/bd.tmp
#echo -n "${plot_time} " >> /tmp/bw/bu.tmp; grep ^Upload ${t} | sed -e "s/^Upload: //" -e "s/Mbit\/s//" >> /tmp/bw/bu.tmp
rm ${t}
tail -n 9 < /tmp/bw/bd.tmp > /tmp/bw/bw_down
#tail -n 10 < /tmp/bw/bu.tmp > /tmp/bw/bw_up

echo "[bwmon.sh] Plotting graph"
gnuplot << EOF
    set terminal pngcairo font "arial,10" size 500,500
    set output '/tmp/bw/bw_down.svg'
    set style fill solid 1.00 border 0
    set xlabel "Time"
    set ylabel "MB/s"
    set style histogram
    set style data histogram
    set title "Broadband Speed"
    plot "/tmp/bw/bw_down" using 2:xtic(1) linecolor rgb "#377ba8" notitle
EOF

echo "[bwmon.sh] converting graph to png and moving to static"
convert /tmp/bw/bw_down.svg /var/www/apps/flask/bwmon/static/images/bw_down$plot_date.png

# gnuplot << EOF
#     set terminal pngcairo font "arial,10" size 500,500
#     set output '/tmp/bw/bw_up.svg'
#     set style fill solid 1.00 border 0
#     set style histogram
#     set style data histogram
#     set title "Bandwidth usage UPSTREAM"
#     plot "/tmp/bw/bw_up" using 2:xtic(1) linecolor rgb "#0000FF"
# EOF
#convert /tmp/bw/bw_up.svg /var/www/html/bw_up.png
