@isTest
private class animlCalloutTest {

    @isTest
    static void obtainAnimalsByIdTest () {
        List<Animal__c> animalList = [SELECT Id, Id__c, Name FROM Animal__c WHERE Name LIKE '%test animal%'];
        System.debug('animalList' + animalList);
        Set<Id> idsSet = new Set<Id>();
        for(Animal__c a : animalList) {
            idsSet.add(a.Id);
        }
        Test.setMock(HttpCalloutMock.class, new obtainAnimalsByIdCalloutMock());
        Animal__c animal = new Animal__c(Name='test animal', Id__c = '1');
        insert animal;
        Test.startTest();
        animalCallout.obtainAnimalsById(idsSet);
        Test.stopTest();
        List<Animal__c> updatedAnimals = [SELECT Id, Id__c, Name FROM Animal__c WHERE Id__c = '1'];
        System.assertEquals('cat', updatedAnimals[0].Name);
    }


    @isTest
    static void getAnimalByExternalIdTest() {
        Test.setMock(HttpCalloutMock.class, new obtainAnimalsByIdCalloutMock());
        Test.startTest();
        Animal__c animal = animalCallout.getAnimalByExternalId('1');
        Test.stopTest();
        System.assertEquals('cat', animal.name);
    }

    @isTest
    static void checkAnimalTest() {
        Test.setMock(HttpCalloutMock.class, new obtainAnimalsByIdCalloutMock());
        Test.startTest();
        animalCallout.checkAnimal('1', 'cat', 'meow', 'fish');
        Test.stopTest();
        Animal__c animal = [SELECT Eats__c FROM Animal__c WHERE Id__c = '1'];
        System.assertEquals('fish', animal.Eats__c);

    }
}
