import 'package:ecomarket/l10n/app_localizations.dart';
import 'package:ecomarket/presentation/widgets/doodle_background.dart';
import 'package:flutter/material.dart';


class SeeResult extends StatefulWidget {
  const SeeResult({
    super.key,
    required this.seeResultFunc,
    required this.navigateLabel,
  });

  final VoidCallback seeResultFunc;
  final String navigateLabel;


  @override
  State<SeeResult> createState() => _SeeResultState();
}

class _SeeResultState extends State<SeeResult> {
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
                      onPressed: widget.seeResultFunc,
                      icon: const Icon(Icons.lightbulb),
                      label: Text(widget.navigateLabel,textAlign: TextAlign.center,),
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
