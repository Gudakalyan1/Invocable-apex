public with sharing class deleteOpportunity {
    @InvocableMethod(label = 'DeleteOpportunity')
    public static void deleteOpportunity(List<Account> accounts) {
        Set<Id> inactiveAccountIds = new Set<Id>();
        List<Opportunity> opportunitiesToDelete = new List<Opportunity>();

        for (Account acc : accounts) {
            if (acc.Account_Status__c != 'Active') {
                inactiveAccountIds.add(acc.Id);
            }
        }

        List<Opportunity> closedWonOpportunities = [
            SELECT Id, Name, AccountId 
            FROM Opportunity 
            WHERE AccountId IN :inactiveAccountIds 
                AND StageName = 'Closed Won'
        ];

        for (Opportunity opp : closedWonOpportunities) {
            opportunitiesToDelete.add(opp);
        }

        if (!opportunitiesToDelete.isEmpty()) {
            delete opportunitiesToDelete;
        }
    }
}
