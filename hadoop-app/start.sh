# !/bin/bash

$HADOOP_PREFIX/bin/hadoop dfsadmin -safemode leave
sqoop import --connect "jdbc:postgresql://postgres:5432/hadoopdb?ssl=false" --username 'postgres' --password '1234' --table 'logging' --target-dir 'logs'

$SPARK_HOME/bin/spark-submit --class bdtc.spark.SparkSQLApplication --master local --deploy-mode client --executor-memory 1g --name wordcount --conf "spark.app.id=SparkSQLApplication" /tmp/lab2-1.0-SNAPSHOT-jar-with-dependencies.jar hdfs://127.0.0.1:9000/user/root/logs/ out

$HADOOP_PREFIX/bin/hadoop fs -cat hdfs://127.0.0.1:9000/user/root/out/part-00000


if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi