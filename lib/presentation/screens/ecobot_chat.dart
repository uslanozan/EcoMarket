import 'package:ecomarket/config/theme/app_theme.dart';
import 'package:ecomarket/core/utils/logger.dart';
import 'package:ecomarket/presentation/providers/gemini_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecomarket/l10n/app_localizations.dart';

class EcoBotChat extends StatefulWidget {
  const EcoBotChat({super.key});

  @override
  State<EcoBotChat> createState() => _EcobotChatState();
}

class _EcobotChatState extends State<EcoBotChat> {
  final TextEditingController _promptController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isAnswerSaved = false;

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        0.0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  //todo: UI Update yapılacak
  //todo: modeller eklenecek (Product, User vs...)
  //todo: Actinos kısmına buton eklenecek oradan sohbet seçeceğiz
  @override
  Widget build(BuildContext context) {
    final geminiProvider = context.watch<GeminiProvider>();
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.ecoBot)),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            /// Bu alan kalan tüm yüksekliği alır
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 4, left: 4),
                child: ListView.builder(
                  reverse: true, // En alttan başlatır
                  controller: _scrollController, // Scroll kontrolü için
                  itemCount: geminiProvider.chatHistory.length,
                  itemBuilder: (context, index) {
                    final msg = geminiProvider.chatHistory[index];
                    return Align(
                      alignment: msg.isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: msg.isUser
                          ? Container(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width / 1.8),
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                msg.text,
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : Row(
                              children: [
                                Image.asset(
                                  "assets/icons/ecobot_head_178x178.png",
                                  width: 40,
                                  height: 40,
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width / 1.8),
                                  padding: const EdgeInsets.all(12),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.cyan,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    msg.text,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                    );
                  },
                ),
              ),
            ),

            /// En altta sabit kalan input ve buton satırı
            Padding(
              padding: const EdgeInsets.only(right: 2, left: 2, top: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _promptController,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.ecoBotTalkHint,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                    onPressed: () {
                      geminiProvider.sendMessage(
                          message: _promptController.text,
                          fallBackText: AppLocalizations.of(context)!
                              .sendMessageFallback);
                      setState(() {
                        _isAnswerSaved = true;
                      });
                      _promptController.clear();
                    },
                    icon: Icon(Icons.send, color: AppTheme.primaryGreenLight),
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
