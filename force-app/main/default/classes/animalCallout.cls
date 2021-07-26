global class animalCallout {
    public static void obtainAnimalsById(Set<Id> idsSet) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        List<Animal__c> externalIdsList = [SELECT Id__c FROM Animal__c WHERE Id IN : idsSet];
        List<Animal__c> animalsToUpdate = new List<Animal__c>();

        for(Animal__c extId : externalIdsList) {
            request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + extId.Id__c);
            request.setMethod('GET');
            HttpResponse response = http.send(request);
            if (response.getStatusCode() == 200) {
                JSON2Apex animal = new JSON2Apex().parse(response.getBody());
                Animal__c newAnimal = new Animal__c();
                if(animal.Animal.name == '') {
                    newAnimal.Id = extId.id;
                    newAnimal.Id__c = null;
                    animalsToUpdate.add(newAnimal);
                } else {
                    newAnimal.Id__c = animal.Animal.id;
                    newAnimal.Id = extId.id;
                    newAnimal.Name = animal.Animal.name; 
                    newAnimal.Eats__c = animal.Animal.eats; 
                    newAnimal.Says__c = animal.Animal.says;
                    animalsToUpdate.add(newAnimal);
                }
                
            } else {
                System.debug('Code ' + response.getStatusCode() + '. Message:' + response.getStatus());
            }
        }

        try {
            update animalsToUpdate;
        } catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
        
    }

    @future(callout=true)
    public static void obtainAnimalsByIdAsync(Set<Id> idsSet) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        List<Animal__c> externalIdsList = [SELECT Id__c FROM Animal__c WHERE Id IN : idsSet];
        List<Animal__c> animalsToUpdate = new List<Animal__c>();

        for(Animal__c extId : externalIdsList) {
            request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + extId.Id__c);
            request.setMethod('GET');
            HttpResponse response = http.send(request);
            if (response.getStatusCode() == 200) {
                JSON2Apex animal = new JSON2Apex().parse(response.getBody());
                Animal__c newAnimal = new Animal__c();
                if(animal.Animal.name == '') {
                    newAnimal.Id = extId.id;
                    newAnimal.Id__c = null;
                    animalsToUpdate.add(newAnimal);
                } else {
                    newAnimal.Id__c = animal.Animal.id;
                    newAnimal.Id = extId.id;
                    newAnimal.Name = animal.Animal.name; 
                    newAnimal.Eats__c = animal.Animal.eats; 
                    newAnimal.Says__c = animal.Animal.says;
                    animalsToUpdate.add(newAnimal);
                }
                
            } else {
                System.debug('Code ' + response.getStatusCode() + '. Message:' + response.getStatus());
            }
        }

        try {
            update animalsToUpdate;
        } catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
    }

}
