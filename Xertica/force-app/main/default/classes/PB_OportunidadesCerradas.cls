public with sharing class PB_OportunidadesCerradas {
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> obtenerOportunidadesCerradas( Id idCuenta) {
        
        List<Opportunity> oportunidad = [SELECT id, Name, Account.name ,Amount, CloseDate,Type, StageName 
                            FROM Opportunity 
                            WHERE (StageName =:'Closed Won' or StageName =:'Closed Lost') 
                            and CloseDate = THIS_MONTH and Account.Id =: idCuenta with security_enforced];
        return oportunidad;
    }
}
