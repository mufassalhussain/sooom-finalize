import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soom_net/connections/NetworkProvider.dart';
import 'package:soom_net/routes.dart';
import 'package:soom_net/screens/home/home_screen.dart';
import 'package:soom_net/screens/launch_screen.dart';
import 'package:soom_net/screens/sign_in/sign_in_screen.dart';
import 'package:soom_net/theme.dart';
import 'connections/no_connection.dart';
import 'constants.dart';
import 'l10n/local.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: L10n.all,
      path: 'assets/l10n',
      fallbackLocale: L10n.all[0],
      child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  languageSelction() async {
    var sharedStore = await SharedPreferences.getInstance();
    var getLang = sharedStore.getString('lang') ?? null;
    if (getLang != null) {
      log("Default $getLang");
      context.setLocale(Locale('$getLang'));
    } else {
      log("Default en");
      context.setLocale(Locale('en'));
    }
    print(getLang);
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin fltNotification =
      FlutterLocalNotificationsPlugin();
  bool isloggedin = false;
  void _requestPermissions() {
    fltNotification
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    fltNotification
        .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void pushFCMtoken() async {
    print(await messaging.getToken());
  }

  Future<void> initMessaging() async {
    var androiInit = AndroidInitializationSettings('drawable/ic_launcher');
    var iosInit = IOSInitializationSettings();
    var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);
    fltNotification = FlutterLocalNotificationsPlugin();
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('1', 'channelName',
            priority: Priority.high,
            importance: Importance.high,
            enableLights: true,
            playSound: true,
            color: Color(0xFF218bd4),
            icon: 'drawable/ic_launcher');
    await fltNotification.initialize(initSetting,
        onSelectNotification: (String? payload) async {});

    var iosDetails = IOSNotificationDetails(presentSound: true);
    final NotificationDetails generalNotificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosDetails,
    );

    //In app
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      fltNotification.show(notification.hashCode, notification!.title,
          notification.body, generalNotificationDetails,
          payload: message.data['action']);
    });
  }

  @override
  void initState() {
    languageSelction();
    _requestPermissions();
    pushFCMtoken();
    initMessaging();

    //FlutterNativeSplash.remove();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'soom_net',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: theme(),
      home: Provider<NetworkProvider>(
        create: (context) => NetworkProvider(),
        child: Consumer<NetworkProvider>(
            builder: (context, value, _) => MyAppMain(networkProvider: value)),
      ),
      routes: routes,
    );
  }
}

class MyAppMain extends StatefulWidget {
  final NetworkProvider networkProvider;

  const MyAppMain({Key? key, required this.networkProvider}) : super(key: key);

  @override
  State<MyAppMain> createState() => _MyAppMainState();
}

class _MyAppMainState extends State<MyAppMain> {
  @override
  void dispose() {
    widget.networkProvider.disposeStreams();
    super.dispose();
  }

  Stream<String> getLoginState(BuildContext context) async* {
    var sharedData = await SharedPreferences.getInstance();
    var data = sharedData.getString("access_token");
    if (data == '' || data == null) {
      yield '';
    } else {
      yield data;
    }

    //do a db fetch here

//await Future.delayed(Duration(seconds: 5)); // simulate a delay.
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityResult>.value(
      value: widget.networkProvider.networkStatusController!.stream,
      initialData: ConnectivityResult.mobile,
      child: Consumer<ConnectivityResult>(
        builder: (context, value, _) {
          if (value == null) {
            return NoConnectionScreen();
          }
          return value != ConnectivityResult.none
              ? value == ConnectivityResult.mobile ||
                      value == ConnectivityResult.wifi
                  ? MultiProvider(providers: [
                      StreamProvider<String>(
                        create: getLoginState,
                        initialData: "",
                      ),
                    ], child: LaunchScreen())

                  // Consumer<String>(
                  //     builder: (context, userToken, child) {
                  //   if (userToken != '') {
                  //     FlutterNativeSplash.remove();
                  //     return HomeScreen();
                  //   } else {
                  //     if (userToken == '' && userToken.isEmpty) {
                  //       FlutterNativeSplash.remove();
                  //       return SignInScreen();
                  //     }

                  //     return Center(
                  //       child: spinkit,
                  //     );
                  //   }

                  //   // replace the return with your shimmer widget
                  // }))

                  : NoConnectionScreen()
              : NoConnectionScreen();
        },
      ),
    );
  }
}
