import 'package:ecomarket/config/theme/app_theme.dart';
import 'package:ecomarket/presentation/providers/gemini_provider.dart';
import 'package:ecomarket/presentation/widgets/doodle_background.dart';
import 'package:ecomarket/presentation/widgets/question_card.dart';
import 'package:flutter/material.dart';

class NewQuestionPage extends StatefulWidget {
  const NewQuestionPage({
    super.key,
    required this.question,
    required this.hint,
  });

  final String question;
  final String hint;

  @override
  State<NewQuestionPage> createState() => _NewQuestionPage1State();
}

//todo: klavye açıldığında QuestionCard aşağı inecek
class _NewQuestionPage1State extends State<NewQuestionPage> {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  QuestionCard(
                    question: widget.question,
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: widget.hint,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
