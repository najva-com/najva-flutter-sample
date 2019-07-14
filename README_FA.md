# پلاگین فلاتر برای نجوا
پلاگین نجوا یک پلاگین ساده است برای استفاده از کتابخانه نجوا در کد فلاتر

## پیاده سازی
برای پیاده سازی نجوا در پروژه خود باید پلاگین نجوا را به پروژه خود اضافه کنید.

### تعییرات در کد
برای استفاده از پلاگین نجوا در کد دارت خود یک کلاس با نام `Najva` بسازید و از کلاس `NajvaPlugin` ارث ببرید.
```
class Najva extends NajvaFlutter {
    
}
```
کلاس `NajvaFlutter` سه تابع با نام های `init` , `initUserHandling`و `initJSONNotification` دارد.

با صدا زدن تابع `init` و پاس دادن مقدار های مناسب کتابخانه نجوا شروع به کار خواهد کرد و شما میتوانید نوتیفیکیشن دریافت کنید.
```
init(CHAMPAIGN_ID,WEBSITE_ID,API_KEY,LOCATION_ENABLED);
```

مقدار `CHAMPAIGN_ID` مشخص کننده برای کمپ شما است که میتوانید در [پنل](https://app.najva.com/login) به آن دسترسی داشته باشید.

مقدار `WEBSITE_ID` مشخص کننده برای وب سایت شما است که میتوانید در [پنل](https://app.najva.com/login) به آن دسترسی داشته باشید.

مقدار `API_KEY` کلید شما برای دسترسی به نجوا است و میتوانید در [پنل](https://app.najva.com/login) به آن دسترسی داشته باشید.

مقدار `LOCATION_ENABLED` یک متغییر بولی است که اگر مقدار صحیح اخذ کند کتابخانه نجوا از سیستم مکان یابی کاربر برای بهبود سیستم نوتیفیکیشن استفاده خواهد کرد. همچنین اگر ورژن اندروید کاربر بالا تر از ۶.۰ باشد اجازه برای دسترسی به سیستم مکان یابی از کاربر دریافت خواهد شد.

با صدا زدن تابع `initUserHandling` پلاگین نجوا توکن کاربر ها را دریافت کرده و در تابع `onUserSubscribed` فراخوانی میکند.

```
initUserHandling();

@override
  void onUserSubscribed(String token) {
    print(token);
    
    sendTokenToServer(token);
    }
```

با صدا زدن تابع `initJSONNotification` پلاگین نجوا نوتیفیکیشن های دریافتی را به تابع `onNewJSONDataReceived` انتقال میدهد و کتابخانه نجوا نوتیفیکیشنی برای کاربر ارسال نمیکند.

```
initJSONNotification();

@override
  void onNewJSONDataReceived(String jsonData) {
    print(jsonData);
    
    doCustomAction(jsonData);
  }
```

## استفاده نکردن از پلاگین نجوا و پیاده سازی دستی

برای پیاده سازی دستی و استفاده نکردن از پلاگین نجوا دو راه وجود دارد.اول حذف پلاگین نجوا و اضافه کردن کتابخانه نجوا به پیشنیاز های اندروید.

برای اضافه کردن کتابخانه نجوا تکه کد زیر را به فایل `build.gradle` ماژول اپلیکیشن برنامه خود اضافه کنید

```
implementation 'com.najva.sdk:najva-android-sdk:1.0.6'
```

سپس در فایل `AndroidManifest.xml` تکه کد زیر را اضافه کنید.

```
<service
    android:name="com.najva.najvasdk.Service.NajvaMessagingService" 
    tools:node="remove" />
```
کد بالا باعث میشود تا سرویس نجوا از فایل مانیفیست برنامه شما حذف شود.

سپس کد زیر را به فایل مانیفست اضافه کنید 

```
<service android:name=".MyFcmService">
    <intent-filter>
        <action android:name="com.google.firebase.MESSAGING_EVENT" />
    </intent-filter>
</service>
```

* توجه داشته باشید که تمامی تغییرات بالا باید در تگ `<application>` اعمال شوند.

حال یک کلاس با نام `MyFcmService` بسازید.

```
public class MyFcmService extends FirebaseMessagingService {

}
```

کلاس `FirebaseMessagingService` دارای دو تابع با نام های `onMessageReceived` و `onNewToken` است.

شما میتوانید با پیاده سازی کردن این تابع ها در زمان دریافت پیام جدید یا تغییر کردن توکن کاربر کد دلخواه خودتان را بنویسید و همچنین میتوانید با صدا زدن تابع های کتابخانه نجوا اجازه دهدید تا نجوا نوتیفیکیشن های شما را ارسال کند.

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

یا اگر از سرویس پوش نوتیفیکشن دیگری استفاده میکنید تابع های آنها را در اینجا صدا بزنید.
