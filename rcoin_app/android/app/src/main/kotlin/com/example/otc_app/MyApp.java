package com.example.otc_app;

import android.app.Application;
import android.content.Context;
import android.content.SharedPreferences;

public class MyApp extends Application {
    @Override
    public void onCreate() {
        super.onCreate();

        Context context = this.getApplicationContext();

        SharedPreferences sharedPreferences = context.getSharedPreferences("MyPrefs", Context.MODE_PRIVATE);
        String vv = sharedPreferences.getString("umengMark", "");
        if (vv != null && vv!= ""){
        }
    }
}