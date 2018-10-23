package com.jason.myfluttertest.channel;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import com.jason.myfluttertest.ui.WebActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

/**
 * Created by jason on 2018/10/9.
 */

public class WebChannel implements MethodChannel.MethodCallHandler {

    public static final String CHANNEL = "com.jason.myfluttertest/web";
    static MethodChannel channel;
    private Activity activity;


    private WebChannel(Activity activity){
        this.activity = activity;
    }


    public static void registerWith(PluginRegistry.Registrar registrar){
        channel = new MethodChannel(registrar.messenger(),CHANNEL);
        WebChannel webChannel = new WebChannel(registrar.activity());
        channel.setMethodCallHandler(webChannel);
    }


    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        if (methodCall.method.equals("go2Web")){
            String url = methodCall.arguments();
            Bundle bundle = new Bundle();
            bundle.putString("url",url);
            Intent intent = new Intent(activity, WebActivity.class);
            intent.putExtras(bundle);
            activity.startActivity(intent);
            result.success("success");
        }else {
            result.notImplemented();
        }
    }
}
