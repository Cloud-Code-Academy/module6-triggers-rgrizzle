trigger OpportunityTrigger on Opportunity (before insert, before update, after insert, after update, before delete) {
OpportunityTriggerHandler handler = new OpportunityTriggerHandler();

    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            
        }
        if (Trigger.isUpdate) {
            handler.beforeUpdate(Trigger.new, Trigger.oldMap);
        }
        if (Trigger.isDelete) {
            handler.beforeDelete(Trigger.old);
            
        }
    } else if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            
        }
        if (Trigger.isUpdate) {
            handler.afterUpdate(Trigger.new, Trigger.oldMap);
        }
    }
}