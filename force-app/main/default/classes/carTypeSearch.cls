public with sharing class carTypeSearch {
	@AuraEnabled
    
    public static List<car_Type__C> getCarTypes()
    {
        return[select Id,Name from car_Type__C];
    }
}