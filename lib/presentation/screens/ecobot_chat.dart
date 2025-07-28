import 'package:ecomarket/presentation/providers/gemini_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EcobotChat extends StatefulWidget {
  const EcobotChat({super.key});

  @override
  State<EcobotChat> createState() => _EcobotChatState();
}

class _EcobotChatState extends State<EcobotChat> {
  @override
  Widget build(BuildContext context) {
    final geminiProvider = context.watch<GeminiProvider>();
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('Gemini Assistant')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(labelText: 'Prompt yaz'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                context.read<GeminiProvider>().sendPrompt(prompt: "DENEME", fallBackText: AppLocalizations.of(context)!.noResponse);
              },
              child: Text('Gönder'),
            ),
            const SizedBox(height: 24),
            if (geminiProvider.isLoading)
              CircularProgressIndicator()
            else if (geminiProvider.error.isNotEmpty)
              Text('Hata: ${geminiProvider.error}', style: TextStyle(color: Colors.red))
            else
              Text(geminiProvider.response),
          ],
        ),
      ),
    );
  }
}