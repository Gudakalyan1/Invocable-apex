public with sharing class PublishAccountEvent {
    public static void PublishAccount(list<Account>NewAccounts){
        set<Id>AccId = new set<Id> ();
        list<Account__e> publishAcc = new list<Account__e> ();
        for(Account Acc :NewAccountsA){
            if(Acc.Account_Status__c=='Active'){
                AccId.add(Acc);
            }
        }
        list<Account> Account_Status__c	 =[select Id,Name,Account_Status__c From Account Where Id IN : AccId];

        if(ActiveAcc!=null){
            for(Account Acc : Account_Status__c	){
                Account__e accountE = new Account__e ();
                accountE.AccountId__c=Acc.Id;
                accountE.Account_Status__c=Acc.Account_Status__c;
                publishAcc.add(accountE);
            }
        }
        list<database.SaveResult> result = EventBus.publish(publishAcc);

        for(databse.SaveResult sr :result){
            if (sr.IsSuccess()) {
                system.debug('Event has been published Sucessfully');
                System.debug('Result'+sr);
            }
           else {
            for(Database.Error er: sr.getErrors())
            sytem.debug('Errors' + er.getStatusCode() + '-' +er.getMessage());
           } 
        }
    }


}