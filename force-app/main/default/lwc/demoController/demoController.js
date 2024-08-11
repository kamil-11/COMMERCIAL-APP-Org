import { LightningElement, wire } from 'lwc';
import getContacts from '@salesforce/apex/GetContacts.fetchContacts';
export default class DemoController extends LightningElement {

    @wire(getContacts)
    Contact;

    

}