public with sharing class CountryTriggerHandler {
    public static void onAfterUpdate(Map<Id, Country__c> newMap, List<Country__c> oldList) {
        CountryTriggerHandlerHelper.updateLeads(newMap, oldList);
    }
}