import 'package:ecomarket/core/globals/globals.dart';
import 'package:ecomarket/l10n/app_localizations.dart';
import 'package:ecomarket/presentation/providers/answer_provider.dart';
import 'package:ecomarket/presentation/screens/choose_improve_product.dart';
import 'package:ecomarket/presentation/screens/improve_product_result.dart';
import 'package:ecomarket/presentation/screens/market_research_result.dart';
import 'package:ecomarket/presentation/screens/new_question_screen.dart';
import 'package:ecomarket/presentation/widgets/page_indicator.dart';
import 'package:ecomarket/presentation/screens/see_result_screen.dart';
import 'package:ecomarket/presentation/widgets/welcome_messages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImproveProduct extends StatefulWidget{
  const ImproveProduct({super.key});

  @override
  State<ImproveProduct> createState() => _ImproveProductState();
}

// SingleTickerProviderStateMixin animasyonlara vsync verebildiğimiz bir provider
class _ImproveProductState extends State<ImproveProduct> with SingleTickerProviderStateMixin{


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
        length: 4,  //Hepsi textformfield'ken 6ydı
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
    //todo: AnswerProvider AŞIRI GEREKSİZ SİLİNECEK
    return ChangeNotifierProvider(
      create: (_) => AnswerProvider(),
      child: Scaffold(
        // resizeToAvoidBottomInset: true,
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.ecoProductTitle)),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children:<Widget> [
            PageView(
              onPageChanged: _handlePageChanged,
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              children: [

                /* Eski full textformfield'lı hali
                 WelcomeMessages(pageType: AppLocalizations.of(context)!.ecoProductWelcomeText),

                  // İsim
                NewQuestionPage(question: AppLocalizations.of(context)!.ecoProductQuestionName
                  ,hint: AppLocalizations.of(context)!.ecoProductHint1,questionType:'name',globMap: global_ecoImproveAnswers,),

                   // Açıklama
                NewQuestionPage(question: AppLocalizations.of(context)!.ecoProductQuestionDescription
                    ,hint: AppLocalizations.of(context)!.ecoProductHint2,questionType:'description',globMap: global_ecoImproveAnswers),

                // Materyal
                NewQuestionPage(question: AppLocalizations.of(context)!.ecoProductQuestionMaterial
                  ,hint: AppLocalizations.of(context)!.ecoProductHint3,questionType:'material',globMap: global_ecoImproveAnswers),

                // Satılan Ülke
                NewQuestionPage(question: AppLocalizations.of(context)!.ecoProductQuestionTarget
                    ,hint: AppLocalizations.of(context)!.ecoProductHint4,questionType:'targetCountry',globMap: global_ecoImproveAnswers),

                    SeeResult(
                    navigateLabel:AppLocalizations.of(context)!.seeTheImprovedProduct,
                    seeResultFunc: (){
                      //todo: global_market temizlenecek ama yeni sayfa instance olduğundan sonra
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ImproveProductResult(),
                        ),
                      );
                    }),

                      */

                WelcomeMessages(pageType: AppLocalizations.of(context)!.ecoProductWelcomeText),


                // Materyal
                NewQuestionPage(question: AppLocalizations.of(context)!.ecoProductQuestionMaterial
                    ,hint: AppLocalizations.of(context)!.ecoProductHint3,questionType:'material',globMap: global_ecoImproveAnswers),

                // Satılan Ülke
                NewQuestionPage(question: AppLocalizations.of(context)!.ecoProductQuestionTarget
                    ,hint: AppLocalizations.of(context)!.ecoProductHint4,questionType:'targetCountry',globMap: global_ecoImproveAnswers),

                ChooseImproveProduct(),


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
