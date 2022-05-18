@RestResource(urlMapping='/FieldCase/*')

    global with sharing class RESTCaseController
    {
        @HttpGet
        global static List<Case> getOpenCases()
        {
            String companyName = RestContext.request.params.get('companyName');
            Account company=[select Id,name,BillingState from Account where name=:companyName];
            List <Case> cases=[select id,subject,status,ownerId,Owner.Name from case where AccountId=:company.Id];
            return cases;
        }
    }