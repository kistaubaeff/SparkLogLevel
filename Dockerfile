
FROM zoltannz/hadoop-ubuntu:2.8.1


RUN wget --no-check-certificate https://archive.apache.org/dist/sqoop/1.4.7/sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz \
    && tar xvzf sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz \
    && rm sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz

RUN wget --no-check-certificate https://jdbc.postgresql.org/download/postgresql-42.2.5.jar \
    && cp postgresql-42.2.5.jar sqoop-1.4.7.bin__hadoop-2.6.0/lib/

RUN wget --no-check-certificate https://archive.apache.org/dist/spark/spark-2.3.1/spark-2.3.1-bin-hadoop2.7.tgz \
    && tar xvzf spark-2.3.1-bin-hadoop2.7.tgz \
    && rm spark-2.3.1-bin-hadoop2.7.tgz


COPY ./hadoop-app/bootstrap.sh /usr/local/bin/start.sh
COPY /target/lab2-1.0-SNAPSHOT-jar-with-dependencies.jar /tmp/

RUN chmod +x /usr/local/bin/start.sh

