package com.jason.myfluttertest.channel;

import android.app.Activity;
import android.content.Intent;

import com.jason.myfluttertest.ui.MyActivity;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

/**
 * Created by jason on 2018/10/9.
 */

public class AboutMeChannel implements MethodChannel.MethodCallHandler {

    public static String CHANNEL = "com.jason.myfluttertest/module_my";
    static MethodChannel channel;
    private Activity activity;

    private  AboutMeChannel(Activity activity){
        this.activity = activity;
    }


    public static void registerWith(PluginRegistry.Registrar registrar){
        channel = new MethodChannel(registrar.messenger(),CHANNEL);
        AboutMeChannel aboutMeChannel = new AboutMeChannel(registrar.activity());
        channel.setMethodCallHandler(aboutMeChannel);
    }


    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
           if (methodCall.method.equals("go2AboutMe")){
               Intent intent = new Intent(activity, MyActivity.class);
               activity.startActivity(intent);
               result.success("success");
           }else {
               result.notImplemented();
           }
    }
}
