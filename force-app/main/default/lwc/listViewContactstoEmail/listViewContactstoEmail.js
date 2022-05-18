import { LightningElement,api,wire,track } from 'lwc';
import getEmailTemplates from '@salesforce/apex/picklistHelper.getEmailTemplates';
import SendEmail from '@salesforce/apex/picklistHelper.SendEmail';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class ListViewContactstoEmail extends LightningElement {
    @api listviewIds;
    emailTemplateList;
    selectedEmailTemplate;
    emailTemplatesmap = [];
    @api availableActions = [];
    @track autoClose = true;
    @track openmodel = false;
    richtext = "<div><h2><b>TITLE HEADING</b></h2> <h3>Title description, <span >April 7, 2014</span></h3></div><footer><p>Powered by <a href=\"https://www.w3schools.com/w3css/default.asp\" target=\"_blank\">w3.css</a></p> </footer>";
    openmodal() {
        
        if(this.selectedEmailTemplate)
        {
            this.openmodel = true
            console.log(this.selectedEmailTemplate);
            console.log(this.emailTemplatesmap);
            this.richtext =  this.emailTemplatesmap[this.selectedEmailTemplate].Body;
            console.log(this.emailTemplatesmap[this.selectedEmailTemplate].Name);
        }else{
            this.template.querySelector('c-custom-toast').showToast('info', 'Please select Email Template.');
        }
    }
    handleChange(e) {
        this.richtext = e.detail.value;
    }
    closeModal() {
        this.openmodel = false
    } 
    saveMethod() {
        alert('save method invoked');
        this.template.querySelector('lightning-input-rich-text').focus();
        console.log(this.richtext);
        this.closeModal();
    }
    @wire(getEmailTemplates)
    retrieveEmailTemplates({error,data})
    {
        
        let tempArray = [];
        if(data)
        {
            this.emailTemplatesmap = data;
            console.log(this.emailTemplatesmap);
            for(let key in data)
            {
                tempArray.push({label:data[key].Name,value:data[key].Id});
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
        .then(() => {
            console.log('checking navigation from send email');
            this.template.querySelector('c-custom-toast').showToast('success', 'Email has been sent.');
            
        })
        .catch((error) => {
            console.log('checking exception');
            this.error = error;
            
        })
        .finally(() => {
            console.log('going to the final method');
            this.handleCancel();
        })
        
        
    }
    handleCancel(){
        console.log('checking cancel method');
        var url = window.location.href; 
        var value = url.substr(0,url.lastIndexOf('/') + 1);
        window.history.back();
        return false;
        //this.navigateToContactListView();
       
    }
}