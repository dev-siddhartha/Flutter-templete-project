package com.example.neo_flutter

import com.example.neo_flutter.channels.RASPServiceChannel
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterFragmentActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        RASPServiceChannel.register(applicationContext, flutterEngine)
    }
}
