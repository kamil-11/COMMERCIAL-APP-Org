public class Enquirybatch implements Database.batchable<SObject>, Database.AllowsCallouts{
    public Database.queryLocator start(Database.batchableContext bc){
        string myQuery = 'SELECT ID,Name,physician__c, Medicine__c FORM Enquiry__c';
        return Database.getQueryLocator(myQuery);
    }

    public void execute(Database.batchableContext bc, List<Enquiry__c> ENQ){
        for (Enquiry__C enquiry : ENQ){
            enquiry.physician__c = 'N/A';
        }
    }

    public void finish(Database.batchableContext bc){
        system.debug('processed');
    }

}