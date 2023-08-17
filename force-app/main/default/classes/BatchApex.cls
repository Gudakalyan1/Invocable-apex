//Hi everyone I have got a scenario where I need to write a batch Apex to close
// all the pending opportunities of previous month, batch should schedule on every hour by using schedulable interface

Global class BatchApex Implements Database.Batchable<SObject>{
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String Query = 'select Id ,name ,CloseDate,StageName from Opportunity where CloseDate =LAST_N_QUARTERS:2';
        system.debug('Returned Opportunities:' +Query);
        return Database.getQueryLocator(Query);
    }
    global void execute(Database.BatchableContext bc ,List<Opportunity> scope1){
        list<Opportunity> updateOpp = new List<Opportunity>();
        system.debug('scope-->:'+scope1);
        for(Opportunity opp : scope1){
            if(opp.StageName != 'Closed Won' && opp.StageName !='Closed Lost'){
                opp.StageName ='Closed Lost';
                updateOpp.add(opp);

            }
        }
        if(!updateOpp.isEmpty()){
            try {
                Update updateOpp;
            } catch (Exception ex) {
                System.debug('Erros :'+ ex);
            }
        }
    }
    public void finish(Database.BatchableContext bc){
        system.debug('Im Finished and  excuted the batch');
    }
}