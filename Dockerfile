FROM zoltannz/hadoop-ubuntu:2.8.1


ENV PATH=$PATH:/usr/local/hadoop/bin/
ENV SPARK_HOME=/spark-2.3.1-bin-hadoop2.7
ENV HADOOP_CONF_DIR=$HADOOP_PREFIX/etc/hadoop
ENV PATH=$PATH:/spark-2.3.1-bin-hadoop2.7/bin
ENV PATH=$PATH:/sqoop-1.4.7.bin__hadoop-2.6.0/bin


RUN apt-get update -y && apt-get install -y postgresql postgresql-contrib wget

RUN wget --no-check-certificate https://archive.apache.org/dist/sqoop/1.4.7/sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz \
    && tar xvzf sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz \
    && rm sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz

RUN wget --no-check-certificate https://jdbc.postgresql.org/download/postgresql-42.2.5.jar \
    && cp postgresql-42.2.5.jar sqoop-1.4.7.bin__hadoop-2.6.0/lib/

RUN wget --no-check-certificate https://archive.apache.org/dist/spark/spark-2.3.1/spark-2.3.1-bin-hadoop2.7.tgz \
    && tar xvzf spark-2.3.1-bin-hadoop2.7.tgz \
    && rm spark-2.3.1-bin-hadoop2.7.tgz

RUN apt-get update -y && \
    apt-get install -y postgresql postgresql-contrib


COPY bootstrap.sh /usr/local/bin/bootstrap.sh
COPY /target/lab2-1.0-SNAPSHOT-jar-with-dependencies.jar /tmp/

RUN chmod +x /usr/local/bin/bootstrap.sh

ENTRYPOINT ["/bin/bash", "/usr/local/bin/bootstrap.sh"]
