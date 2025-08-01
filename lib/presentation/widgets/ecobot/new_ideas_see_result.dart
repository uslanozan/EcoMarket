import 'package:ecomarket/config/theme/app_theme.dart';
import 'package:ecomarket/core/globals/globals.dart';
import 'package:ecomarket/core/utils/logger.dart';
import 'package:ecomarket/l10n/app_localizations.dart';
import 'package:ecomarket/presentation/providers/gemini_provider.dart';
import 'package:ecomarket/presentation/screens/new_ideas_result.dart';
import 'package:ecomarket/presentation/widgets/doodle_background.dart';
import 'package:ecomarket/presentation/widgets/question_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class NewIdeasSeeResult extends StatefulWidget {
  const NewIdeasSeeResult({
    super.key,
  });



  @override
  State<NewIdeasSeeResult> createState() => _NewIdeasSeeResult();
}

class _NewIdeasSeeResult extends State<NewIdeasSeeResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            DoodleBackground(
              child: Container(
                height: 600,
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.answeredAllQuestions,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NewIdeasResult(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.lightbulb),
                      label: Text(AppLocalizations.of(context)!.seeTheNewIdeas),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
