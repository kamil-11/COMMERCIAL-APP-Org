import {api,LightningElement } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import  ENQUIRY_OBJECT  from '@salesforce/schema/Enquiry__c';
import  NAME_FIELD  from '@salesforce/schema/Enquiry__c.Name';
import  MEDICINE_FIELD  from '@salesforce/schema/Enquiry__c.Medicine__c';
import  PHYSICIAN_FIELD  from '@salesforce/schema/Enquiry__c.Physician__c';
import  CHANNEL_FIELD  from '@salesforce/schema/Enquiry__c.Preferred_Response_Channel__c';
import  QUERY_FIELD  from '@salesforce/schema/Enquiry__c.Question_Record__c';
import  STATUS_FIELD  from '@salesforce/schema/Enquiry__c.Status__c';
//import LOGO from '@salesforce/resourceUrl/KomodoLogo';
export default class EnquiryTab extends LightningElement {

    /* 
    QuestionProp= 'Sample Questions Here !'; */

    objectName =ENQUIRY_OBJECT;
    //@api fieldList =[NAME_FIELD,MEDICINE_FIELD,PHYSICIAN_FIELD,CHANNEL_FIELD,QUERY_FIELD,STATUS_FIELD,
       // { fieldApiName: 'Medicine__c', objectApiName: 'Enquirßy__c' }];
    

    succesHandler(event)
    {
        console.log(event.detail.id);
        const toastEvent = new ShowToastEvent({
            title:"Enquiry Sent to M.I Org",
            message:" Enquiry Captured on both the Orgs",
            variant:"success"
        })  
        this.dispatchEvent(toastEvent);
        const editForm = this.template.querySelector('lightning-record-form');
        editForm.recordId = null;
    }
}