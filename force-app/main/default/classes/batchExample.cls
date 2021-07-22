global class batchExample implements Database.Batchable<sObject>{

    global database.querylocator start(Database.BatchableContext BC){
        List<Faculty__c> facultyList = new List<Faculty__c>();

        for(Integer i = 0; i < 200; i++) {
            facultyList.add(new Faculty__c(Name = 'batch Faculty ' + i));
        }

        insert facultyList;
        String likeStr = 'batch Faculty';
        return Database.getQueryLocator(
            'SELECT Id FROM Faculty__c WHERE Name LIKE \'%'+likeStr+'%\''  
        );
    }

    global void execute(Database.BatchableContext BC, List<Faculty__c> scope) {
        List<Teacher__c> teachersList = new List<Teacher__c>();

        for(Faculty__c faculty : scope) {
            for(Integer i = 0; i < 50; i++) {
                Teacher__c teacher = new Teacher__c();
                teacher.Faculty__c = faculty.Id;
                teacher.Name = 'Teacher ' + i;
                teachersList.add(teacher);
            }
        }
        
        insert teachersList;
    }
    global void finish(Database.BatchableContext BC) {}
}
