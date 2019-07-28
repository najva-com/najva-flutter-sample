package com.najva.najvaflutter;

import android.util.Log;

import com.najva.najvasdk.Class.NajvaUserHandler;

/**
 * najva plugin user handler
 * created by shayan
 * simply passing token to the NajvaFlutterPlugin class
 */
public class NajvaPluginUserHandler extends NajvaUserHandler {

    private INajvaPluginUserHandler iNajvaPluginUserHandler;

    public NajvaPluginUserHandler(INajvaPluginUserHandler iNajvaPluginUserHandler) {
        this.iNajvaPluginUserHandler = iNajvaPluginUserHandler;
    }

    @Override
    public void najvaUserSubscribed(String token) {
        Log.d("NajvaPluginUserHandler", token);
        iNajvaPluginUserHandler.najvaUserSubscribed(token);
    }

    public interface INajvaPluginUserHandler {
        void najvaUserSubscribed(String token);
    }
}
