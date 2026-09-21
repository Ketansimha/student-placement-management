trigger ApplicationTrigger on Application__c (
    before insert,
    before update
) {

    ApplicationTriggerHandler.handleApplications(
        Trigger.new,
        Trigger.oldMap
    );
}