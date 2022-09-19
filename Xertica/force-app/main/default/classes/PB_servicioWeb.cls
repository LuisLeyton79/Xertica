public with sharing class PB_servicioWeb {
    @InvocableMethod
    public static void enviarOportunidad(List<String> id_oportunidad) {
        if(id_oportunidad.size() > 0){
            List<Opportunity> lstOportunidades=[SELECT Id, Name,Account.Name, StageName, Amount, CloseDate 
                                        FROM Opportunity where id IN :id_oportunidad  with security_enforced];

           PB_OportunidadDTO dtoJson = new PB_OportunidadDTO();
            Opportunity opp = lstOportunidades.get(0);

            dtoJson.opportunityName = opp.Name;
            dtoJson.opportunityId = opp.id;
            dtoJson.closeDate = opp.CloseDate;
            dtoJson.amount = opp.Amount;
            dtoJson.accountName = opp.Account.Name;
            string json = System.JSON.serialize(dtoJson);
            webOpp(json, opp.id);
        }
    }
    @future(callout=true)
    public static void webOpp(string jsonOpp, string id) {
       
        String endPointURL ='http://www.apexdevnet.com/test/prueba/';

        Httprequest request = new HttpRequest();
        Http http = new Http();

        request.setMethod('POST');
        request.setEndpoint(endPointURL);
        request.setHeader('Content-Type','application/x-www-form-urlencoded');
        request.setHeader('Accept-Encoding', 'gzip, deflate, br');
        request.setHeader('Accept', '/');
        request.setHeader('Connection', 'keep-alive');
        request.setBody(jsonOpp);

        Opportunity objOpp = [select id, StageName from Opportunity where id = :id];

        HttpResponse response = http.send(request);
        System.debug('status: '+ response.getStatusCode());
        
        if(response.getStatusCode() == 201){
            objOpp.StageName = 'Enviado';
        } else {
            objOpp.StageName = 'Reenviar';
        }
        update objOpp;
    }
    


}
