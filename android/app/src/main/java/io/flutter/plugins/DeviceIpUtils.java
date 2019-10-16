package io.flutter.plugins;

import android.content.Context;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.util.Log;

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.util.ArrayList;
import java.util.Collections;

public class DeviceIpUtils {


    private String getAddressIp(Context cxt) {

        WifiManager wifiManager = (WifiManager) cxt.getSystemService(Context.WIFI_SERVICE);
        //判断wifi是否开启

        WifiInfo wifiInfo = wifiManager.getConnectionInfo();
        int ipAddress = wifiInfo.getIpAddress();
        String ip = intToIp(ipAddress);

        return ip;

    }


    //获取Wifi ip 地址
    private String intToIp(int i) {
        return (i & 0xFF) + "." +
                ((i >> 8) & 0xFF) + "." +
                ((i >> 16) & 0xFF) + "." +
                (i >> 24 & 0xFF);
    }


    public static String getLocalIpV4Address() {
        try {
            String ipv4;
            ArrayList<NetworkInterface> nilist = Collections.list(NetworkInterface.getNetworkInterfaces());
            for (NetworkInterface ni : nilist) {
                ArrayList<InetAddress> ialist = Collections.list(ni.getInetAddresses());
                for (InetAddress address : ialist) {
                    if (!address.isLoopbackAddress() && !address.isLinkLocalAddress()) {
                        ipv4 = address.getHostAddress();
                        return ipv4;
                    }
                }

            }

        } catch (SocketException ex) {
            Log.e("localip", ex.toString());
        }
        return "";
    }
}
