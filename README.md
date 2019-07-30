# najvasdk

a simple sample for implementing `najva-android-sdk` in flutter

## Getting Started
here is the guidline to implement `najva-androd-sdk` in your flutter project

### Adding library
in `android/app`folder in your project root open `build.gradle` file and add following code in `dependencies` section.

```
impementation 'com.najva.sdk:najva-android-sdk:1.0.6'
```
and then enter commands bellow in `android studio`'s terminal to `gradle` refreshes your android project
```
$ cd android
$ ./gradlew build
```

or you can open android folder as a new `android` project and let gradle sync it.

### Changes in Dart code
in your `main.dart` file add these lines to `MyApp` class body.
```
static const platform = const MethodChannel(‘CHANNEL_NAME’);//replce with your channel name
static isNajvaInitialized = false;
```

and then add this `Feature` to `MyApp` class body

```
Featur<void> _getNajvaInitialized() async {
  bool state;
  Try {
    final bool result = await platform.invokeMethod(‘init’);
      state = result;
    } on PlatformException catch(e) {
      state = false;
    }
  isNajvaInitialized = state;
}
```
then in `build` method before `return` add this line.
```
_getNajvaInitialized();
```

### Changes in android code
in `app` module in `android` project open `MainActivity.class` file and add this line
```
static final String CHANNEL = “CHANNEL_NAME”; //replce with your channel name
```
and then add these codes in `onCreate` method
```
new MethodChannel(getFlutterView(),CHANNEL).setMethodCallHandler( new MethodChannel.MethodCallHandler() {
  @Override
  public void onCallMethod(MethodCall methodCall,MethodCall.Result result){
    if(methodCall.method.equals(“init”)){
      init();
      result.success(true);
    } else {
      result.notImplemented();
    }
  }
});
```

and add this method to the `MainActivity` class
```
public void init() {
	Najva.initialize(context,CAMPAIGN_ID,WEBSITE_ID,API_KEY,LOCATION_ENABLED);
}
```

and everything should work fine now :)
