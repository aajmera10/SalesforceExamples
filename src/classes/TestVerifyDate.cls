@isTest
public class TestVerifyDate {
    @isTest
    static void testdate(){
        date d1 = Date.newInstance(2018, 2, 17);
        date d2 = Date.newInstance(2019, 2, 17);
        date d3 = Date.newInstance(2018, 2, 28);
        date d4 = Date.newInstance(2018, 8, 17);
        date d5 = Date.newInstance(1960, 2, 17);
        date d6 = Date.newInstance(1960, 2, 17);

        VerifyDate.CheckDates(d1,d2);
        VerifyDate.CheckDates(d1,d3);
    }
    
}