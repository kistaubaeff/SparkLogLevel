package bdtc.spark;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Setter
@Getter
@Data
@AllArgsConstructor
@NoArgsConstructor
public class LogLevelHour {
    // Уровень логирования
    private String logLevel;

    // Час, в который произошло событие
    private int hour;
}
