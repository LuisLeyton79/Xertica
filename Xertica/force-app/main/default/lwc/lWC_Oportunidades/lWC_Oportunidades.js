import { LightningElement, wire, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import obtenerOportunidades from '@salesforce/apex/PB_OportunidadesCerradas.obtenerOportunidadesCerradas';


export default class LWC_Oportunidades extends NavigationMixin(LightningElement) {
    @api recordId;
    @wire(obtenerOportunidades, { idCuenta: '$recordId' })
    obtenerOportunidades;
    navigateToRecordViewPage(event) {      
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: event.currentTarget.dataset.id,
                objectApiName: 'Opportunity', 
                actionName: 'view'
            }
        });
    }

}