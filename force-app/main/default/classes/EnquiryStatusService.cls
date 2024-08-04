@RestResource(urlMapping='/Status/*')
global with sharing class EnquiryStatusService {
    @HttpPost
    global static void updateStatus()
    {
        String EnqId;
        RestRequest req = RestContext.request;
        Map<String,Object> JSONBody = (Map<String,Object>)(JSON.deserializeUntyped((req.requestBody).toString()));
        system.debug(JSONBody);
        //Map<String, String> body = (Map<String,String>) (inCommingJSON);
        EnqId = String.valueof(JSONBody.get('External Id'));
        Enquiry__c EnquiryRecord =[Select Id,Name,Medicine__c,Physician__c,Status__c FROM Enquiry__c WHERE Id =: EnqId];
        EnquiryRecord.Status__c = String.valueOf(JSONBody.get('Status'));
        system.debug(String.valueOf(JSONBody.get('Status')));
        Savepoint sp = Database.setSavepoint(); 
        try{
            update EnquiryRecord;
           }
           catch(exception e)
           {
            system.debug('test');
            Database.rollback(sp);
           } 
    }

}