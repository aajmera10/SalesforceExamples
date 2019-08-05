trigger TestDuplicateContactTrigger on Contact (before insert) {
Set<String> newNameSet = new Set<String>();
    Set<String> newEmailSet = new Set<String>();
    Set<String> dbNameSet = new Set<String>();
    Set<String> dbEmailSet = new Set<String>();

    for(Contact con:trigger.new){
        newNameSet.add(con.Name);
        newEmailSet.add(con.Email);
    }
    for(Contact conlea : [Select id, Name, email From contact Where email IN: dbEmailSet OR Name IN: dbNameSet]){
        dbNameSet.add(conlea.Name);
        dbEmailSet.add(conlea.Email);
    }
    for(Contact newCon : trigger.new){

        if(dbNameSet.contains(newCon.Name) && dbEmailSet.Contains(newCon.Email))
            newCon.addError('You are inserting Duplicate Contact');
    }
}