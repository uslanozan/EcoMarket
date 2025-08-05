import 'package:ecomarket/core/globals/globals.dart';
import 'package:ecomarket/l10n/app_localizations.dart';
import 'package:ecomarket/presentation/providers/answer_provider.dart';
import 'package:ecomarket/presentation/screens/market_research_result.dart';
import 'package:ecomarket/presentation/screens/new_question_screen.dart';
import 'package:ecomarket/presentation/screens/summarize_feedback_result_screen.dart';
import 'package:ecomarket/presentation/widgets/choose_summarize_product.dart';
import 'package:ecomarket/presentation/widgets/page_indicator.dart';
import 'package:ecomarket/presentation/screens/see_result_screen.dart';
import 'package:ecomarket/presentation/widgets/welcome_messages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SummarizeFeedbackScreen extends StatefulWidget{
  const SummarizeFeedbackScreen({super.key});

  @override
  State<SummarizeFeedbackScreen> createState() => _SummarizeFeedbackState();
}

// SingleTickerProviderStateMixin animasyonlara vsync verebildiğimiz bir provider
class _SummarizeFeedbackState extends State<SummarizeFeedbackScreen> with SingleTickerProviderStateMixin{


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
        length: 2,  //todo: sayfa sayısı artarsa burayı artır
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
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.userFeedbackTitle)),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children:<Widget> [
            PageView(
              onPageChanged: _handlePageChanged,
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              children: [
                WelcomeMessages(pageType: AppLocalizations.of(context)!.summarizeFeedbackWelcomeText),

                // Ürün seçme kısmı
                ChooseSummarizeProduct(),

              ],
            ),
            PageIndicator(
              tabController: _tabController,
              currentPageIndex: _currentPageIndex,
              onUpdateCurrentPageIndex: _updateCurrentPageIndex,
              pageCount: _tabController.length-1,
            ),
          ],
        ),
      ),
    );
  }
}
