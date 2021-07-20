trigger addedTeacherTrigger on Teacher__c (after insert, after update) {
    addTeacherTriggerHandler updateFaculty = new addTeacherTriggerHandler();

    if(Trigger.isInsert) {
        Set<Id> facultyIdsSet = new Set<Id>();
        for (Teacher__c teacher_i : Trigger.new) {
            if(teacher_i.Faculty__c != null) {
                facultyIdsSet.add(teacher_i.Faculty__c);
            }
        }
        updateFaculty.insertValueToFacultyTeachersField(facultyIdsSet);
    }

    if(Trigger.isUpdate) {
        Set<Id> facultyIdsSetNew = new Set<Id>();
        Set<Id> facultyIdsSetOld = new Set<Id>();
        //work with new teachers
        for (Teacher__c teacher_i : Trigger.new) {
            if(teacher_i.Faculty__c != null) {
                facultyIdsSetNew.add(teacher_i.Faculty__c);
            }
        }
        updateFaculty.insertValueToFacultyTeachersField(facultyIdsSetNew);

         //work with old teachers
        for (Teacher__c t_i : Trigger.old) {
            if(t_i.Faculty__c != null) {
                facultyIdsSetOld.add(t_i.Faculty__c);
            }
        }
        updateFaculty.updateValueToFacultyTeachersField(facultyIdsSetOld);
    }
}
