import { LightningElement } from 'lwc';
import getLimitedEnquiry from '@salesforce/apex/getEnquiries.queryLimitedEnquiries'
export default class ApexImperativeCall extends LightningElement {

    listEnquiry;
    error;
    async searchHandler()
    {
        try{
       this.listEnquiry =  await getLimitedEnquiry();
       this.error = undefined;
    }
    catch{
        this.listEnquiry = undefined;
        this.error = error;
    }
    }
}