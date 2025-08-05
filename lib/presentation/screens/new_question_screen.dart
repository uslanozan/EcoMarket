import 'package:ecomarket/config/theme/app_theme.dart';
import 'package:ecomarket/core/utils/logger.dart';
import 'package:ecomarket/presentation/widgets/doodle_background.dart';
import 'package:ecomarket/presentation/widgets/question_card.dart';
import 'package:flutter/material.dart';

class NewQuestionPage extends StatefulWidget {
  const NewQuestionPage({
    super.key,
    required this.question,
    required this.hint,
    required this.questionType,
    required this.globMap,
  });

  final String question;
  final String hint;
  final String questionType;
  final Map<String, String> globMap;

  @override
  State<NewQuestionPage> createState() => _NewQuestionPageState();
}

//todo: klavye açıldığında QuestionCard aşağı inecek ya da TextFormField yukarı çıkacak
class _NewQuestionPageState extends State<NewQuestionPage> {

  late final TextEditingController _answerController = TextEditingController();
  bool _isAnswerSaved = false;

  /*
  @override
  void initState() {
    super.initState();
  }
  */

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if(_answerController != null || _answerController != ''){
      logPrint(logTag: "_answerController",logMessage: _answerController.text.trim());
    }

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
                    Align(
                      alignment: Alignment.topCenter,
                      child: QuestionCard(
                        question: widget.question,
                      ),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _answerController,
                              decoration: InputDecoration(
                                hintText: widget.hint,
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          const SizedBox(width: 4), // buton ile alan arasında boşluk
                          IconButton(
                            onPressed: () {
                              logPrint(logTag: "_isAnswerSaved: ",logMessage: '$_isAnswerSaved');
                              logPrint(logTag: "_answerController: ",logMessage: _answerController.text.trim());


                              if (_answerController.text.trim().isNotEmpty) {
                                widget.globMap[widget.questionType] = _answerController.text.trim();
                                logPrint(
                                  logTag: "${widget.globMap}",
                                  logMessage: "Kaydedildi: ${widget.questionType} = ${_answerController.text.trim()}",
                                );
                              } else {
                                // Cevap boşsa "-" olarak kaydet
                                widget.globMap[widget.questionType] = '-';
                                logPrint(
                                  logTag: "${widget.globMap}",
                                  logMessage: "Boş cevap, - ile kaydedildi: ${widget.questionType}",
                                );
                              }

                              logPrint(logTag: "${widget.globMap}", logMessage: '$widget.globMap');

                              setState(() {
                                _isAnswerSaved = true;
                              });
                            },
                            icon: _isAnswerSaved
                                ? Icon(Icons.done,color: AppTheme.primaryGreenLight,)
                                : Icon(Icons.send,color: AppTheme.primaryGreenLight,),
                            //icon: Icon(Icons.send,color: AppTheme.primaryGreenLight,),
                          ),
                        ],
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
