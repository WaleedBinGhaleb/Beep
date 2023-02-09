// ignore_for_file: prefer_const_constructors
import 'package:beep/Models/MessagesModel.dart';
import 'package:beep/Services/NotificationService.dart';
import 'package:beep/Services/StorageService.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'Models/AuthData.dart';
import 'Models/UsersModel.dart';
import 'Pages/Splash.dart';
import 'Services/AuthService.dart';
import 'Services/DatabaseService.dart';
import 'Utilities/NavBar.dart';
import 'Utilities/Theme.dart';
import 'Utilities/ThemeService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  Get.put(NotificationService());

  runApp(MultiProvider(providers: [
    Provider<AuthService>(
      create: (_) => AuthService(),
    ),
    ChangeNotifierProvider(create: (_) => AuthData()),
    ChangeNotifierProvider(create: (_) => UserModel()),
    ChangeNotifierProvider(create: (_) => MessagesModel()),
    ChangeNotifierProvider(create: (_) => StorageService()),
    Provider<DatabaseService>(
      create: (_) => DatabaseService(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return GetMaterialApp(
          title: 'Beep',
          debugShowCheckedModeBanner: false,
          theme: Themes.light,
          darkTheme: Themes.dark,
          themeMode: ThemeService().theme,
          builder: BotToastInit(),
          navigatorObservers: [BotToastNavigatorObserver()],
          home: StreamBuilder(
            stream: Provider.of<AuthService>(context, listen: false).user,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                BotToast.showText(
                    text: "Something wrong happened. Please try again",
                    duration: const Duration(seconds: 3),
                    animationDuration: const Duration(seconds: 1),
                    clickClose: true,
                    contentColor: Colors.red,
                    textStyle:
                        GoogleFonts.openSans(color: Colors.white, fontSize: 16),
                    borderRadius: BorderRadius.circular(30));
              }
              if (snapshot.hasData) {
                return NavBar();
              } else {
                return Splash();
              }
            },
          ),
        );
      },
    );
  }
}
