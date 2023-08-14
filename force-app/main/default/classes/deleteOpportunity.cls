public with sharing class deleteOpportunity {
    @InvocableMethod(label= 'DeleteOpportunity')
    public static void deleteOpportunity(list<Account>Accounts){
        set<Id> AccId = new set<Id> ();
         list<Opportunity> deleteOpp = new list <Opportunity> ();
        for(Account Acc :Accounts){
            if (Acc.Account_Status__c!='Active') {
               AccId.add(Acc.Id) ;  
            }
       }
       list<Opportunity> Opplist =[select Id ,Name, AccountId From Opportunity where AccountId IN :AccId and StageName ='Closed Won	'];
       for(Opportunity Opp :Opplist){
        deleteOpp.add(Opp);
       }
       IF(!deleteOpp.IsEmpty()){
        delete deleteOpp;
      }

       }
       
    }