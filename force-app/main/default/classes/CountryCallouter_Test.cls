@isTest
public class CountryCallouter_Test {
    @isTest 
    public static void testCalloutWithStaticResources() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('CountryCalloutMock');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        Test.startTest();
            CountryCallouter.callExtermalAPI();
        Test.stopTest();

        List<Country__c> results = [SELECT Id , Name FROM Country__c ];

        System.assert(!results.isEmpty());
    }
}