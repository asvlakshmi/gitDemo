public class SalesforcetoCommerce {
    public static void getCustomerfrmCommerce(){
    Http http = new Http();
	HttpRequest request = new HttpRequest();
	request.setEndpoint('https://api.europe-west1.gcp.commercetools.com/app-building/customers');
    request.setHeader('Authorization', 'Bearer ' + 'Z7Yj64W6Qh4YopVkkgO3-V2dHwSA_kbB');
	request.setMethod('GET');
	HttpResponse response = http.send(request);
// If the request is successful, parse the JSON response.
if(response.getStatusCode() == 200) {
    // Deserialize the JSON string into collections of primitive data types.
    Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
    
    System.debug('Received the following customers:'+results);
    
}
    }

}