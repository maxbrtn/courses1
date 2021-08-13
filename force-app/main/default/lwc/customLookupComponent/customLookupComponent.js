import { LightningElement, track, api } from 'lwc';
import getUnivercitiesBySearch from '@salesforce/apex/CustomLookupController.findRecords';
import getUnivercities from '@salesforce/apex/CustomLookupController.getUniversities';

export default class CustomLookupComponent extends LightningElement {
    
    @api objectName;
    @api searchField;
    @track inputValue= '';
    @track data;

    handleChange(event) {
        this.inputValue = event.target.value.trim(); 
        console.log('this.inputValue', this.inputValue);
        console.log('this.data', this.data);
        if(this.inputValue == '') {
            this.data = false;
        }
        getUnivercitiesBySearch({objectName: this.objectName, searchField: this.searchField, searchKey: this.inputValue})
            .then(result => {
                this.data = result;
            })
            .catch(error => {
                console.log('error', error);
            })
    }

    handleFocus() {
        console.log('focus');
        if(this.inputValue == '') {
            getUnivercities({objectName: this.objectName, searchField: this.searchField})
            .then(result => {
                this.data = result;
            })
        } else {
            getUnivercitiesBySearch({objectName: this.objectName, searchField: this.searchField, searchKey: this.inputValue})
            .then(result => {
                this.data = result;
            })
            .catch(error => {
                console.log('error', error);
            })
        }
        
    }

    handleBlur() {
        setTimeout(() => {
            this.data = false;
        }, 500)
    }

    clickSelected(event) {
        this.inputValue = event.target.innerHTML;
        this.data = false;
    }
}