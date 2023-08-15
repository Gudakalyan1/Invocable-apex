public class UpdateOppUser {
    public static void updateOpp(list<user>Users) {
        list<Id> UserId = new list<Id> ();
        map<Id,Id> ManagerIds = new map<Id,id> ();
        for(User us : Users){
            if(us.IsActive ==false){
                UserId.add(us.Id);
            }
        }
        list<User> Deactiveusers = [select Id,ManagerId From User where Id IN : UserId];
        for(User us : Deactiveusers){
            ManagerIds.put(us.Id,us.ManagerId);
        }
        UserManagement.UpdateOpps(UserId,ManagerIds);

    }
}