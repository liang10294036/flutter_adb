package flutter.example.flutteradb

import android.os.Bundle
import android.util.Log

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.DeviceIpUtils
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugins.RootCmd

class MainActivity : FlutterActivity() {

    private val CHANNEL = "ADB_TCP_PORT"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        MethodChannel(flutterView, CHANNEL).setMethodCallHandler { methodCall, result ->

            Log.d("MainActivity", "${methodCall.method}")
            if ("open" == methodCall.method) {
                val reponse = RootCmd.execRootCmdSilent("setprop service.adb.tcp.port 5555 \n stop adbd \n start adbd")
                if (reponse == -1) {
                    result.success("打开失败，需要root")
                } else {
                    result.success("adb connect ${DeviceIpUtils.getLocalIpV4Address()}")
                }
            } else if ("close" == methodCall.method) {
                RootCmd.execRootCmd("stop adbd")
                result.success("关闭！")
            }

        }


    }
}
