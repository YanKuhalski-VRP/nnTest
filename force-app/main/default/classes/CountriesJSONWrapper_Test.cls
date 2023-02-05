@isTest
public class CountriesJSONWrapper_Test {
    @isTest
    private static void testWrapperPerse() {
        StaticResource staticResource = [
            SELECT Id, Body	
            FROM StaticResource 
            WHERE Name = 'CountryCalloutMock'
            LIMIT 1
        ];
        String jsonBody =EncodingUtil.base64Decode(EncodingUtil.base64Encode(staticResource.Body)).toString();
        List<CountriesJSONWrapper> result = CountriesJSONWrapper.parse(jsonBody);
		System.assert(result.size() > 0);
        CountriesJSONWrapper firstRec = result[0];
		System.assert(firstRec.name == 'Germany');
		System.assert(firstRec.alpha2Code == 'DE');
		System.assert(firstRec.alpha3Code == 'DEU');
		System.assert(firstRec.regionalBlocs.size() > 0);
		System.assert(firstRec.regionalBlocs[0].acronym == 'EU');
    }
}	