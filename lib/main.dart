import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ETCP WIFI调试器',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Wi-Fi调试器'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platformMethodChannel = const MethodChannel('ADB_TCP_PORT');
  String nativeMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image(
              alignment: AlignmentDirectional(0, 0),
              width: 200,
              height: 50,
              image: AssetImage('images/ic_logo_etcp_black.jpg'),
              fit: BoxFit.fill,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                    child: Text(
                      "打开",
                      style: TextStyle(
                        fontSize: 28.0,
                      ),
                    ),
                    textColor: Colors.black,
                    padding: const EdgeInsets.only(
                        left: 50.0, right: 50.0, top: 10, bottom: 10),
                    onPressed: () => doNativeSuff("open")),
                RaisedButton(
                    child: Text(
                      "关闭",
                      style: TextStyle(
                        fontSize: 28.0,
                      ),
                    ),
                    textColor: Colors.black,
                    padding: const EdgeInsets.only(
                        left: 50.0, right: 50.0, top: 10, bottom: 10),
                    onPressed: () => doNativeSuff("close")),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 20.0),
              child: Text(
                nativeMessage,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 38.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> doNativeSuff(methodName) async {
    String _message; // 1
    print("===>1: $methodName");
    try {
      final String result =
          await platformMethodChannel.invokeMethod(methodName); // 2

      _message = result;
      print("===>2: $result");
    } on PlatformException catch (e) {
      _message = "Sadly I can not change your life: ${e.message}.";
    }
    setState(() {
      nativeMessage = _message; // 3
    });
  }
}
