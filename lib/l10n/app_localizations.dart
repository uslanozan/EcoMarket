import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'EcoMarket'**
  String get appTitle;

  /// No description provided for @answeredAllQuestions.
  ///
  /// In en, this message translates to:
  /// **'Congratulations! You answered all the questions.'**
  String get answeredAllQuestions;

  /// No description provided for @copied.
  ///
  /// In en, this message translates to:
  /// **'Copied!'**
  String get copied;

  /// No description provided for @copyError.
  ///
  /// In en, this message translates to:
  /// **'Cannot Copied'**
  String get copyError;

  /// No description provided for @homeWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to EcoMarket'**
  String get homeWelcome;

  /// No description provided for @addProduct.
  ///
  /// In en, this message translates to:
  /// **'Add Product'**
  String get addProduct;

  /// No description provided for @cardInfo.
  ///
  /// In en, this message translates to:
  /// **'Tap the cards to Reveal More'**
  String get cardInfo;

  /// No description provided for @ecoBotSuggestion.
  ///
  /// In en, this message translates to:
  /// **'Suggestion From EcoBot'**
  String get ecoBotSuggestion;

  /// No description provided for @gotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get gotIt;

  /// No description provided for @generateNewProductIdeasFallBack.
  ///
  /// In en, this message translates to:
  /// **'Oops! Something went wrong while generating new ideas.'**
  String get generateNewProductIdeasFallBack;

  /// No description provided for @newIdeasTitle.
  ///
  /// In en, this message translates to:
  /// **'New Ideas'**
  String get newIdeasTitle;

  /// No description provided for @newIdeasSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Set sail for new ideas with EcoBot'**
  String get newIdeasSubtitle;

  /// No description provided for @ecoBotInfoLabel.
  ///
  /// In en, this message translates to:
  /// **'What\'s EcoBot?'**
  String get ecoBotInfoLabel;

  /// No description provided for @ecoBotInfoMessage.
  ///
  /// In en, this message translates to:
  /// **'EcoBot is an intelligent assistant designed to provide you with daily tips and insights related to e-commerce, sustainability, and conscious lifestyle habits. Powered by Google\'s Gemini AI, EcoBot generates fresh, inspiring suggestions tailored to help you live and shop more responsibly.\n\nThis assistant is a core feature of the EcoMarket app, envisioned and developed by Ozan Uslan, with the goal of making sustainability more accessible and actionable in everyday life. EcoBot continuously learns from your preferences and delivers meaningful, eco-friendly recommendations to guide your journey toward a more conscious lifestyle.\n\n👉 EcoBot is always here to help you make better, greener choices—every single day.'**
  String get ecoBotInfoMessage;

  /// No description provided for @ecoProductTitle.
  ///
  /// In en, this message translates to:
  /// **'More Eco-Friendly Products'**
  String get ecoProductTitle;

  /// No description provided for @ecoProductSubtitle.
  ///
  /// In en, this message translates to:
  /// **'EcoBot helps you renew, improve, and make your products more environmentally friendly'**
  String get ecoProductSubtitle;

  /// No description provided for @ecoProductWelcomeText.
  ///
  /// In en, this message translates to:
  /// **'Ready to improve your product with EcoBot?\n\nJust tell me your product’s name, description, materials, and the country you plan to sell in — we’ll take it from there.\n\nOur goal is to make your product more eco-friendly and competitive.\n\nEcoBot will be your development assistant: it will ask a few questions, analyze the details, and give tailored suggestions to enhance your product and reduce its environmental impact.\n\nIf you\'re ready, let\'s begin and take a solid step toward a more sustainable product!'**
  String get ecoProductWelcomeText;

  /// No description provided for @ecoProductQuestionName.
  ///
  /// In en, this message translates to:
  /// **'What is the name of the product?'**
  String get ecoProductQuestionName;

  /// No description provided for @ecoProductQuestionDescription.
  ///
  /// In en, this message translates to:
  /// **'Can you describe the product?'**
  String get ecoProductQuestionDescription;

  /// No description provided for @ecoProductQuestionMaterial.
  ///
  /// In en, this message translates to:
  /// **'What material or materials is the product made of?'**
  String get ecoProductQuestionMaterial;

  /// No description provided for @ecoProductQuestionTarget.
  ///
  /// In en, this message translates to:
  /// **'Which country or countries is the product intended to be sold in?'**
  String get ecoProductQuestionTarget;

  /// No description provided for @ecoProductHint1.
  ///
  /// In en, this message translates to:
  /// **'Your product name, printed t-shirt...'**
  String get ecoProductHint1;

  /// No description provided for @ecoProductHint2.
  ///
  /// In en, this message translates to:
  /// **'Rubber, printed phone case...'**
  String get ecoProductHint2;

  /// No description provided for @ecoProductHint3.
  ///
  /// In en, this message translates to:
  /// **'Plastic, wood, silver...'**
  String get ecoProductHint3;

  /// No description provided for @ecoProductHint4.
  ///
  /// In en, this message translates to:
  /// **'Global, Turkey, Russia...'**
  String get ecoProductHint4;

  /// No description provided for @ecoProductFallBack.
  ///
  /// In en, this message translates to:
  /// **'Oops! Something went wrong while improving the product.'**
  String get ecoProductFallBack;

  /// No description provided for @ecoProductIsDone.
  ///
  /// In en, this message translates to:
  /// **'Eco Improvements are Ready!'**
  String get ecoProductIsDone;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @marketResearchFallBack.
  ///
  /// In en, this message translates to:
  /// **'Oops! Something went wrong while doing market research.'**
  String get marketResearchFallBack;

  /// No description provided for @marketResearchIsDone.
  ///
  /// In en, this message translates to:
  /// **'Market Research is Done!'**
  String get marketResearchIsDone;

  /// No description provided for @marketResearchTitle.
  ///
  /// In en, this message translates to:
  /// **'Market Research'**
  String get marketResearchTitle;

  /// No description provided for @marketResearchSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Let\'s conduct market and price research with EcoBot'**
  String get marketResearchSubtitle;

  /// No description provided for @marketResearchWelcomeText.
  ///
  /// In en, this message translates to:
  /// **'Are you ready to explore the world of e-commerce with EcoBot?\n\nBased on your product idea and target country, we\'ll research whether similar products exist, what their price ranges are, and what trends are shaping the market.\n\nOur goal is to provide you with solid insights and help you understand where your idea stands in the market.\n\nEcoBot will be your research assistant: it will ask you a few questions, gather and analyze data, and present you with a personalized market report.\n\nIf you\'re ready, let\'s begin and take the first confident step toward bringing your idea to life!'**
  String get marketResearchWelcomeText;

  /// No description provided for @marketResearchQuestionIdeaExplanation.
  ///
  /// In en, this message translates to:
  /// **'What product idea would you like to conduct market research on?'**
  String get marketResearchQuestionIdeaExplanation;

  /// No description provided for @marketResearchQuestionTarget.
  ///
  /// In en, this message translates to:
  /// **'Which country or countries would you like to focus your market research on for this product?'**
  String get marketResearchQuestionTarget;

  /// No description provided for @marketResearchHint1.
  ///
  /// In en, this message translates to:
  /// **'Phone Case, Earrings, Sweatshirt...'**
  String get marketResearchHint1;

  /// No description provided for @marketResearchHint2.
  ///
  /// In en, this message translates to:
  /// **'Global, America, Philippines...'**
  String get marketResearchHint2;

  /// No description provided for @newIdeaQuestionCategory.
  ///
  /// In en, this message translates to:
  /// **'What will be the product category or categories?'**
  String get newIdeaQuestionCategory;

  /// No description provided for @newIdeaQuestionMaterial.
  ///
  /// In en, this message translates to:
  /// **'What will be the product material or materials?'**
  String get newIdeaQuestionMaterial;

  /// No description provided for @newIdeaQuestionCountry.
  ///
  /// In en, this message translates to:
  /// **'What will be the target country or countries for the product?'**
  String get newIdeaQuestionCountry;

  /// No description provided for @newIdeaQuestionBudget.
  ///
  /// In en, this message translates to:
  /// **'What will be the product\'s budget?'**
  String get newIdeaQuestionBudget;

  /// No description provided for @newIdeaQuestionIsEco.
  ///
  /// In en, this message translates to:
  /// **'Will the product be eco-friendly? If so, to what extent?'**
  String get newIdeaQuestionIsEco;

  /// No description provided for @newIdeaHint1.
  ///
  /// In en, this message translates to:
  /// **'Clothing, accessories, electronics...'**
  String get newIdeaHint1;

  /// No description provided for @newIdeaHint2.
  ///
  /// In en, this message translates to:
  /// **'Cotton, recycled plastic, glass...'**
  String get newIdeaHint2;

  /// No description provided for @newIdeaHint3.
  ///
  /// In en, this message translates to:
  /// **'Global, Turkey, Italy...'**
  String get newIdeaHint3;

  /// No description provided for @newIdeaHint4.
  ///
  /// In en, this message translates to:
  /// **'High budget, 40,000 \$, medium budget...'**
  String get newIdeaHint4;

  /// No description provided for @newIdeaHint5.
  ///
  /// In en, this message translates to:
  /// **'No, slightly, maybe...'**
  String get newIdeaHint5;

  /// No description provided for @newIdeasWelcomeText.
  ///
  /// In en, this message translates to:
  /// **'How about designing the next generation of e-commerce products together with EcoBot?\n\nWith your ideas, you can help make the world a more sustainable place.\n\nOur goal is to develop eco-friendly, innovative, and inspiring e-commerce product ideas.\n\nEcoBot will be your guide: it will ask questions and help you shape your vision.\n\nIf you\'re ready, start answering and let\'s build the future together!'**
  String get newIdeasWelcomeText;

  /// No description provided for @noResponse.
  ///
  /// In en, this message translates to:
  /// **'No response'**
  String get noResponse;

  /// No description provided for @noSuggestion.
  ///
  /// In en, this message translates to:
  /// **'No suggestion available'**
  String get noSuggestion;

  /// No description provided for @restart.
  ///
  /// In en, this message translates to:
  /// **'Restart'**
  String get restart;

  /// No description provided for @seeTheNewIdeas.
  ///
  /// In en, this message translates to:
  /// **'See the New Ideas'**
  String get seeTheNewIdeas;

  /// No description provided for @seeTheMarketResearch.
  ///
  /// In en, this message translates to:
  /// **'See the Market Resarch Results'**
  String get seeTheMarketResearch;

  /// No description provided for @seeTheImprovedProduct.
  ///
  /// In en, this message translates to:
  /// **'See the improved product'**
  String get seeTheImprovedProduct;

  /// No description provided for @talkToEcoBot.
  ///
  /// In en, this message translates to:
  /// **'Tap to Talk with EcoBot'**
  String get talkToEcoBot;

  /// No description provided for @userFeedbackTitle.
  ///
  /// In en, this message translates to:
  /// **'User Feedback'**
  String get userFeedbackTitle;

  /// No description provided for @userFeedbackSubtitle.
  ///
  /// In en, this message translates to:
  /// **'EcoBot analyzes user comments and requests for you'**
  String get userFeedbackSubtitle;

  /// No description provided for @newIdeaIsDone.
  ///
  /// In en, this message translates to:
  /// **'Your ideas are ready!'**
  String get newIdeaIsDone;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'tr': return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
