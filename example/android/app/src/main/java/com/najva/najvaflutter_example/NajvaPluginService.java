package com.najva.najvaflutter_example;

import com.google.firebase.messaging.RemoteMessage;
import com.najva.najvasdk.Service.NajvaMessagingService;

import java.util.Map;

public class NajvaPluginService extends NajvaMessagingService {

    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        Map<String, String> data = remoteMessage.getData();
        String str = data.get("json-data");
//        NajvaflutterPlugin.getInstance().onJSONDataReceived(str);
    }
}
