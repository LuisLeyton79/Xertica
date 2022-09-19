public with sharing class PB_OportunidadDTO {
   public String opportunityName {set;get;}
   public String opportunityId {set;get;}
   public Date closeDate {set;get;}
   public decimal amount {set;get;}
   public String accountName {set;get;}

   public List<PB_OportunidadDTO> parse(String json) {
      return (List<PB_OportunidadDTO>) System.JSON.deserialize(json,List<PB_OportunidadDTO>.class);  
  }
}
