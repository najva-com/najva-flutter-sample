package com.najva.najvaflutter;

import com.google.firebase.messaging.RemoteMessage;
import com.najva.najvasdk.Service.NajvaMessagingService;

import java.util.Map;

public class NajvaPluginService extends NajvaMessagingService {

    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        Map<String, String> data = remoteMessage.getData();
        String str = data.get("json-data");
        NajvaflutterPlugin plugin = NajvaflutterPlugin.getInstance();
        if (plugin != null && plugin.shouldHandleJson()) {
            plugin.onJSONDataReceived(str);
        } else {
            super.onMessageReceived(remoteMessage);
        }
    }
}
