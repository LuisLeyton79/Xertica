trigger actualizarOportunidad on Account (after Update) {
    set<id> idCuentas = new set<id>();
    for(Account ac  : trigger.new){
        if(ac.Activa__c == 'No'){
            idCuentas.add(ac.id);
        }
    }
    System.debug(idCuentas);
    
    if(!idCuentas.isEmpty()){
        //consulto las oportunidades relacionado a las cuentas
        list<Opportunity> lstOportunidades =[select id, StageName from Opportunity 
        where StageName != 'Closed Lost' and StageName !='Closed Won' and AccountId in :(idCuentas) ];
        System.debug(lstOportunidades);
        if(lstOportunidades.size()>0){
            for(Opportunity op : lstOportunidades){
                op.StageName = 'Closed Lost';
            }
            System.debug(lstOportunidades);
            Update lstOportunidades;
        }
        //consulto  los contacto relacionados a las oportunidades
        list<Contact> lstContactos = [select id, AccountId,  Rol__c from Contact where Rol__c ='Influyente' and AccountId in :(idCuentas) ];
        list<Ex_clientes__c> excli = new list<Ex_clientes__c>();
        System.debug(lstContactos);
        if(lstContactos.size() > 0){
            for(Contact c : lstContactos){
                Ex_clientes__c cli = new Ex_clientes__c();
                cli.Contacto__c = c.id;                    
                cli.Generado_automoticamente__c  = true;
                excli.add(cli);
            }
            System.debug(excli);
            upsert excli;
        } 
    }
}