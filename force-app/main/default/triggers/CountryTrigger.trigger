trigger CountryTrigger on Country__c (after update) {
    if (Trigger.isAfter) {
        if (Trigger.isUpdate) {
            CountryTriggerHandler.onAfterUpdate(Trigger.newMap, Trigger.old);
        }
    }
}