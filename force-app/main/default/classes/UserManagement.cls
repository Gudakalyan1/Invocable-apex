public class UserManagement {
    @Future
    public static void UpdateOpps (list<Id> userId ,Map<Id,Id> managerIds){
        list<Opportunity>Opptoupdate = new list<Opportunity> ();
        List<Opportunity> Opps =[select Id ,OwnerId ,StageName From Opportunity 
        where OwnerId IN :userId AND Stagename !='ClosedWon'];
        for(Opportunity opp : Opps){
            Id manager = ManagerIds.get(opp.OwnerId);
            opp.OwnerId = manager;
            Opptoupdate.add(opp);

        }
        if(!Opptoupdate.isEmpty()){
            try {
                update Opptoupdate;
            } catch (Exception ex) {
                system.debug('Errors'+ex);
                
            }
        }
    }
}