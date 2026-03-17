package com.example.otc_app

import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine


class MainActivity: FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        window.statusBarColor = 0
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        getOpenData(intent);
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        PayChannelCallHander(flutterEngine, "flutterNativeChannel", this.context);
    }

    private fun getOpenData(intent: Intent) {
        try {
            // 获取SharedPreferences对象
            val sharedPreferences = getSharedPreferences("MyPrefs", MODE_PRIVATE)
            val editor = sharedPreferences.edit()
            editor.putString("scheme", "")
            editor.apply()

            // 获取Intent
            var intent1 = intent.data;
            // 获取Uri
            if (intent1 != null) {
                val query = intent1.query;
                editor.putString("scheme", query.toString());
                editor.apply()
            }
        } catch (e: Exception) {
            Log.e("scheme-", e.message, e)
        }
    }


}
