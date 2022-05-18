public class SalesforceConnect {
	public static void getCasesFromSalesforceOrgB() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:sfdcOrgB/services/apexrest/Cases');
        request.setMethod('GET');
        
        
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if(response.getStatusCode() == 200) {
            List<object> results = (List<object>)json.deserializeUntyped(response.getBody());
            for(object result:results)
            {
                Map<string,object> caseObjs = (Map<string,object>) result;
                system.debug('CaseNumber:'+caseObjs.get('CaseNumber')+'- Subject:' +caseObjs.get('Subject'));
            }
        }
	}
    public static void createCaseinSalesforceOrgB()
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:sfdcOrgB/services/apexrest/Cases');
        request.setMethod('POST');
        request.setBody('{"subject":"Case from Salesforce OrgA","status":"New","origin":"Web","priority":"Medium"}');
        request.setHeader('Content-Type' , 'application/json;charset=UTF-8');
        
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if(response.getStatusCode() == 200) {
           system.debug(response.getBody());
        }
        
    }
}