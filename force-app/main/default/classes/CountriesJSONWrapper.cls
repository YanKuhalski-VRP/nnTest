public without sharing class CountriesJSONWrapper {
  
	public String name;
	public String alpha2Code;
	public String alpha3Code;
	public String capital;
	public String region;
	public String subregion;
	public List<RegionalBlocs> regionalBlocs;
	
	public class RegionalBlocs {
		public String acronym;
	}
	
	public static List<CountriesJSONWrapper> parse(String json) {
		return (List<CountriesJSONWrapper>) System.JSON.deserialize(json, List<CountriesJSONWrapper>.class);
	}
}