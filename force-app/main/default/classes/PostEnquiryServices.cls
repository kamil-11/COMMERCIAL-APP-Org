/* 
    @author	Kamil kamran
    @date	05/08/2024
    @group	EQNUIRY_SYNCHRONIZATIONS
    @description This is Callout Service Service In Commercial App to callout to a Enquiry WebService exposed through connected app ofMedicalApp, 
    Intact Functionality of the Server Side data Validation which is the enquiry record saved on the front end and the Queueable Interface 
    Callout service to handle vloumes.Desgin facilitates Same Queueable Service to be used later to expand and scale from other Application or large volume process.
    @version 1.0
     */
    // Status :-) Under Development
public with sharing class PostEnquiryServices {
    
    @future(callout=true)
    public static void PostEnquiry() {
        String uri ='/services/apexrest/Enquiry';

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        request.setEndpoint('Callout:Medical_Information' + uri);
        request.setHeader('Content-Type', 'application/json;');
        Map<string,string> jsonBody = new Map<string, string>();
        jsonbody.put('Name','kamil');
        jsonBody.put('Enquiry_ID','3765325662');
        string JsonSer = JSON.serializePretty(jsonBody);
        request.setBody(JsonSer);
        request.setMethod('POST');

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