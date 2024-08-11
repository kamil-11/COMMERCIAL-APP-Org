/* 
    @author	Kamil kamran
    @date	05/08/2024
    @group	EQNUIRY_SYNCHRONIZATIONS
    @description This is Callout Service Service In Commercial App to callout to a Enquiry WebService exposed through connected app ofMedicalApp, 
    Intact Functionality of the Server Side data Validation which is the enquiry record saved on the front end and the Queueable Interface 
    Callout service to handle vloumes.Desgin facilitates Same Queueable Service to be used later to expand and scale from other Application or large volume process.
    @version 1.0
     */
    // Status :-) Deployed
public class EnquiryServices {
    Public Static Void PostEnquiryService(List<Enquiry__c> latestEnquiry)
    {
        Set<Id> EnquiryIds = new Set<id>();
        Map<String, Enquiry__c> EnquiryMap = new Map<String, Enquiry__c>();
        Enquiry__c Enqforid = [Select Id,Name FROM Enquiry__c Where Name =:latestEnquiry[0].Name];
        Id EnqId = Enqforid.Id;
        system.debug(latestEnquiry[0]);
        system.debug(EnqId);
        system.debug(latestEnquiry[0].Name);
        for(Enquiry__c Enquiry : latestEnquiry)
        {
            if(Enquiry.Physician__c == null)
            {Enquiry.addError(System.Label.Medical_Professional_Name);}
            if(Enquiry.Medicine__c == null)
            {Enquiry.addError(System.Label.Which_Medicine);}
        }
        EnquiryRecordDescriptor EnquiryWrapper = new EnquiryRecordDescriptor(latestEnquiry[0].Id,latestEnquiry[0].Name, latestEnquiry[0].Physician__c,
                                                                                     latestEnquiry[0].Medicine__c, latestEnquiry[0].Physician_Email__c,
                                                                                     latestEnquiry[0].Physician_Number__c, latestEnquiry[0].Question_Record__c,
                                                                                     latestEnquiry[0].Medical_Center__c, latestEnquiry[0].Preferred_Response_Channel__c
                                                                                    );
                System.enqueueJob(new QueueableEnquiryServices(EnquiryWrapper)); 

    }
    Public Class QueueableEnquiryServices implements Queueable, Database.AllowsCallouts {
        
        private String test;
        private String EnquiryId;
        private String Name;
        private String physicianName;
        private String medicine;
        private String physicianEmail;
        private String PhysicianNumber;
        private String Queries;
        private String MedicalCenter;
        private String prefferedChannel;


        public QueueableEnquiryServices(EnquiryRecordDescriptor EnquiryRecord)
        {
            
            this.Name = EnquiryRecord.Name;
            this.physicianName = EnquiryRecord.physicianName;
            this.medicine = EnquiryRecord.medicine;
            this.physicianEmail=EnquiryRecord.physicianEmail;
            this.physicianNumber=EnquiryRecord.physicianNumber;
            this.Queries =EnquiryRecord.Queries;
            this.MedicalCenter = EnquiryRecord.MedicalCenter;
            this.prefferedChannel = EnquiryRecord.prefferedChannel;
            this.EnquiryId = EnquiryRecord.EnquiryId;
        
        }
        public void execute(QueueableContext Context)
        {
            String uri ='/services/apexrest/Enquiry';
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('Callout:Medical_Information' + uri);
            request.setHeader('Content-Type', 'application/json;');
            request.setEndpoint('Callout:Medical_Information' + uri);
            request.setHeader('Content-Type', 'application/json;');
            Map<string,string> jsonBody = new Map<string, string>();
            jsonbody.put('ExternalEnqId',EnquiryId);
            jsonBody.put('EnquiryName',Name);
            jsonBody.put('Physician_Name',physicianName);
            jsonBody.put('Medicine',medicine);
            jsonBody.put('PhysicianEmail',physicianEmail);
            jsonBody.put('PhysicianNumber',physicianNumber);
            jsonBody.put('Queries',Queries);
            jsonBody.put('MedicalCenter',MedicalCenter);
            jsonBody.put('PrefferredResponseChannel',prefferedChannel);
            string JsonSer = JSON.serializePretty(jsonBody);
            request.setBody(JsonSer);
            request.setMethod('POST');
            System.debug('Testing');
            HttpResponse response = new Httpresponse();
        
        try{
            response = http.send(request);
            
            System.debug(response.getStatus());
        }
        catch(exception e)
        {
            system.debug(e.getMessage());
        }
        }
    }
    public Class EnquiryRecordDescriptor{
        private String EnquiryId;
        private String Name;
        private String physicianName;
        private String medicine;
        private String physicianEmail;
        private String PhysicianNumber;
        private String Queries;
        private String MedicalCenter;
        private String prefferedChannel;
        EnquiryRecordDescriptor(String EnquiryId, String Name, String physicianName, String medicine, String physicianEmail, 
                                 String physicianNumber, String Queries, String MedicalCenter, String prefferedChannel
                                ) {
                                    this.EnquiryId = EnquiryId;
                                    this.Name = Name;
                                    this.physicianName = physicianName;
                                    this.medicine = medicine;
                                    this.physicianEmail=physicianEmail;
                                    this.physicianNumber=physicianNumber;
                                    this.Queries =Queries;
                                    this.MedicalCenter = MedicalCenter;
                                    this.prefferedChannel = prefferedChannel;
                                }

    }

}