public with sharing class CountryTriggerHandlerHelper {
    public static void updateLeads(Map<Id, Country__c> newMap, List<Country__c> oldList) {  
        List<Id> idsOfUpdated = new List<Id>();
        for (Country__c oldCountry : oldList) {
            if (oldCountry.Name != newMap.get(oldCountry.id).Name) {
                idsOfUpdated.add(oldCountry.id);
            }
        }

        List<Lead> leadsToUpdate = [SELECT Id, Country__c FROM Lead WHERE Country__c IN : idsOfUpdated];

        for (Lead leadToUpdate : leadsToUpdate) {
            leadToUpdate.Country = newMap.get(leadToUpdate.Country__c).Name;
        }

        update leadsToUpdate;
    }
}