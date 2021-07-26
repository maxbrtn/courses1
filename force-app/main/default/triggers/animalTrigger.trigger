trigger animalTrigger on Animal__c (after insert) {
    Set<Id> idsList = new Set<Id>();

    for(Animal__c a : Trigger.new) {
        idsList.add(a.Id);
    }

    if (idsList.size() > 0) {
        animalCallout.obtainAnimalsByIdAsync(idsList);
    }
}