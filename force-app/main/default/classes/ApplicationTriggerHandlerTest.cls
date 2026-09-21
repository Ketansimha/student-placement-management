@IsTest
private class ApplicationTriggerHandlerTest {

    @IsTest
    static void testDefaultStatus() {

        Student__c student = new Student__c(
            Name = 'Test Student',
            Register_Number__c = 'TEST001',
            Email__c = 'test@student.com',
            Department__c = 'CSE',
            CGPA__c = 8.0,
            Graduation_Year__c = 2027,
            Skills__c = 'Java',
            Placement_Status__c = 'Not Placed'
        );

        insert student;

        Company__c company = new Company__c(
            Name = 'Test Company',
            Company_Email__c = 'test@company.com',
            Industry__c = 'IT',
            Job_Role__c = 'Software Developer',
            Job_Status__c = 'Open',
            Location__c = 'Chennai',
            Minimum_CGPA__c = 7.0,
            Package__c = 6.0
        );

        insert company;

        Placement_Drive__c drive = new Placement_Drive__c(
            Name = 'Test Placement Drive',
            Company__c = company.Id,
            Job_Role__c = 'Software Developer',
            Drive_Date__c = Date.today().addDays(10),
            Application_Deadline__c = Date.today().addDays(5),
            Minimum_CGPA__c = 7.0,
            Status__c = 'Upcoming'
        );

        insert drive;

        Application__c application = new Application__c(
            Student__c = student.Id,
            Placement_Drive__c = drive.Id,
            Application_Date__c = Date.today()
        );

        Test.startTest();

        insert application;

        Test.stopTest();

        Application__c result = [
            SELECT Id, Status__c
            FROM Application__c
            WHERE Id = :application.Id
        ];

        System.assertEquals(
            'Pending',
            result.Status__c,
            'Application status should automatically become Pending'
        );
    }
}