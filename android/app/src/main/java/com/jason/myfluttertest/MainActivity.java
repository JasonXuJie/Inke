package com.jason.myfluttertest;

import android.os.Bundle;

import com.jason.myfluttertest.channel.AboutMeChannel;
import com.jason.myfluttertest.channel.WebChannel;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;



public class MainActivity extends FlutterActivity {



  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    //channel
    AboutMeChannel.registerWith(this.registrarFor(AboutMeChannel.CHANNEL));
    WebChannel.registerWith(this.registrarFor(WebChannel.CHANNEL));

  }
}
