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
        jsonBody.put('Specialization','software Engineer');
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