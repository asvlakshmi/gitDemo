import { LightningElement,api,wire } from 'lwc';
import getEmailTemplates from '@salesforce/apex/picklistHelper.getEmailTemplates';
import SendEmail from '@salesforce/apex/picklistHelper.SendEmail';
import { NavigationMixin } from 'lightning/navigation';
export default class ListviewContactLWC extends NavigationMixin(LightningElement) {
    @api listviewIds;
    emailTemplateList;
    selectedEmailTemplate;

    @wire(getEmailTemplates)
    retrieveEmailTemplates({error,data})
    {
        let tempArray = [];
        if(data)
        {
            for(let key in data)
            {
                tempArray.push({label:data[key],value:key});
            }
            this.emailTemplateList = tempArray;
        }
        
    }
    handleEmailTemplateChange(event)
    {
        this.selectedEmailTemplate = event.target.value;
    }
    handleClick()
    {
        SendEmail({lvIds:this.listviewIds,selectedET:this.selectedEmailTemplate})
    }
}