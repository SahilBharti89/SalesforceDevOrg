@isTest
public class TestTemperatureConverter {
    
    static testMethod void testTemp() {
        Decimal celsius = TemperatureConverter.FahrenheitToCelsius(70);
        System.assertEquals(21.11, celsius);
    }
    @isTest static void testBoilingPoint() {
        Decimal celsius = TemperatureConverter.FahrenheitToCelsius(212);        
        // Simulate failure
        System.assertEquals(0,celsius,'Boiling point temperature is not expected.');
    }
    
}