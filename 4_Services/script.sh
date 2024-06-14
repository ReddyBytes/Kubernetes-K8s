i=1
while [ "$i" -le 20 ]; do
    curl nginx-clusterip:8081;
    i=$(( i+1 ))
done
