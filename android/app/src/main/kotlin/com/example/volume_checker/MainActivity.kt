package com.example.volume_checker

import android.content.Context
import android.media.AudioManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val Volume_Channel = "samples.flutter.dev/volume"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine){
        // self initialization with default properties
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, Volume_Channel).setMethodCallHandler { call, result ->
            if (call.method == "getVolume"){
                val audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
                val currentVolume = audioManager.getStreamVolume(AudioManager.STREAM_MUSIC)
                result.success(currentVolume) 
            }
            else {
                result.notImplemented()
            }
        }
    }
}
