public with sharing class getEnquiries{
    @AuraEnabled(cacheable = true)
    public static List<Enquiry__c> queryEnquiries(){
        return [SELECT Id, OwnerId, IsDeleted, Name, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastActivityDate, LastViewedDate, LastReferencedDate, Physician__c, Medicine__c, Preferred_Response_Channel__c, Question_Record__c, Status__c, Physician_Number__c, Physician_Email__c, Medical_Center__c
                FROM Enquiry__c];
    }

    @AuraEnabled(cacheable = true)
    public static List<Enquiry__c> queryLimitedEnquiries(){
        return [SELECT Id, OwnerId, IsDeleted, Name, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastActivityDate, LastViewedDate, LastReferencedDate, Physician__c, Medicine__c, Preferred_Response_Channel__c, Question_Record__c, Status__c, Physician_Number__c, Physician_Email__c, Medical_Center__c
                FROM Enquiry__c
                LIMIT 10];
    }

}