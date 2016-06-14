public with sharing class FitForceUtility {

    public static String GET = 'GET';
    public static String POST = 'POST';
    public static string PROFILE_API = '';
    public static string ACTIVITY_API = '';
    static{
        string BASE_URL = 'callout:FitForce/';
        PROFILE_API = BASE_URL + '1/user/-/profile.json';
        ACTIVITY_API = BASE_URL + '1/user/-/activities/date/TODAY.json';
    }
    
    public static string doHTTPCallout(String methodType, String url){
        String response = '';
        if(String.isBlank(methodType)){
            methodType = 'GET';
        }
        HttpRequest httpRequest = new HttpRequest();
        Http http = new Http();
        httpRequest.setMethod(methodType);
        httpRequest.setEndpoint(url);
        HttpResponse httpResponse = http.send(httpRequest);
        response = httpResponse.getBody();
        System.debug('Server Response :'+response);
        return response;
    }
}