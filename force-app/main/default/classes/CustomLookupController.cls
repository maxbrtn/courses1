public with sharing class CustomLookupController {
    
    @AuraEnabled(cacheable = true)
    public static List<SObject> findRecords(String searchKey, String objectName, String searchField){
        String key = '%' + searchKey + '%';
        String QUERY = 'Select Id, '+searchField+' From '+objectName +' Where '+searchField +' LIKE :key';
        List<SObject> sObjectList = Database.query(QUERY);
        return sObjectList;
    }

    @AuraEnabled(cacheable = true)
    public static List<SObject> getUniversities(String searchField, String objectName) {
        String QUERY = 'Select Id, '+searchField+' From '+objectName +' LIMIT 5';
        List<SObject> sObjectList = Database.query(QUERY); 
        return sObjectList;
    }
}
