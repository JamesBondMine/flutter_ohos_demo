package com.example.otc_app;

import static android.content.Context.MODE_PRIVATE;

import android.content.Context;
import android.os.Handler;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import kotlin.reflect.KVariance;

import android.content.Context;
import android.content.SharedPreferences;


public class PayChannelCallHander {

    private final FlutterEngine flutterEngine;
    private final String channelName;

    private final Context context;


    PayChannelCallHander(FlutterEngine flutterEngine, String channelName, Context context) {

        this.context = context;
        this.flutterEngine = flutterEngine;
        this.channelName = channelName;

        setupMethodChannel();
    }

    private void setupMethodChannel() {
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), "flutterNativeChannel")
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("schemeQuery")) {
                                String res = schemeDataValue(context);
                                result.success(res);
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }


    private String schemeDataValue(Context context){
        // 获取SharedPreferences对象
        SharedPreferences sharedPreferences = context.getSharedPreferences("MyPrefs", MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPreferences.edit();
        // 使用Handler的postDelayed方法来延时执行runnable
        Handler handler = new Handler();
        handler.postDelayed(new Runnable() {
            @Override
            public void run() {
                // 这里是延时后需要执行的代码
                editor.putString("scheme", "");
                editor.apply();
            }
        }, 4000);
        return sharedPreferences.getString("scheme", "");
    }
}
