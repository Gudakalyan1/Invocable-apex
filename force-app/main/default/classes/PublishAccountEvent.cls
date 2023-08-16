public with sharing class PublishAccountEvent {
    public static void PublishAccount(List<Account> newAccounts) {
        Set<Id> accIds = new Set<Id>();
        List<Account__e> publishAcc = new List<Account__e>();
        
        for (Account acc : newAccounts) {
            if (acc.Account_Status__c == 'Active') {
                accIds.add(acc.Id);
            }
        }
        
        List<Account> activeAcc = [SELECT Id, Name, Account_Status__c, End_Date__c FROM Account WHERE Id IN :accIds];
        
        for (Account acc : activeAcc) {
            Account__e accountE = new Account__e();
            accountE.AccountId__c = acc.Id;
            accountE.Account_Status__c = acc.Account_Status__c;
            accountE.Opp_Name__c = acc.Name + ' Platform event'; 
            accountE.Close_date__c = acc.End_Date__c;
            publishAcc.add(accountE);
        }
        
        List<Database.SaveResult> results = EventBus.publish(publishAcc);
        
        for (Database.SaveResult sr : results) {
            if (sr.isSuccess()) { 
                System.debug('Event has been published successfully');
                System.debug('Result' + sr);
            } else {
                for (Database.Error err : sr.getErrors()) { 
                    System.debug('Errors' + err.getStatusCode() + '-' + err.getMessage());
                }
            }
        }
    }
}
