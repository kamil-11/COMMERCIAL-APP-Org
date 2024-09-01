import { LightningElement } from 'lwc';

export default class ParentComponent extends LightningElement {

    userDetails ={
        Name : 'Kamil kamran',
        age: 26,
        email:'kkamran336@gmail.com',
        company:'salesforce'

    }
    sendHandler(){
        this.template.querySelector('c-child-component').detailHandler(this.userDetails);

    }
    removeHandler(event)
    {
        this.userDetails= null;
        console.log('Remove Handler called to remove the user-details property values');
    }
}