global class animalAsyncUpdaterSched implements Database.Batchable<sObject>, Database.AllowsCallouts, Schedulable  {
    
    global database.querylocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator(
            'SELECT Id FROM Animal__c WHERE Id__c != null'  
        );
    }
    
    global void execute(Database.BatchableContext BC, List<Animal__c> scope) {
        Set<Id> idsList = new Set<Id>();

        for(Animal__c animal : scope) {
            idsList.add(animal.Id);
        }

        animalCallout.obtainAnimalsById(idsList);
    }

    global void finish(Database.BatchableContext BC) {}

    global void execute(SchedulableContext ctx) {
        animalAsyncUpdaterSched sched = new animalAsyncUpdaterSched ();
        database.executebatch(sched, 10);
    }
}
