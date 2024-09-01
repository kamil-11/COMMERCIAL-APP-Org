import { api, LightningElement } from 'lwc';
export default class ChildComponent extends LightningElement {
    @api message;
    userDetails;
    Name;
    age;

    @api detailHandler(user)
    {
        this.userDetails = user;
        this.Name = user.Name;
        this.age=user.age;
    }
    clickHandler()
    {
        const myEvent = new CustomEvent('remove' , {
            details:'remove the property Value'
        });

            this.dispatchEvent(myEvent);
    }
}