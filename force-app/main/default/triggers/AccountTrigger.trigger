trigger AccountTrigger on Account (before insert,before update,after insert ,after update) {
    
    if(Trigger.isafter & Trigger.isupdate){
        AccountTriggerHandler.updateContacts(Trigger.new);
    }
    if(Trigger.isafter & Trigger.isinsert || Trigger.isupdate){
        AccountTriggerHandler.createContact(Trigger.new);

    }
    if(Trigger.isbefore & Trigger.isinsert){
      AccountTriggerHandler.createContact(Trigger.new);    
    }
    if(Trigger.isafter& Trigger.isupdate){
        AccountTriggerHandler.updateOpp(Trigger.new,Trigger.oldMap);
    }
    if(Trigger.isAfter & Trigger.isInsert){
        PublishAccountEvent.PublishAccount(Trigger.new);
    }
    

}