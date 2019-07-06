# najvaflutter

Flutter plugin for implementing NajvaSDK in your flutter application without interaction with java code.

## Implementation guide

Here is simple way to implement `najva-flutter-plugin` to your flutter application

### Add plugin
Add `najva-flutter-plugin` to your project.

### Changes in your code

Create a class named `Najva` or any name you think is good and extent from `NajvaFlutter`.

```
class Najva extends NajvaFlutter {
    
}
```

`NajvaFlutter` has three methods called `init` , `initUserHandling` and `initJSONNotification`.

By calling `init` method and passing the right argument your NajvaSDK will be initialized and your push notification will work correctly.

```
    init(CHAMPAIGN_ID,WEBSITE_ID,API_KEY,LOCATION_ENABLED);
```
`CHAMPAIGN_ID` is your chamaignId that you can create or find in your [panel](https://app.najva.com/login).

`WEBSITE_ID` is your websiteId that can be found in your [panel](https://app.najva.com/login).

`API_KEY` is your api key that can be found in your [panel](https://app.najva.com/login).

`LOCATION_ENABLED` is a boolean. if set true the `NajvaSDK` will improve your push notifications by users location and also Location permission will be asked from user if android version is above 6.0.

By calling `initUserHandling` the plugin will get user token and passed it to a method called `onUserSubscribed`. 
Simply by overriding this method you can send the token to your server or do whatever you want.

```
initUserHandling();

@override
  void onUserSubscribed(String token) {
    print(token);
    
    sendTokenToServer(token);
    }
```

By calling `initJSONNotification` the plugin will not handle incomming notifications and passes the data to method called `onNewJSONDataReceived`.
Simply by overriding this method you can handle incomming data and implement your own code.

```
initJSONNotification();

@override
  void onNewJSONDataReceived(String jsonData) {
    print(jsonData);
    
    doCustomAction(jsonData);
  }
```

## Not using the plugin code

If you want to not use this plugin and handle anything in java code you can remove this plugin and in your android dependencies add the code bellow.
```
implementation 'com.najva.sdk:najva-android-sdk:1.0.6'
```

Or you can keep the plugin in your flutter project.


### Removing Najva service

In order to disable Najva service from your android manifest and handle get notifications in your service first add the following to your `app` manifest file
```
<service
    android:name="com.najva.najvasdk.Service.NajvaMessagingService" 
    tools:node="remove" />
```

The code above will remove our service from your android manifest file.

Then add the following code to your manifest file to declare a new service

```
<service android:name=".MyFcmService">
    <intent-filter>
        <action android:name="com.google.firebase.MESSAGING_EVENT" />
    </intent-filter>
</service>
```

* Note that all changes in `AndroidManifest.xml` file must be under `<application>` tag.

Then create a class called `MyAppService`. your class must look like this:

```
public class MyFcmService extends FirebaseMessagingService {

}
```

The `FirebaseMessagingService` has to methods called `onMessageReceived` and `onNewToken`.
You can `Override` them and in order to use Najva call `NajvaPushNotificationHandler.handleMessage` and `NajvaPushNotificationHandler.handleNewToken` in these methods.

```
@Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        super.onMessageReceived(remoteMessage);
        NajvaPushNotificationHandler.handleMessage(getApplicationContext(), remoteMessage);
    }

    @Override
    public void onNewToken(String s) {
        super.onNewToken(s);
        NajvaPushNotificationHandler.handleNewToken(getApplicationContext(), s);
    }
```

Or if you use another push notification service you can simply call their methods there.
