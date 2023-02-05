public class CountryCallouter {
    private static final String GET_METHOD_NAME = 'GET';
    private static final String ENDPOINT_ATRIBUTE = '?access_key=';
    private static final String APISETTING_NAME = 'Country Callouter';

    @future(callout=true)
    public static void callExtermalAPI () {
        
        //I would use custom settings but they are not deployable, so i case on test task i use mdt but i new that it is not good because i show my api key in meta)
        List<Callouts_Setting__mdt> calloutSettrings = [SELECT API_Key__c, End_Point__c FROM Callouts_Setting__mdt WHERE Label =: API_SETTING_NAME];

        if (!calloutSettrings.isEmpty()) { 
            Callouts_Setting__mdt settings = calloutSettrings[0];
            Http http = new Http();
            HttpRequest req = new HttpRequest();

            req.setEndpoint(settings.End_Point__c + '?access_key=' + settings.API_Key__c);
            req.setMethod(GET_METHOD_NAME);

            HttpResponse res;

            try {
                res =  http.send(req);
                List<CountriesJSONWrapper> wrapersList = CountriesJSONWrapper.parse(res.getBody());
                List<String> countryNames = new List<String>();
        
                for (CountriesJSONWrapper countryWrapperr :wrapersList) {
                    countryNames.add(countryWrapperr.name);
                }
        
                Map<String, Id> contryNameExternalIdMap = new Map<String, Id>();
        
                for (Country__c country : [SELECT Id , Name FROM Country__c WHERE Name IN: countryNames]) {
                    contryNameExternalIdMap.put(country.Name, country.Id);
                }
        
                List<Country__c> countriesToUpsert = new List<Country__c>();
        
                for (CountriesJSONWrapper countryWrapperr :wrapersList) {
                    Country__c newCountry = new Country__c();
                    if( contryNameExternalIdMap.containsKey(countryWrapperr.name)) {
                        newCountry.Id = contryNameExternalIdMap.get(countryWrapperr.name);
                    }
                    newCountry.Capital_City__c = countryWrapperr.capital;
                    newCountry.Country_Iso_Code_2__c = countryWrapperr.alpha2Code;
                    newCountry.Country_Iso_Code_3__c = countryWrapperr.alpha3Code;
                    newCountry.Name = countryWrapperr.name;
                    newCountry.Region__c = countryWrapperr.region;
                    if (countryWrapperr.regionalBlocs != null) {
                        newCountry.Region_Acronyms__c = countryWrapperr.regionalBlocs[0].acronym;
                    }
                    newCountry.Subregion__c = countryWrapperr.subregion;
                    countriesToUpsert.add(newCountry);
                }
        
                upsert countriesToUpsert;

            } catch(System.CalloutException e) {
                System.debug('Callout error: '+ e); 
                System.debug(res.toString());
            }
        }
    }
}