import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/home/home_screen.dart';
import 'package:todo/my_theme.dart';
import 'package:todo/providers/app_config_provider.dart';
import 'package:todo/task-list/screens/edit_task_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
void main(){
  runApp(ChangeNotifierProvider(
    create: (context) => AppConfigProvider(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return MaterialApp(
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName : (context)=>HomeScreen(),
        EditTaskScreen.routeName:(context)=>EditTaskScreen()
      },
      theme: provider.appTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.appLanguage),

    );
  }
}
