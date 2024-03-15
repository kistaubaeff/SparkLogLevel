package bdtc.spark;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.Objects;

@Setter
@Getter
@Data
@AllArgsConstructor
public class LogLevelHour {

    // Уровень логирования
    private String logLevel;

    // Час, в который произошло событие
    private int hour;

    /**
     * Constructs a new LogLevelHour instance with the default values.
     * The log level is set to "empty log" and the hour is set to 0
     */
    public LogLevelHour() {
        this.logLevel = "empty log";
        this.hour = 0;
    }

    /**
     * Compares this LogLevelHour object with the specified object for equality.
     * Returns true if the specified object is also a LogLevelHour and has the same hour and log level value
     * @param o the object to compare for equality
     * @return true if the objects are equal, false otherwise
     */
    @Override
    public boolean equals(final Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof LogLevelHour)) {
            return false;
        }
        LogLevelHour that = (LogLevelHour) o;
        return getHour() == that.getHour() && Objects.equals(getLogLevel(), that.getLogLevel());
    }


    /**
     * Returns a hash code value for the LogLevelHour object.
     * The hash code is generated based on the log level and hour values
     * @return the hash code value for the object
     */
    @Override
    public int hashCode() {
        return Objects.hash(getLogLevel(), getHour());
    }


    /**
     * Returns a string representation of the LogLevelHour object.
     * The string contains the log level and hour values enclosed in braces
     * @return a string representation of the object
     */
    @Override
    public String toString() {
        return "LogLevelHour{"
                + "logLevel='" + logLevel + '\''
                + ", hour=" + hour
                + '}';
    }



}
