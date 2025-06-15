package com.example.wimax_pentest

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    /**
     * Optional: Configure the Flutter engine
     */
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        // Register plugins with the Flutter engine
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        
        // Add any additional plugin initialization here
        // Example: Firebase.initializeApp(this)
    }

    /**
     * Optional: Handle onBackPressed events
     */
    override fun onBackPressed() {
        // Let Flutter handle back navigation by default
        if (flutterEngine?.navigationChannel?.popRoute() == false) {
            // If Flutter didn't handle the back press, call super
            super.onBackPressed()
        }
    }
}