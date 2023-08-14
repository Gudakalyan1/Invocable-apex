public with sharing class deleteOpportunity {
    @InvocableMethod(label='DeleteOpportunity')
set<Id> AccId = new set<Id> ();
list<Opportunity> deleteOpp = new list<Account> ();
map<Id,Opportunity> oppmap= new map<Id,Opportunity>();
    public static void deleteOpportunity(list<Account>Accounts) {
        for(Account Acc :Accounts){
            if (Acc.Account_Status__c!='Active') {
               AccId.add(Acc.Id) ;  
            }
        }
        list<Opportunity> opplist =[select Id,Name,AccountId From Opportunity where AccountId IN :AccId];
        for(Opportunity opp :opplist){
            oppmap.put(opp.AccountId,opp);
            
        }
        FOR(Account acc :Accounts){
            if(oppmap !=null){
                Opportunity opps = oppmap.get(acc.Id);
                deleteOpp.add(opps.Id);
            
        }

    }
    if(!deleteOpp !=isEmpty()){
        Delete deleteOpp;
    }
    }
}