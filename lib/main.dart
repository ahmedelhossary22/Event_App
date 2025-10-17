import 'package:bot_toast/bot_toast.dart';
import 'package:event_app/core/routes/app_route.dart';
import 'package:event_app/core/routes/page_routes_name.dart';
import 'package:event_app/core/services/loading_services.dart';
import 'package:event_app/core/theme/app_theme_manger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'modules/app_manager/app_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: const MyApp(),
    ),
  );
  configLoading();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return MaterialApp(
      title: 'Event App',
      theme: AppThemeManger.lightTheme,
      darkTheme: AppThemeManger.darkTheme,
      themeMode: provider.currentTheme == 'light'
          ? ThemeMode.light
          : ThemeMode.dark,
      locale: Locale(provider.currentLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: PageRoutesName.intial,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(builder: BotToastInit()),
    );
  }
}
