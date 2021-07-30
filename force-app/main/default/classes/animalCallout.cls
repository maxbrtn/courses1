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

    
    public static Animal__c getAnimalByExternalId(String Id) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + id);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        Animal__c newAnimal = new Animal__c();
        if (response.getStatusCode() == 200) {
            JSON2Apex animal = new JSON2Apex().parse(response.getBody());
            newAnimal.Id__c = animal.Animal.id;
            newAnimal.Name = animal.Animal.name; 
            newAnimal.Eats__c = animal.Animal.eats; 
            newAnimal.Says__c = animal.Animal.says;
        }
        return newAnimal;
    }

    @future(callout=true)
    public static void checkAnimal(String id, String name, String says,String eats) {
        Animal__c sourceAnimal = getAnimalByExternalId(id);
        if(sourceAnimal.Id__c != '0') {
            sourceAnimal.Name = !String.isBlank(name) ? name : sourceAnimal.Name;
            sourceAnimal.Eats__c = !String.isBlank(eats) ? eats : sourceAnimal.Eats__c;
            sourceAnimal.Says__c = !String.isBlank(says) ? says : sourceAnimal.Says__c;
            insert sourceAnimal;
        } 

    }
        
            

}
