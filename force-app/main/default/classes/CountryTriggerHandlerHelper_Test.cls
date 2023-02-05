@isTest
private class CountryTriggerHandlerHelper_Test {
    @isTest
    private static void testLeasCountryUpdate() {
        Country__c newCountry = new Country__c();
        newCountry.Name = 'Test1';
        insert newCountry;

        Lead newLead = new Lead();
        newLead.LastName = 'Test';
        newLead.Company = 'Test';
        newLead.Status = 'Open - Not Contacted';
        newLead.Country__c = newCountry.Id;
        insert newLead;

        Test.startTest();
        newCountry.Name = 'Test2';
        update newCountry;
        Test.stopTest();

        Lead result = [SELECT Country FROM Lead WHERE Id =: newLead.Id];

        System.assertEquals( newCountry.Name, result.Country);
    }
}