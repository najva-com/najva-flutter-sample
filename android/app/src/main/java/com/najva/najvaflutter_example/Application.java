package com.najva.najvaflutter_example;
import com.najva.najvaflutter.NajvaFlutterMessagingService;
import com.najva.najvaflutter.NajvaflutterPlugin;
import io.flutter.app.FlutterApplication;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class Application extends FlutterApplication implements PluginRegistrantCallback {
    @Override
    public void onCreate() {
        super.onCreate();
        NajvaFlutterMessagingService.setPluginRegistrant(this);
    }
    @Override
    public void registerWith(PluginRegistry registry) {
        NajvaflutterPlugin.registerWith(registry.registrarFor("com.najva.najvaflutter.NajvaflutterPlugin"));
    }
}