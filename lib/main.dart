import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo/home/home_screen.dart';
import 'package:todo/providers/app_config_provider.dart';
import 'package:todo/providers/authentication_provider.dart';
import 'package:todo/providers/list_provider.dart';
import 'package:todo/register/register_screen.dart';
import 'package:todo/task-list/screens/edit_task_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'login/login_screen.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FirebaseFirestore.instance.disableNetwork();
  // FirebaseFirestore.instance.settings =
  //     Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AppConfigProvider()),
          ChangeNotifierProvider(create: (_) => ListProvider()),
          ChangeNotifierProvider(create: (_) => AuthenticationProvider()),

        ],
        child: MyApp(),
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return MaterialApp(
      builder: FToastBuilder(),

      initialRoute: LoginScreen.routeName,
      routes: {
        HomeScreen.routeName : (context)=>HomeScreen(),
        EditTaskScreen.routeName:(context)=>EditTaskScreen(),
        RegisterScreen.routeName:(context)=>RegisterScreen(),
        LoginScreen.routeName:(context)=>LoginScreen(),


      },
      theme: provider.appTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.appLanguage),
      debugShowCheckedModeBanner: false,

    );
  }
}
