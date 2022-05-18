import { LightningElement,wire,api } from 'lwc';
import { getRecordUi } from 'lightning/uiRecordApi';

export default class PreviewEmail extends LightningElement {
  emailBody;
  @api recordId = '00X2v000001vtmWEAQ';
  @wire(getRecordUi, { recordIds: '$recordId', layoutTypes: 'Full', modes: 'View' })
    wiredRecord({ error, data }) {
      if (data) {
        this.emailBody = data.records[this.recordId].fields["Body"].value;
        console.log("Email Body:::::::::::"+this.emailBody);
        console.log("hi");
      } else{
        // TODO: Data handling
      }
    }
}