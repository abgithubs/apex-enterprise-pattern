public class Accounts extends fflib_SObjectDomain
{
    public Accounts(List<Account> sObjectList) {
        super(sObjectList);
    }

    public class Constructor implements fflib_SObjectDomain.IConstructable
    {
        public fflib_SObjectDomain construct(List<SObject> sObjectList)
        {
            return new Accounts(sObjectList);
        }
    }
    
    public override void onBeforeInsert()
    {
    	handleAccountRecords(null);
    }
    
    public override void onBeforeUpdate(Map<Id, SObject> existingRecords)
    {
    	handleAccountRecords(existingRecords);
    }
    
    public void handleAccountRecords(Map<Id, SObject> existingRecords)
    {
    	for(Account acc : (List<Account>)Records)
    	{
    		if(existingRecords != null)
    		{
    			Account oldRecord = (Account) existingRecords.get(acc.Id);
    			if(oldRecord.Rating != null && acc.Rating != oldRecord.Rating)
    				acc.Rating.addError('You cannot modify the rating if added once');
    		}
    		acc.Description = 'Comment through trigger class';
    	}
    }
}