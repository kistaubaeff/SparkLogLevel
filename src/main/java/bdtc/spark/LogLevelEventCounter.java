package bdtc.spark;

import lombok.extern.slf4j.Slf4j;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Encoders;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.functions;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeFormatterBuilder;
import java.util.Arrays;
import java.util.Locale;

import static java.time.temporal.ChronoField.YEAR;

@Slf4j
public class LogLevelEventCounter {

    protected LogLevelEventCounter() {
        throw new UnsupportedOperationException();
    }

    private static final int DEFAULT_YEAR = 2018;

    // Формат времени логов - н-р, 'Oct 26 13:54:06'
    private static DateTimeFormatter formatter = new DateTimeFormatterBuilder()
            .appendPattern("MMM dd HH:mm:ss")
            .parseDefaulting(YEAR, DEFAULT_YEAR)
            .toFormatter(Locale.US);

    /**
     * Функция подсчета количества логов разного уровня в час.
     * Парсит строку лога, в т.ч. уровень логирования и час, в который событие было зафиксировано.
     * @param inputDataset - входной DataSet для анализа
     * @return результат подсчета в формате JavaRDD
     */
    public static JavaRDD<Row> countLogLevelPerHour(final Dataset<String> inputDataset) {
        Dataset<String> words = inputDataset.map(s -> Arrays.toString(s.split("\n")), Encoders.STRING());

        Dataset<LogLevelHour> logLevelHourDataset = words.map(s -> {
            String[] logFields = s.split(",");
            LocalDateTime date = LocalDateTime.parse(logFields[2], formatter);
            return new LogLevelHour(logFields[1], date.getHour());
            }, Encoders.bean(LogLevelHour.class))
                .coalesce(1);

        // Группирует уровню логирования
        Dataset<Row> t = logLevelHourDataset.groupBy("logLevel")
                .count()
                .toDF("logLevel", "count")
                // сортируем по количеству логов за сутки
                .sort(functions.asc("logLevel"));
        log.info("===========RESULT=========== ");
        t.show();
        return t.toJavaRDD();
    }

}
