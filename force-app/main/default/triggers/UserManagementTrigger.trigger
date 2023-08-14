trigger UserManagementTrigger on User (before insert,After Update) {
    if(Trigger.isAfter & Trigger.isUpdate){
        UserManagement.deactiveUser(Trigger.new);
    }

}