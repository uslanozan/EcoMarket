import 'package:ecomarket/data/api/gemini_api.dart';
import 'package:ecomarket/presentation/providers/gemini_provider.dart';
import 'package:ecomarket/presentation/providers/product_provider.dart';
import 'package:ecomarket/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ecomarket/l10n/app_localizations.dart';
import 'package:provider/provider.dart';


import 'config/theme/app_theme.dart';
import 'presentation/providers/locale_provider.dart';
import 'presentation/providers/theme_provider.dart';
import 'presentation/screens/home_screen.dart';
import 'core/globals/globals.dart' as global;


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Check for everything is ready for init
  final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
  global.global_language = deviceLocale.languageCode == 'tr' ? 'Turkish' : 'English';
  await dotenv.load(fileName: ".env"); // Loading .env
  GeminiApiService.initialize(); // Gemini init
  runApp(const EcoMarketApp());
}


class EcoMarketApp extends StatelessWidget {
  const EcoMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => GeminiProvider()),
        ChangeNotifierProvider(create: (_) => ThemeModeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: Consumer2<ThemeModeProvider, LocaleProvider>(
        builder: (context, themeProvider, localeProvider, _) {
          return MaterialApp(
            title: 'EcoMarket',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeProvider.themeMode,
            locale: localeProvider.locale,
            supportedLocales: const [
              Locale('en'),
              Locale('tr'),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: const LoginScreen(),
          );
        },
      ),
    );
  }
}
