import { LightningElement, wire } from 'lwc';
import getEnquiries from '@salesforce/apex/getEnquiries.queryEnquiries'
export default class WiredApexMethod extends LightningElement {
    enquiryList;
    @wire(getEnquiries)
    enquiryDetails({data,error})
    {
    if(data)
    {
        this.enquiryList=data;
        console.log(this.enquiryList);
    }
    if(error)
    {
        console.log(error);
    }
}
}

