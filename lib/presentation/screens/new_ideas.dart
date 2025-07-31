import 'package:ecomarket/core/utils/logger.dart';
import 'package:ecomarket/l10n/app_localizations.dart';
import 'package:ecomarket/presentation/providers/answer_provider.dart';
import 'package:ecomarket/presentation/providers/gemini_provider.dart';
import 'package:ecomarket/presentation/widgets/ecobot/new_ideas_question.dart';
import 'package:ecomarket/presentation/widgets/ecobot/new_ideas_welcome.dart';
import 'package:ecomarket/presentation/widgets/page_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewIdeas extends StatefulWidget{
  const NewIdeas({super.key});

  @override
  State<NewIdeas> createState() => _NewIdeasState();
}

// SingleTickerProviderStateMixin animasyonlara vsync verebildiğimiz bir provider
class _NewIdeasState extends State<NewIdeas> with SingleTickerProviderStateMixin{


  late PageController _pageController;
  late TabController _tabController;
  int _currentPageIndex = 0;

  //------------------------FUNCTIONS----------------------
  // Mevcut sayfa indexini ve TabController indexini günceller
  void _handlePageChanged(int index) {
    setState(() {
      _currentPageIndex = index;
      _tabController.index = index;
    });
  }

  // PageIndicator ile tıklanırsa TabControlelr indexini günceller ve animasyonlu geçişi yaptırır
  void _updateCurrentPageIndex(int index) {
    setState(() {
      _currentPageIndex = index;
      _tabController.index = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  //------------------------FUNCTIONS END------------------




  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _tabController = TabController(
        length: 6,  //todo: sayfa sayısı artarsa burayı artır
        vsync: this  // vsync animasyon performansını optimize eder
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AnswerProvider(),
      child: Scaffold(
        // resizeToAvoidBottomInset: true,
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.newIdeasTitle)),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children:<Widget> [
            PageView(
              onPageChanged: _handlePageChanged,
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              children: [
                NewQuestionWelcome(),

                NewQuestionPage(question: AppLocalizations.of(context)!.newIdeaQuestion1
                ,hint: AppLocalizations.of(context)!.newIdeaHint1,),

                NewQuestionPage(question: AppLocalizations.of(context)!.newIdeaQuestion2
                  ,hint: AppLocalizations.of(context)!.newIdeaHint2,),

                NewQuestionPage(question: AppLocalizations.of(context)!.newIdeaQuestion3
                  ,hint: AppLocalizations.of(context)!.newIdeaHint3,),

                NewQuestionPage(question: AppLocalizations.of(context)!.newIdeaQuestion4
                  ,hint: AppLocalizations.of(context)!.newIdeaHint4,),

                NewQuestionPage(question: AppLocalizations.of(context)!.newIdeaQuestion5
                  ,hint: AppLocalizations.of(context)!.newIdeaHint5,),

                //todo: buraya bir sayfa daha eklenecek sonuçlar için
              ],
            ),
            PageIndicator(
              tabController: _tabController,
              currentPageIndex: _currentPageIndex,
              onUpdateCurrentPageIndex: _updateCurrentPageIndex,
            ),
          ],
        ),
      ),
    );
  }
}
