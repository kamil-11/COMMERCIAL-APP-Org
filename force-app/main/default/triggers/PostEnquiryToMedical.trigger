/* 
    @author	Kamil kamran
    @date	05/08/2024
    @group	EQNUIRY_SYNCHRONIZATIONS
    @description Trigger for Synchronizations of the Enquiry and Physician/Doctor and Medical professional data.
    @version 1.0
     */
    // Status :-) Deployed

trigger PostEnquiryToMedical on Enquiry__c (after insert) {

    if(trigger.isAfter && trigger.isInsert)
    {
        EnquiryServices.PostEnquiryService(trigger.new);
        
    }
        
}