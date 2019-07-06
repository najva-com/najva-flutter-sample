package com.najva.najvaflutter;

import android.content.Context;
import android.util.Log;
import android.widget.Toast;

import com.najva.najvasdk.Class.Najva;
import com.najva.najvasdk.Class.NajvaUserHandler;

import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;

/**
 * NajvaflutterpluginPlugin
 * created by shayan
 * flutter plugin for implement all features of najva android sdk in flutter
 **/
public class NajvaflutterPlugin implements MethodCallHandler, NajvaPluginUserHandler.INajvaPluginUserHandler {

    /**
     * final variables used for keys in arguments map
     */
    public static final String CAMPAIGN_ID = "champaignId";
    public static final String WEBSITE_ID = "website_id";
    public static final String API_KEY = "api_key";
    public static final String LOCATION = "location";

    /**
     * final variables used for method names
     */
    public static final String INIT = "init";
    public static final String HANDLE_JSON_NOTIFICATION = "handle_json_notification";
    public static final String HANDLE_USERS_TOKEN = "handle_users_token";

    /**
     * final variables for dart method names
     */
    public static final String NEW_JSON_DATA = "onNewJSONData";
    public static final String NEW_USER_SUBSCRIBED = " onUserSubscribed";

    /**
     * static instance for singleton implementation
     */
    private static NajvaflutterPlugin instance;



    /**
     * get instance method for singleton object
     *
     * @param channel is the MethodChannel used to receive (send) signals from (to) dart
     * @param context is context used to initialize najva library
     * @return singleton object of NajvaFlutterPlugin
     */
    public static NajvaflutterPlugin getInstance(MethodChannel channel, Context context) {
        if (instance == null) instance = new NajvaflutterPlugin(channel, context);
        return instance;
    }

    /**
     * get instance method for singleton object
     *
     * @return null if getInstance with methodChannel and Context has'nt been called.
     */
    public static NajvaflutterPlugin getInstance() {
        return instance;
    }

    /**
     * Plugin registration.
     */
    public static void registerWith(PluginRegistry.Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "najvaflutterplugin");
        channel.setMethodCallHandler(getInstance(channel, registrar.activity()));
    }

    /* class implementation */

    private MethodChannel channel;
    private Context context;

    private boolean shouldHandleJson = false;
    private boolean shouldHandleUsers = false;



    private NajvaflutterPlugin(MethodChannel channel, Context context) {
        this.channel = channel;
        this.context = context;
    }


    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals(INIT)) {
            result.success(init((Map<String, String>) call.arguments));
        } else if (call.method.equals(HANDLE_JSON_NOTIFICATION)) {
            handleJSONNotification(result);
            result.success(null);
        } else if (call.method.equals(HANDLE_USERS_TOKEN)){
            handleUsersToken();
            result.success(null);
        }else {
            result.notImplemented();
        }
    }

    private void handleUsersToken() {
        shouldHandleUsers = true;
        initUserHandler(new NajvaPluginUserHandler(this));
    }

    private void handleJSONNotification(Result result) {
        shouldHandleJson = true;
    }

    public void initUserHandler(NajvaUserHandler handler) {
        Najva.setUserHandler(handler);
    }

    private boolean init(Map<String, String> arguments) {

        // checking if argument are illegal
        if (arguments.get(CAMPAIGN_ID) == null)
            throw new IllegalArgumentException("Najva: CHAMPAGIN_ID not found : Initialization failed");
        if (arguments.get(WEBSITE_ID) == null)
            throw new IllegalArgumentException("Najva: WEBSITE_ID not found : Initialization failed");
        if (arguments.get(API_KEY) == null)
            throw new IllegalArgumentException("Najva: API_KEY not found : Initialization failed");
        if (arguments.get(LOCATION) == null)
            throw new IllegalArgumentException("Najva: LOCATION not found : Initialization failed");

        Najva.initialize(context,
                Integer.parseInt(arguments.get(CAMPAIGN_ID)),
                Integer.parseInt(arguments.get(WEBSITE_ID)),
                arguments.get(API_KEY),
                Boolean.parseBoolean(arguments.get(LOCATION)));

        return true;
    }

    /**
     * calls method on dart code when new JSON data has been received
     *
     * @param data is JSONObject has received from najva service
     */
    public void onJSONDataReceived(String data) {
        channel.invokeMethod(NEW_JSON_DATA, data);
    }

    @Override
    public void najvaUserSubscribed(String token) {
        channel.invokeMethod(NEW_USER_SUBSCRIBED, token);
    }

    /**
     * because of keeping context in static fields it's necessary to release context when we are done using it
     * this method must be called on 'onDestroy' method of activity
     */
    public void release() {
        context = null;
        channel = null;
    }

    public boolean shouldHandleJson() {
        return shouldHandleJson;
    }

    public boolean shouldHandleUsers() {
        return shouldHandleUsers;
    }
}