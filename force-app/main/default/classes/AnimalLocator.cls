public class AnimalLocator {

    public static string getAnimalNameById(integer Id)
    {
        Http http = new Http();
        String strResp = '';
        HttpRequest request  = new HttpRequest();
        request.setEndPoint('https://th-apex-http-callout.herokuapp.com/animals'+Id);
        request.setMethod('Get');
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200)
        {
            Map<String,object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            Map<string,object> animals = (map<string,object>) results.get('animal');
            System.debug('Received the following animals:' + animals );
            strResp = string.valueof(animals.get('name'));
            System.debug('strResp >>>>>>' + strResp );

        }
        return strResp;
    
    }

}