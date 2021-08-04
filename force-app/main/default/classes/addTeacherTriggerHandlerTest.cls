@isTest
private class addTeacherTriggerHandlerTest {

    @testSetup static void setup() {
        List<Faculty__c> facultiesList = new List<Faculty__c>();
        for(Integer i = 0; i < 5; i++) {
            Faculty__c f = new Faculty__c();
            f.Name = 'test faculty - ' + i;
            facultiesList.add(f);
        }
        insert facultiesList;
    }

    @isTest 
    static void testNotEmptyFacultiesList() {
        Set<Id> idsSet = new Set<Id>();
        List<Faculty__c> quiredFaculties = [SELECT Id, Name FROM Faculty__c WHERE Name LIKE '%test faculty -%'];
        for(Faculty__c f : quiredFaculties) {
            idsSet.add(f.Id);
        }
        addTeacherTriggerHandler handlerItem = new addTeacherTriggerHandler();
        handlerItem.insertValueToFacultyTeachersField(idsSet);
        List<Faculty__c> facultiesList = [SELECT Id, Name FROM Faculty__c WHERE Id IN : idsSet];
        System.assertEquals(idsSet.size(), facultiesList.size());
    }
}
