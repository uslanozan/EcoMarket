import 'package:ecomarket/config/theme/app_theme.dart';
import 'package:ecomarket/core/globals/globals.dart';
import 'package:ecomarket/core/utils/text_highlight.dart';
import 'package:ecomarket/presentation/widgets/doodle_background.dart';
import 'package:flutter/material.dart';
import 'package:ecomarket/l10n/app_localizations.dart';
import 'package:ecomarket/widgets/doodle_background.dart'; // path'i senin yapına göre ayarla

class NewQuestionWelcome extends StatelessWidget {
  const NewQuestionWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          DoodleBackground(
            child: Container(
              height: 600,
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              child: RichText(
                text: highlightWordsInText(
                  text: AppLocalizations.of(context)!.newIdeasWelcomeText,
                  highlights: global_language == "Turkish"
                      ? global_trHighlightWords
                      : global_enHighlightWords,
                  normalStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  highlightStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppTheme.primaryGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}
