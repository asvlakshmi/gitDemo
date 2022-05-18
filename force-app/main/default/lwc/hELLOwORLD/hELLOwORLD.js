import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class HELLOwORLD extends NavigationMixin(LightningElement) {
    greeting = 'World';
    changeHandler(event) {
    this.greeting = event.target.value;
  }
  handleRedirect()
  {
    this[NavigationMixin.Navigate]({
      type:"standard__objectPage",
      attributes: {
          objectApiName:"Contact",
          actionName:"list"
      },
      state: {
          filterName:"Recent"
      }
  });
  }
  showNotification() {
    console.log('entering notification method');
    const evt = new ShowToastEvent({
        title: 'Email',
        message: 'Email has been sent',
        variant: 'info',
    });
    this.dispatchEvent(evt);
}
}