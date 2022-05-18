@RestResource(UrlMapping='/RestWithString/Accounts')
global class passingStringForRest
{
    @HttpGet
    global Static String getString()
    {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        //String recordId = req.RequestURI.substring(req.requestURI.lastindexOf('/')+1);
        String str = null;
        integer count= database.countQuery('select count() from account');
        if(count!=0 && count>0)
        {
            str = 'Yes';
        }
        else
        {
            str = 'No';
        }
        return str;
    }
}