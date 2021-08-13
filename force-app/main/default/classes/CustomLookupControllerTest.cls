@isTest
private class CustomLookupControllerTest {

    @testSetup static void setup() {
        List<Univercity__c> univercitiesList = new List<Univercity__c>();
        for(Integer i = 0; i < 6; i++) {
            Univercity__c univercity = new Univercity__c();
            univercity.Name = 'Fake University ' + i;
            univercitiesList.add(univercity);
        }
        insert univercitiesList;    
    }

    @isTest
    public static void findRecordsIfExsist() {
        Univercity__c univercity = new Univercity__c(Name='Test Univercity');
        insert univercity;
        List<SObject> sObjectList = CustomLookupController.findRecords('Test', 'Univercity__c', 'Name');
        System.assertEquals(1, sObjectList.size());

    }
    
    @isTest
    public static void getUniversitiesList() { 
        List<SObject> sObjectList = CustomLookupController.getUniversities('Name', 'Univercity__c' );
        System.debug('sObjectList from test' + sObjectList);
        System.assertEquals(5, sObjectList.size());

    }
}
