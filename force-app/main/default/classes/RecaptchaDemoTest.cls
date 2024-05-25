@isTest
public class RecaptchaDemoTest {
    
    @isTest
    static void testInsertRecordSuccessV3() {
        // Mock the HTTP response for reCAPTCHA v3
        RecaptchaDemoTestHttpMock responseMock = new RecaptchaDemoTestHttpMock(true, 0.9, 'homepage');
        Test.setMock(HttpCalloutMock.class, responseMock);
        
        // Create a test SObject (e.g., Account)
        Account testAccount = new Account(Name = 'Test Account');
        
        // Call the insertRecord method
        String result = RecaptchaDemo.insertRecord(testAccount, 'test-recaptcha-response');
        
        // Verify the result
        System.assertEquals('Success - v3', result);
    }
    
    @isTest
    static void testInsertRecordSuccessV2() {
        // Mock the HTTP response for reCAPTCHA v2
        RecaptchaDemoTestHttpMock responseMock = new RecaptchaDemoTestHttpMock(true, null, null);
        Test.setMock(HttpCalloutMock.class, responseMock);
        
        // Create a test SObject (e.g., Account)
        Account testAccount = new Account(Name = 'Test Account');
        
        // Call the insertRecord method
        String result = RecaptchaDemo.insertRecord(testAccount, 'test-recaptcha-response');
        
        // Verify the result
        System.assertEquals('Success - v2', result);
    }
    
    @isTest
    static void testInsertRecordInvalidVerification() {
        // Mock the HTTP response for invalid verification
        RecaptchaDemoTestHttpMock responseMock = new RecaptchaDemoTestHttpMock(false, null, null);
        Test.setMock(HttpCalloutMock.class, responseMock);
        
        // Create a test SObject (e.g., Account)
        Account testAccount = new Account(Name = 'Test Account');
        
        // Call the insertRecord method
        String result = RecaptchaDemo.insertRecord(testAccount, 'test-recaptcha-response');
        
        // Verify the result
        System.assertEquals('Invalid Verification', result);
    }
    
    @isTest
    static void testInsertRecordInvalidVerificationRequest() {
        // Mock the HTTP response for invalid verification request
        RecaptchaDemoTestHttpMock responseMock = new RecaptchaDemoTestHttpMock(400, 'Bad Request');
        Test.setMock(HttpCalloutMock.class, responseMock);
        
        // Create a test SObject (e.g., Account)
        Account testAccount = new Account(Name = 'Test Account');
        
        // Call the insertRecord method
        String result = RecaptchaDemo.insertRecord(testAccount, 'test-recaptcha-response');
        
        // Verify the result
        System.assertEquals('Invalid Verification Request', result);
    }
    
    // Mock HTTP Response Class
    private class RecaptchaDemoTestHttpMock implements HttpCalloutMock {
        private Boolean success;
        private Decimal score;
        private String action;
        private Integer statusCode;
        private String status;
        
        // Constructor for valid response
        public RecaptchaDemoTestHttpMock(Boolean success, Decimal score, String action) {
            this.success = success;
            this.score = score;
            this.action = action;
            this.statusCode = 200;
            this.status = 'OK';
        }
        
        // Constructor for invalid response
        public RecaptchaDemoTestHttpMock(Integer statusCode, String status) {
            this.success = false;
            this.score = null;
            this.action = null;
            this.statusCode = statusCode;
            this.status = status;
        }
        
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(statusCode);
            res.setStatus(status);
            
            if (statusCode == 200) {
                Map<String, Object> responseBody = new Map<String, Object>();
                responseBody.put('success', success);
                if (score != null) {
                    responseBody.put('score', score);
                }
                if (action != null) {
                    responseBody.put('action', action);
                }
                res.setBody(JSON.serialize(responseBody));
            }
            
            return res;
        }
    }
}