package bdtc.spark;

import org.junit.Test;

import static org.junit.Assert.*;


public class LogLevelHourTest {

    @Test
    public void testEqualsSameObject() {
        LogLevelHour logLevelHour = new LogLevelHour("DEBUG", 5);
        assertEquals(logLevelHour, logLevelHour);
    }

    @Test
    public void testEqualsSameTypeAndValues() {
        LogLevelHour logLevelHour1 = new LogLevelHour("DEBUG", 5);
        LogLevelHour logLevelHour2 = new LogLevelHour("DEBUG", 5);
        assertEquals(logLevelHour1, logLevelHour2);
    }

    @Test
    public void testEqualsDifferentTypes() {
        LogLevelHour logLevelHour = new LogLevelHour("DEBUG", 5);
        String string = "DEBUG,5";
        assertNotEquals(logLevelHour, string);
    }

    @Test
    public void testEqualsDifferentValues() {
        LogLevelHour logLevelHour1 = new LogLevelHour("INFO", 3);
        LogLevelHour logLevelHour2 = new LogLevelHour("ERROR", 3);
        assertNotEquals(logLevelHour1, logLevelHour2);
    }

    @Test
    public void testEqualsNullObject() {
        LogLevelHour logLevelHour = new LogLevelHour("DEBUG", 5);
        assertNotEquals(null, logLevelHour);
    }

    @Test
    public void testEquals_CompareWithDifferentType() {
        LogLevelHour logLevelHour = new LogLevelHour("DEBUG", 5);
        Object obj = new Object();
        assertNotEquals(logLevelHour, obj);
    }



    @Test
    public void testHashCode() {
        LogLevelHour logLevelHour = new LogLevelHour("ERROR", 10);
        LogLevelHour sameLogLevelHour = new LogLevelHour("ERROR", 10);
        assertEquals(logLevelHour.hashCode(), sameLogLevelHour.hashCode());
    }

    @Test
    public void testToString() {
        LogLevelHour logLevelHour = new LogLevelHour("INFO", 2);
        assertEquals("LogLevelHour{logLevel='INFO', hour=2}", logLevelHour.toString());
    }

    @Test
    public void testSetLogLevel() {
        LogLevelHour logLevelHour = new LogLevelHour();
        logLevelHour.setLogLevel("WARN");
        assertEquals("WARN", logLevelHour.getLogLevel());
    }

    @Test
    public void testSetHour() {
        LogLevelHour logLevelHour = new LogLevelHour();
        logLevelHour.setHour(8);
        assertEquals(8, logLevelHour.getHour());
    }

    @Test
    public void testGetHour() {
        LogLevelHour logLevelHour = new LogLevelHour("DEBUG", 3);
        assertEquals(3, logLevelHour.getHour());
    }

//    .

    @Test
    public void testConstructor() {
        LogLevelHour logLevelHour = new LogLevelHour("ERROR", 4);
        assertEquals("ERROR", logLevelHour.getLogLevel());
        assertEquals(4, logLevelHour.getHour());
    }

    @Test
    public void testGetLogLevel() {
        LogLevelHour logLevelHour = new LogLevelHour("DEBUG", 7);
        assertEquals("DEBUG", logLevelHour.getLogLevel());
    }



}