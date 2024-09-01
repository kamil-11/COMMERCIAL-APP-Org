import { LightningElement,api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import ANNUAL_REVENUE from '@salesforce/schema/Account.AnnualRevenue';
import INDUSTRY from '@salesforce/schema/Account.Industry';
import TYPE from '@salesforce/schema/Account.Type';
export default class GetRecordData extends LightningElement {

    @api recordId;
    accountRecordData;
    error;
    fields =[NAME_FIELD,ANNUAL_REVENUE, INDUSTRY, TYPE];
    /* @wire(getRecord,{recordId:'$recordId',layoutTypes:[],modes:['View']}) */
        
    accountRecordDataHandler({data,error}){
        if(data){
            this.accountRecordData= data.fields;
            this.error = undefined;
            console.log(data);
            console.log(data.fields);
                }
                if(error)
                {
                    this.error=error;
                    console.error(error);
                    data =undefined;
                }
    }
    

}