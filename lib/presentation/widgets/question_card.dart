import 'package:ecomarket/config/theme/app_theme.dart';
import 'package:ecomarket/core/globals/globals.dart';
import 'package:ecomarket/core/utils/text_highlight.dart';
import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,
    required this.question,
  });

  final String question;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 3),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface, // Temaya uyumlu arka plan
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: RichText(
        text: highlightWordsInText(
          text: question,
          highlights: global_language == "Turkish"
              ? global_trHighlightWordsQuestion
              : global_enHighlightWordsQuestion,
          normalStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
          highlightStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: AppTheme.primaryGreen,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
