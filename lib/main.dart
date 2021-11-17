import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:http/http.dart' as http;
/*
Future<Album> createAlbum(String title) async {
  final response = await http.post(
    Uri.parse('http://192.168.1.200'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );
*/
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState(){
    super.initState();
    initPlatformState();
  }


  static final String oneSignalAppID = "17754358-a902-4da1-846f-f314a6c20e50";

  static String user_id = "osUserID";
  Future<void> initPlatformState() async {
    OneSignal.shared.setAppId(oneSignalAppID);
    final status = await OneSignal.shared.getDeviceState();
    final String? osUserID = status?.userId;
    print('id: ${osUserID}');
    user_id = osUserID.toString();
    /*Text(
      ,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );*/

  }

  sendID()async{
    var response = await http.post(Uri.parse("http://192.168.1.200"),
        body: {
          "id": user_id,

        });
    print(response.body);
  }
  postData()async{
    var response = await http.post(Uri.parse("http://192.168.1.200"),
        body: {
          "cry": "true",
        });
    print(response.body);
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text("title"),
      ),
      body: Center(
        child: RaisedButton.icon(
          onPressed: sendID,
          icon: Icon(
            Icons.brightness_5_outlined
          ),
          label: Text('Connect to Lale'),
          color: Colors.pinkAccent,
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: postData,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );

  }


/*
  Future<void> initOneSignal(BuildContext context) async {
    /// Set App Id.
    await OneSignal.shared.setAppId(SahityaOneSignalCollection.appID);

    /// Get the Onesignal userId and update that into the firebase.
    /// So, that it can be used to send Notifications to users later.̥
    final status = await OneSignal.shared.getDeviceState();
    final String? osUserID = status?.userId;
    // We will update this once he logged in and goes to dashboard.
    ////updateUserProfile(osUserID);
    // Store it into shared prefs, So that later we can use it.
    Preferences.setOnesignalUserId(osUserID);

    // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    await OneSignal.shared.promptUserForPushNotificationPermission(
      fallbackToSettings: true,
    );

    /// Calls when foreground notification arrives.
    OneSignal.shared.setNotificationWillShowInForegroundHandler(
      handleForegroundNotifications,
    );

    /// Calls when the notification opens the app.
    OneSignal.shared.setNotificationOpenedHandler(handleBackgroundNotification);
  }*/
}
