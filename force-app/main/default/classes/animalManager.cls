@RestResource(urlMapping='/Animal__c/*')
global without sharing class animalManager {

    @HttpGet
    global static List<Animal__c> getAnimalByExternalId() {
        RestRequest request = RestContext.request;
        String animalId = request.requestURI.substring(
        request.requestURI.lastIndexOf('/')+1);
        if(animalId != '') {
            List<Animal__c> animal =  [SELECT Id, Id__c, Name, Eats__c, Says__c FROM Animal__c
                        WHERE Id__c = :animalId OR Id = : animalId];
            return animal;
        }
        List<Animal__c> animalsList = [SELECT Id, Id__c, Name, Eats__c, Says__c FROM Animal__c];
        return animalsList;
    }


    @HttpPost
    global static void createAnimal(String id, String name, String says,String eats) {
        RestRequest request = RestContext.request;

        List<Animal__c> existingAnimals = [SELECT Id__c, Name,Eats__c, Says__c FROM Animal__c WHERE Id__c = : id];
        System.debug('existingAnimals' + existingAnimals);
        if(!existingAnimals.isEmpty()) {
                for(Animal__c a : existingAnimals) {
                    a.Name = name;
                    a.Eats__c = eats;
                    a.Says__c = says;
            }
            update existingAnimals;
        } else {
            animalCallout.checkAnimal(id, name, says, eats);
        }
        
    }
}
