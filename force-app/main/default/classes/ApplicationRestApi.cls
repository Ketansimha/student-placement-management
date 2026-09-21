@RestResource(urlMapping='/student-placement/*')
global with sharing class ApplicationRestApi {

    @HttpPost
    global static Application__c createApplication() {

        RestRequest req = RestContext.request;

        String requestBody = req.requestBody.toString();

        Map<String, Object> data =
            (Map<String, Object>) JSON.deserializeUntyped(requestBody);

        Application__c application = new Application__c();

        // Student
        if (data.containsKey('studentId')) {
            application.Student__c =
                (String) data.get('studentId');
        }

        // Placement Drive
        if (data.containsKey('placementDriveId')) {
            application.Placement_Drive__c =
                (String) data.get('placementDriveId');
        }

        // Application Date
        application.Application_Date__c = Date.today();

        // Interview Date
        if (data.containsKey('interviewDate')) {
            application.Interview_Date__c =
                Date.valueOf((String) data.get('interviewDate'));
        }

        // Remarks
        if (data.containsKey('remarks')) {
            application.Remarks__c =
                (String) data.get('remarks');
        }

        // Initial Status
        application.Status__c = 'Applied';

        insert application;

        RestContext.response.statusCode = 201;

        return application;
    }
}