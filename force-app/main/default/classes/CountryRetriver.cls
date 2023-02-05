global without sharing class CountryRetriver  implements Schedulable {
    global void execute(SchedulableContext SC) {
        CountryCallouter.callExtermalAPI();
    }
}