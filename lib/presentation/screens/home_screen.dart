import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../config/locale/locale_provider.dart';
import '../../config/theme/theme_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(local.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              final localeProvider = context.read<LocaleProvider>();
              localeProvider.setLocale(
                localeProvider.locale.languageCode == 'tr'
                    ? const Locale('en')
                    : const Locale('tr'),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              context.read<ThemeModeProvider>().toggleTheme();
            },
          ),
        ],
      ),
      body: Center(
        child: Text(local.homeWelcome),
      ),
    );
  }
}
