@isTest
private class animalManagerTest {
    @isTest
    static void getAnimalByExternalIdTest() {
        Test.startTest();
            RestRequest req = new RestRequest(); 
            RestResponse res = new RestResponse();
            req.requestURI = '/services/apexrest/Animal__c/2'; 
            req.httpMethod = 'GET';
            req.addHeader('Content-Type', 'application/json'); 
            RestContext.request = req;
            RestContext.response = res;
            
            List<Animal__c> animal = animalManager.getAnimalByExternalId();
            //вот тут вроде все хорошо, но когда запускается метод в animalManager, SOQl который делает выборку
            //возвращает пустой лист, так и не смог понять почему 
            System.debug('animal ' + animal);
        Test.stopTest();   
    }
}
