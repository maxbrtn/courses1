public class insertionQue implements Queueable{
    public Id facultyId;
    
    public void execute(QueueableContext context) {
        if (facultyId == null){ 
            Faculty__c f = new Faculty__c(Name='Dance1');
            insert f; 
            facultyId = f.Id;
            System.enqueueJob(this);
        } else if (facultyId != null){ 
            Teacher__c t = new Teacher__c(Faculty__c = facultyId, Name = 'TestDance1');
            insert t;
        }
    }
}
