# najva Flutter Application
This is a Flutter application that NajvaSdk implemented in it.

### Test Najva Service in Flutter
If you want test Najva Push Notification Service in Flutter application you should:

1.  Clone this project and rename package name of it 

2.  Register this app after login in [najva panel](https://app.najva.com/accounts/login/?next=/).(to register any app, its package name must be unique!)


3.  After register najva panel gives you campaignId,websiteId,apiKey which is specific to your app

4.  Open Najva class and change this line
```

int campaignId = 0; // your campaignId here
int websiteId = 0; // your websiteId here
String apiKey = ""; //your api key here


```
5.  Now you can run application and send notification from your panel to it!