public class addTeacherTriggerHandler {
    public void insertValueToFacultyTeachersField(Set<Id> facultyIdsSet) {
        if(!facultyIdsSet.isEmpty()) {
            List<Faculty__c> updatedFacultiesList = new List<Faculty__c>();
            for(Id facultyId : facultyIdsSet) {
                updatedFacultiesList.add(new Faculty__c(Id = facultyId, Last_created_teacher__c = System.now()));
            }
            update updatedFacultiesList;
        }
    }

    public void updateValueToFacultyTeachersField(Set<Id> facultyIdsSet) {
        if(!facultyIdsSet.isEmpty()) {
            //task with star....can't realize (((((((
        }
    }
}