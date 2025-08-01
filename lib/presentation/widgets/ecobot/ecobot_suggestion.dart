import 'package:ecomarket/presentation/providers/gemini_provider.dart';
import 'package:flutter/material.dart';
import 'package:ecomarket/l10n/app_localizations.dart';

class EcoBotSuggestion extends StatelessWidget {
  const EcoBotSuggestion({
    super.key,
    required this.local,
    required this.geminiProvider,
  });

  final AppLocalizations local;
  final GeminiProvider geminiProvider;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(Icons.auto_awesome, size: 30, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    local.ecoBotSuggestion,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Burada günlük öneriyi gösteriyoruz
                  geminiProvider.isLoading
                      ? CircularProgressIndicator(color: Colors.white70)
                      : Text(
                    geminiProvider.dailySuggestion.isEmpty ? AppLocalizations.of(context)!.loading : geminiProvider.dailySuggestion,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
