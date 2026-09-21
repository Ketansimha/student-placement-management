public with sharing class ApplicationTriggerHandler {

    public static void handleApplications(
        List<Application__c> newApplications,
        Map<Id, Application__c> oldApplications
    ) {

        for (Application__c app : newApplications) {

            // Set default status for new applications
            if (app.Status__c == null) {
                app.Status__c = 'Applied';
            }

            // Example: validate interview date
            if (app.Interview_Date__c != null &&
                app.Application_Date__c != null &&
                app.Interview_Date__c < app.Application_Date__c) {

                app.addError(
                    'Interview Date cannot be before Application Date.'
                );
            }
        }
    }
}