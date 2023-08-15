trigger UserManagementTrigger on User (after update) {
    if (Trigger.isAfter && Trigger.isUpdate) {
        UpdateOppUser.updateOpp(Trigger.new);
    }
}
