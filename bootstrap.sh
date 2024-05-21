# !/bin/bash
if [[ $# -eq 0 ]]; then
    echo 'You should specify database name!'
    exit 1
fi


service postgresql start

sudo -u postgres psql -c "ALTER USER postgres PASSWORD '1234';"
sudo -u postgres psql -c "DROP DATABASE IF EXISTS $1;"
sudo -u postgres psql -c "CREATE DATABASE $1;"
sudo -u postgres -H -- psql -d $1 -c "CREATE TABLE logging (id BIGSERIAL PRIMARY KEY, logLevel int, datetime VARCHAR(20), other VARCHAR(256));"

: ${HADOOP_PREFIX:=/usr/local/hadoop}

$HADOOP_PREFIX/etc/hadoop/hadoop-env.sh

rm /tmp/*.pid

cd $HADOOP_PREFIX/share/hadoop/common ; for cp in ${ACP//,/ }; do  echo == $cp; curl -LO $cp ; done; cd -

sed s/HOSTNAME/$HOSTNAME/ /usr/local/hadoop/etc/hadoop/core-site.xml.template > /usr/local/hadoop/etc/hadoop/core-site.xml


service ssh start
$HADOOP_PREFIX/sbin/start-dfs.sh
$HADOOP_PREFIX/sbin/start-yarn.sh
$HADOOP_PREFIX/bin/hadoop dfsadmin -safemode leave

POSTFIX=("fccd8a5f3a42,rsyslogd-2007:,action -action 9- suspended, next retry is Fri Oct 26 13:54:37 2018 [v8.16.0 try http://www.rsyslog.com/e/2007 ]"
         "fccd8a5f3a42,rsyslogd:,rsyslogds userid changed to 107")
for i in {1..200}; do
    HOUR=$((RANDOM % 24))
    TWO_DIGIT_HOUR=$(printf "%02d" $HOUR)
    sudo -u postgres -H -- psql -d $1 -c "INSERT INTO logging (logLevel, datetime, other) VALUES ($((RANDOM % 8)),'Nov 10 $TWO_DIGIT_HOUR:13:56','${POSTFIX[$((RANDOM % ${#POSTFIX[@]}))]}');"
done



sqoop import --connect "jdbc:postgresql://127.0.0.1:5432/$1?ssl=false" --username 'postgres' --password '1234' --table 'logging' --target-dir 'logs'

spark-submit --class bdtc.spark.SparkSQLApplication --master local --deploy-mode client --executor-memory 1g --name wordcount --conf "spark.app.id=SparkSQLApplication" /tmp/lab2-1.0-SNAPSHOT-jar-with-dependencies.jar hdfs://127.0.0.1:9000/user/root/logs/ out

hadoop fs -cat hdfs://127.0.0.1:9000/user/root/out/part-00000
