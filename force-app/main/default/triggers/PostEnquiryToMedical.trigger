trigger PostEnquiryToMedical on Enquiry__c (after insert) {

    if(trigger.isAfter && trigger.isInsert)
    {
        EnquiryServices.PostEnquiryService(trigger.new);
        
    }
        
}