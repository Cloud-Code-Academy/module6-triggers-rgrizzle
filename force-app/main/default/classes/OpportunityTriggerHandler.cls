public with sharing class OpportunityTriggerHandler {

    public void beforeInsert(List<Opportunity> newOpps) {

    }

    public void beforeUpdate(List<Opportunity> newOpps, Map<Id, Opportunity>  oldOppMap) {
        //Validate Amount < 5000
        for (Opportunity opp : newOpps) {
            if (opp.Amount < 5000) {
                opp.addError('Opportunity amount must be greater than 5000');
            }
        }
        
        //Set Primary Contact to CEO
         // Collect Account Ids of updated opportunities
         Set<Id> accountIds = new Set<Id>();
     
         for (Opportunity opp : newOpps) {
             accountIds.add(opp.AccountId);
         }
            System.debug(accountIds);
         // Query for CEO contacts related to updated accounts
         Map<Id, Id> accountToContactMap = new Map<Id, Id>();
         for (Contact con : [SELECT Id, AccountId FROM Contact WHERE Title = 'CEO' AND AccountId IN :accountIds]) {
             accountToContactMap.put(con.AccountId, con.Id);
         }
         System.debug(accountToContactMap);
         // Update Primary Contact field on opportunities
         for (Opportunity opp : newOpps) {
             if (accountToContactMap.containsKey(opp.AccountId)) {
                 opp.Primary_Contact__c = accountToContactMap.get(opp.AccountId);
             }
         }

    }

    public void beforeDelete(List<Opportunity> deletedOpps){
        //Prevent Deletion on Closed Won Industry Opportunities
        for (Opportunity Opp : deletedOpps) {
                Opp.addError('Cannot delete closed opportunity for a banking account that is won');
        }
    }

    public void afterInsert(List<Opportunity> newOpps) {
    
    
    }

    public void afterUpdate(List<Opportunity> newOpps, Map<Id, Opportunity> oldOppMap) {
       
    }
    
    
}