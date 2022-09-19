public With sharing class PB_Oportunidades {

  public  list<Opportunity> getListaOpurtunidades(){
    list<Opportunity> lstOportunidades =  [select id, Name, Account.Name, Amount, CloseDate, StageName, Type 
            from Opportunity 
            where StageName = 'Closed Won' and CloseDate =THIS_MONTH  WITH SECURITY_ENFORCED];
            return lstOportunidades;
  }

}