package com.dotsocket.ds_book_app

import com.tekartik.sqflite.SqflitePlugin
import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry


class Application : FlutterApplication(), PluginRegistry.PluginRegistrantCallback {
    override fun onCreate() {
        super.onCreate()
    }

    override fun registerWith(registry: PluginRegistry?) {
        SqflitePlugin.registerWith(registry?.registrarFor("com.tekartik.sqflite.SqflitePlugin"));
    }
}