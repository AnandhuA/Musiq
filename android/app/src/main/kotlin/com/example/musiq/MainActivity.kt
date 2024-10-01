package com.example.musiq // Make sure this matches your actual package name

import android.content.Context
import android.media.AudioManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "audio_focus_channel"
    private lateinit var audioManager: AudioManager
    private lateinit var audioFocusChangeListener: AudioManager.OnAudioFocusChangeListener

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

    
        audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager

       
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "requestAudioFocus" -> {
                    val success = requestAudioFocus()
                    result.success(success) 
                }
                "abandonAudioFocus" -> {
                    abandonAudioFocus()
                    result.success(null)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }


        audioFocusChangeListener = AudioManager.OnAudioFocusChangeListener { focusChange ->
            when (focusChange) {
                AudioManager.AUDIOFOCUS_GAIN -> {
                 
                }
                AudioManager.AUDIOFOCUS_LOSS -> {
                   
                }
                AudioManager.AUDIOFOCUS_LOSS_TRANSIENT -> {
              
                }
                AudioManager.AUDIOFOCUS_LOSS_TRANSIENT_CAN_DUCK -> {
        
                }
            }
        }
    }

    private fun requestAudioFocus(): Boolean {
        // Request audio focus
        val focusRequestResult = audioManager.requestAudioFocus(
            audioFocusChangeListener,
            AudioManager.STREAM_MUSIC,
            AudioManager.AUDIOFOCUS_GAIN
        )
        
        // Return true if focus is gained
        return focusRequestResult == AudioManager.AUDIOFOCUS_REQUEST_GRANTED
    }

    private fun abandonAudioFocus() {
        audioManager.abandonAudioFocus(audioFocusChangeListener)
        // Log or handle focus abandonment as needed
    }
}
