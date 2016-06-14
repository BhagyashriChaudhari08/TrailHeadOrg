public class GoogleAuthController {

    public string authtoken{get;set;}
    public string refereshtoken{get;set;}
    public string bodyprint{get;set;}
    
    public static string CLIENT_SECRET='fbRcOJwuGmw21VVed34_aFlo';
    public static string CLIENT_ID='448400875680-1c97kgejs0fg5mlsfq6r0g7i4lpgl275.apps.googleusercontent.com';
    public static final string REDIRECT_URL='https://ap2.salesforce.com/apex/GoogleAuth';
    
    public static final string OAUTH_TOKEN_URL='https://accounts.google.com/o/oauth2/token';
	public static final string OAUTH_CODE_END_POINT_URL='https://accounts.google.com/o/oauth2/auth';
    
    public static final string GRANT_TYPE='grant_type=authorization_code';
	public static final string SCOPE='https://www.googleapis.com/auth/fitness.activity.read https://www.googleapis.com/auth/fitness.activity.write https://www.googleapis.com/auth/fitness.location.read https://www.googleapis.com/auth/fitness.location.write https://www.googleapis.com/auth/fitness.body.read https://www.googleapis.com/auth/fitness.body.write';
	public static final string STATE='/profile';
	public static final string APPROVAL_PROMPT='force';
	public Google_Keys__c googleKeys = Google_Keys__c.getInstance(Userinfo.getUserId());
    
    public pagereference connect(){
         
         System.debug('googleKeys :'+googleKeys);
         if(googleKeys == null){
            googleKeys = new Google_Keys__c(setupownerid = UserInfo.getUserId(), client_id__c = CLIENT_ID , client_secret__c = CLIENT_SECRET);
            insert googleKeys;
         }
         googleKeys = Google_Keys__c.getInstance(Userinfo.getUserId());
         CLIENT_ID = googleKeys.client_id__c;
         CLIENT_SECRET = googleKeys.client_secret__c;
         System.debug('CLIENT_ID :'+CLIENT_ID);
         System.debug('CLIENT_SECRET :'+CLIENT_SECRET);
         String x=OAUTH_CODE_END_POINT_URL+'?scope='+EncodingUtil.urlEncode(SCOPE,'UTF-8')+'&state='+EncodingUtil.urlEncode(STATE,'UTF-8')+'&redirect_uri='+EncodingUtil.urlEncode(REDIRECT_URL,'UTF-8')+'&response_type=code&client_id='+CLIENT_ID+'&approval_prompt='+APPROVAL_PROMPT;
         pagereference p=new pagereference(x);
         return p;
    }
    
    public string getAccessToken(){
        
        string codeparam=apexpages.currentpage().getparameters().get('code');
        if(googleKeys == null){
            googleKeys = new Google_Keys__c(setupownerid = UserInfo.getUserId());
        }
        System.debug('codeparam :'+codeparam);
        googleKeys = Google_Keys__c.getInstance(Userinfo.getUserId());
        googleKeys.Code__c = codeparam;
        //upsert googleKeys;
        
        System.debug('googleKeys :'+googleKeys);
        
        CLIENT_ID = googleKeys.client_id__c;
        CLIENT_SECRET = googleKeys.client_secret__c;
        String CODE = codeparam;
        
        String body='code='+CODE+'&client_id='+CLIENT_ID+'&client_secret='+CLIENT_SECRET+'&redirect_uri='+REDIRECT_URL+'&'+GRANT_TYPE;
        String httpResponse = doHttpCallout(OAUTH_TOKEN_URL, body, '');
        System.debug('httpResponse :'+httpResponse);
        Map<String,Object> httpResMap = (Map<String,Object>)JSON.deserializeUntyped(httpResponse);
        String accessToken = (String)httpResMap.get('access_token');
        return accessToken;
    }
    
    public String doHttpCallout(String endPointUrl, String requestBody, String authorization){
        
        String responseBody = '';
        Http h = new Http();
     	HttpRequest req = new HttpRequest();
        req.setEndpoint(endPointUrl);
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        if(String.isNotBlank(authorization)){
            req.setHeader('Authorization','Bearer ' + authorization);
        }
        req.setMethod('POST');
        req.setBody(requestBody);
        
        system.debug('REQUEST BODY'+requestBody);
    
    	// Send the request, and return a response
        HttpResponse res = h.send(req);
        
        responseBody = res.getbody();
        return responseBody;
    }
    
    public pagereference getDataSources(){
        
        String accessToken = getAccessToken();
        system.debug('accessToken :'+accessToken);
        String dataSourceURL = 'https://www.googleapis.com/fitness/v1/me/dataSources';
        String body='';
        String dataSourceList = doHttpCallout(dataSourceURL, body, accessToken);
        system.debug('dataSourceList :'+dataSourceList);
        bodyprint = dataSourceList;
        return null;
    }
    
}