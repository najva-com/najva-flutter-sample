## Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }


-printmapping out.map

-optimizationpasses 5
-dontusemixedcaseclassnames
-dontskipnonpubliclibraryclasses
-dontpreverify
-verbose
-optimizations !code/simplification/arithmetic,!field/*,!class/merging/*,!code/allocation/variable
-ignorewarnings
-keepparameternames

-keepattributes Signature, Exceptions, *Annotation*, JavascriptInterface, SourceFile, LineNumberTable, LocalVariableTable, LocalVariableTypeTable


# Android suff
-dontnote **apache.http.**

-dontwarn android.support.v4.**

-keepclassmembers class * implements android.os.Parcelable {
      public static final android.os.Parcelable$Creator *;
}

-dontnote android.net.http.*
-dontnote org.apache.commons.codec.**
-dontnote org.apache.http.**

-keep public class android.webkit.JavascriptInterface {}

# Support for Android Advertiser ID.
-keep class com.google.android.gms.common.GooglePlayServicesUtil {*;}
-keep class com.google.android.gms.ads.identifier.AdvertisingIdClient {*;}
-keep class com.google.android.gms.ads.identifier.AdvertisingIdClient$Info {*;}


# Support for Google Play Services
# http://developer.android.com/google/play-services/setup.html
-keep class * extends java.util.ListResourceBundle {
    protected Object[][] getContents();
}

-keep public class com.google.android.gms.common.internal.safeparcel.SafeParcelable {
    public static final *** NULL;
}

-keepnames @com.google.android.gms.common.annotation.KeepName class *
-keepclassmembernames class * {
    @com.google.android.gms.common.annotation.KeepName *;
}



-keep class com.android.volley.** { *; }
-keep class org.apache.commons.logging.**

-keepattributes *Annotation*

-dontwarn org.apache.**



-keep public class com.najva.najvasdk.Class.Najva {
    *;
}


-keep public class com.najva.najvasdk.Class.NajvaPushNotificationHandler {
    public static void handleMessage(android.content.Context, com.google.firebase.messaging.RemoteMessage);
    public static void handleNewToken(android.content.Context, java.lang.String);
}

-keep public class com.najva.najvasdk.Class.NajvaUserHandler {
    *;
}