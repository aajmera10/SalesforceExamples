@istest
public class AnimalLocatorTest {
    @istest
    public static void Testre(){
        Test.SetMock(HttpCalloutMock.class, new AnimalLocatorMock());
        String response = AnimalLocator.getAnimalNameById(1);
        String expectedValue = 'chicken';
        System.assertEquals(expectedValue, response);
    }
}