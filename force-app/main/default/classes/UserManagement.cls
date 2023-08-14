public with sharing class UserManagement {
    @Future
    public static void deactiveUser( list<Id> DeactivatedUserId) {
        map<Id,Opportunity> Managers =new map<Id,Opportunity> ();
        list<Opportunity> OpptoUpdate = new list<Opportunity> ();
        list<User> DeactivatedUser = [Select Id,ManagerId ,Name,IsActive From User 
        where Id IN :DeactivatedUserId AND IsActive!=True ];
        for(User ur :DeactivatedUser){
            if(ur.IsActive !=True){
                DeactivatedUserId.add(ur.Id);

            }
        }
        Map<Id,User>inactiveusers =new map<Id,User>([Select Id,Name,IsActive,ManagerId From User Where Id IN :DeactivatedUserId]);
        list<Opportunity> userOpenOpp =[select Id,Name,OwnerId,StageName From Opportunity 
        where OwnerId IN :DeactivatedUserId And (StageName !='Closed Won' OR StageName != 'Closed Lost')];

        For(Opportunity opp :userOpenOpp){
            if(userOpenOpp!=null){
             User us = inactiveusers.get(opp.OwnerId);
             if(inactiveusers.containsKey(opp.OwnerId)&inactiveusers !=null){
                opp.OwnerId =us.ManagerId ;
               OpptoUpdate.add(opp);

             }

            }
        }
        try {
            if(!OpptoUpdate.isEmpty()){
                update OpptoUpdate ;
            }
            
        } catch (Exception e) {
            system.debug('Errors Occured'+e);
            
        }

    }
}