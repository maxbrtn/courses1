trigger createdDate on Teacher__c (before insert) {
    for(Teacher__c t: Trigger.new) {
        t.Created_Time_custom__c = System.now();
    }
}