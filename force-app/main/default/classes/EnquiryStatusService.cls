/* 
@author	Kamil kamran
@date	05/08/2024
@group	EQNUIRY_SYNCHRONIZATIONS
@description Enquiry Status WebService used for Sync from Medical App. In-line deserializing functionality for small fetching and storing 
             fetching new chnaged status from medical org and update the status on the same record locally.   
    @version 1.0
     */
    // Status :-) Deployed
@RestResource(urlMapping='/Status/*')
global with sharing class EnquiryStatusService {
    @HttpPost
    global static void updateStatus()
    {
        String EnqId;
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        Savepoint sp;
        Map<String,Object> JSONBody = (Map<String,Object>)(JSON.deserializeUntyped((req.requestBody).toString()));
        system.debug(JSONBody);
        //Map<String, String> body = (Map<String,String>) (inCommingJSON);
        try{
        EnqId = String.valueof(JSONBody.get('External Id'));
        /*This query will later be used With SECURITY_ENFORCED Clause to prevent
           to prevent in accessible data when the users are available in both orgs
           However for this use-case curently it is not required.     
        */
        Enquiry__c EnquiryRecord =[Select Id,Name,Medicine__c,Physician__c,Status__c FROM Enquiry__c WHERE Id =: EnqId];
        EnquiryRecord.Status__c = String.valueOf(JSONBody.get('Status'));
        system.debug(String.valueOf(JSONBody.get('Status')));
        sp = Database.setSavepoint(); 
        update EnquiryRecord;
           }
           catch(exception e)
           {
            system.debug('Ran into ' + e + 'caused by - ' + e.getMessage());
            Database.rollback(sp);
            if(req.httpMethod != 'POST')
            {
                res.StatusCode = 405;
                res.responseBody = blob.valueOf('Please request with correct Method');
            }
            if((req.requestBody).toString() != 'POST')
            {
                res.StatusCode = 400;
                res.responseBody = blob.valueOf('Bad Request : Tip Please check your request JSON body and make sure it is format Valid');                    
            }
           } 
    }

}