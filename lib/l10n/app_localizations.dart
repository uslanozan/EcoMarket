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

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @answeredAllQuestions.
  ///
  /// In en, this message translates to:
  /// **'Congratulations! You answered all the questions.'**
  String get answeredAllQuestions;

  /// No description provided for @apiResponseNotJson.
  ///
  /// In en, this message translates to:
  /// **'API response is not in a valid JSON format.'**
  String get apiResponseNotJson;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'EcoMarket'**
  String get appTitle;

  /// No description provided for @averageRating.
  ///
  /// In en, this message translates to:
  /// **'Average Rating'**
  String get averageRating;

  /// No description provided for @brandsSellers.
  ///
  /// In en, this message translates to:
  /// **'Brands/Sellers'**
  String get brandsSellers;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @cancelledStatus.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelledStatus;

  /// No description provided for @cardInfo.
  ///
  /// In en, this message translates to:
  /// **'Tap the cards to Reveal More'**
  String get cardInfo;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @codeSentToEmail.
  ///
  /// In en, this message translates to:
  /// **'A verification code has been sent to:'**
  String get codeSentToEmail;

  /// No description provided for @competitiveLandscape.
  ///
  /// In en, this message translates to:
  /// **'Competitive Landscape'**
  String get competitiveLandscape;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get confirmPassword;

  /// No description provided for @contactInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact Info'**
  String get contactInfoTitle;

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

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get createAccount;

  /// No description provided for @customerLabel.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get customerLabel;

  /// No description provided for @dateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get dateLabel;

  /// No description provided for @deliveredStatus.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get deliveredStatus;

  /// No description provided for @differentProductCountLabel.
  ///
  /// In en, this message translates to:
  /// **'Number of Product Types'**
  String get differentProductCountLabel;

  /// No description provided for @ecoBot.
  ///
  /// In en, this message translates to:
  /// **'EcoBot'**
  String get ecoBot;

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

  /// No description provided for @ecoBotSuggestion.
  ///
  /// In en, this message translates to:
  /// **'Suggestion From EcoBot'**
  String get ecoBotSuggestion;

  /// No description provided for @ecoBotTalkHint.
  ///
  /// In en, this message translates to:
  /// **'Write to talk'**
  String get ecoBotTalkHint;

  /// No description provided for @ecoProductFallBack.
  ///
  /// In en, this message translates to:
  /// **'Oops! Something went wrong while improving the product.'**
  String get ecoProductFallBack;

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

  /// No description provided for @ecoProductIsDone.
  ///
  /// In en, this message translates to:
  /// **'Eco Improvements are Ready!'**
  String get ecoProductIsDone;

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

  /// No description provided for @ecoProductQuestionName.
  ///
  /// In en, this message translates to:
  /// **'What is the name of the product?'**
  String get ecoProductQuestionName;

  /// No description provided for @ecoProductQuestionTarget.
  ///
  /// In en, this message translates to:
  /// **'Which country or countries is the product intended to be sold in?'**
  String get ecoProductQuestionTarget;

  /// No description provided for @ecoProductSubtitle.
  ///
  /// In en, this message translates to:
  /// **'EcoBot helps you renew, improve, and make your products more environmentally friendly'**
  String get ecoProductSubtitle;

  /// No description provided for @ecoProductTitle.
  ///
  /// In en, this message translates to:
  /// **'More Eco-Friendly Products'**
  String get ecoProductTitle;

  /// No description provided for @ecoProductWelcomeText.
  ///
  /// In en, this message translates to:
  /// **'Ready to improve your product with EcoBot?\n\nJust tell me your product’s name, description, materials, and the country you plan to sell in — we’ll take it from there.\n\nOur goal is to make your product more eco-friendly and competitive.\n\nEcoBot will be your development assistant: it will ask a few questions, analyze the details, and give tailored suggestions to enhance your product and reduce its environmental impact.\n\nIf you\'re ready, let\'s begin and take a solid step toward a more sustainable product!'**
  String get ecoProductWelcomeText;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'E-mail Address'**
  String get email;

  /// No description provided for @enterCode.
  ///
  /// In en, this message translates to:
  /// **'Please enter the verification code'**
  String get enterCode;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Email'**
  String get enterEmail;

  /// No description provided for @enterEmailForReset.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email address to receive a verification code.'**
  String get enterEmailForReset;

  /// No description provided for @enterName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get enterName;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Password'**
  String get enterPassword;

  /// No description provided for @enterSurname.
  ///
  /// In en, this message translates to:
  /// **'Please enter your surname'**
  String get enterSurname;

  /// No description provided for @enterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a Valid Email'**
  String get enterValidEmail;

  /// No description provided for @enterValidPassword.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get enterValidPassword;

  /// No description provided for @existingProductsAndPrices.
  ///
  /// In en, this message translates to:
  /// **'Existing Products and Prices'**
  String get existingProductsAndPrices;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPassword;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPasswordTitle;

  /// No description provided for @generateNewProductIdeasFallBack.
  ///
  /// In en, this message translates to:
  /// **'Oops! Something went wrong while generating new ideas.'**
  String get generateNewProductIdeasFallBack;

  /// No description provided for @gotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get gotIt;

  /// No description provided for @graphTitle.
  ///
  /// In en, this message translates to:
  /// **'Graphs'**
  String get graphTitle;

  /// No description provided for @homeWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to EcoMarket'**
  String get homeWelcome;

  /// No description provided for @improvementSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Improvement Suggestions'**
  String get improvementSuggestions;

  /// No description provided for @invalidCode.
  ///
  /// In en, this message translates to:
  /// **'Invalid verification code'**
  String get invalidCode;

  /// No description provided for @jsonParsingFailed.
  ///
  /// In en, this message translates to:
  /// **'JSON parsing failed'**
  String get jsonParsingFailed;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginTitle;

  /// No description provided for @loginWithAccount.
  ///
  /// In en, this message translates to:
  /// **'Login to Your Account'**
  String get loginWithAccount;

  /// No description provided for @marketDemand.
  ///
  /// In en, this message translates to:
  /// **'Market Demand'**
  String get marketDemand;

  /// No description provided for @marketResearchFallBack.
  ///
  /// In en, this message translates to:
  /// **'Oops! Something went wrong while doing market research.'**
  String get marketResearchFallBack;

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

  /// No description provided for @marketResearchIsDone.
  ///
  /// In en, this message translates to:
  /// **'Market Research is Done!'**
  String get marketResearchIsDone;

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

  /// No description provided for @marketResearchSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Let\'s conduct market and price research with EcoBot'**
  String get marketResearchSubtitle;

  /// No description provided for @marketResearchTitle.
  ///
  /// In en, this message translates to:
  /// **'Market Research'**
  String get marketResearchTitle;

  /// No description provided for @marketResearchWelcomeText.
  ///
  /// In en, this message translates to:
  /// **'Are you ready to explore the world of e-commerce with EcoBot?\n\nBased on your product idea and target country, we\'ll research whether similar products exist, what their price ranges are, and what trends are shaping the market.\n\nOur goal is to provide you with solid insights and help you understand where your idea stands in the market.\n\nEcoBot will be your research assistant: it will ask you a few questions, gather and analyze data, and present you with a personalized market report.\n\nIf you\'re ready, let\'s begin and take the first confident step toward bringing your idea to life!'**
  String get marketResearchWelcomeText;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

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

  /// No description provided for @newIdeaIsDone.
  ///
  /// In en, this message translates to:
  /// **'Your ideas are ready!'**
  String get newIdeaIsDone;

  /// No description provided for @newIdeasSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Set sail for new ideas with EcoBot'**
  String get newIdeasSubtitle;

  /// No description provided for @newIdeasTitle.
  ///
  /// In en, this message translates to:
  /// **'New Ideas'**
  String get newIdeasTitle;

  /// No description provided for @newIdeasWelcomeText.
  ///
  /// In en, this message translates to:
  /// **'How about designing the next generation of e-commerce products together with EcoBot?\n\nWith your ideas, you can help make the world a more sustainable place.\n\nOur goal is to develop eco-friendly, innovative, and inspiring e-commerce product ideas.\n\nEcoBot will be your guide: it will ask questions and help you shape your vision.\n\nIf you\'re ready, start answering and let\'s build the future together!'**
  String get newIdeasWelcomeText;

  /// No description provided for @newIdeaQuestionBudget.
  ///
  /// In en, this message translates to:
  /// **'What will be the product\'s budget?'**
  String get newIdeaQuestionBudget;

  /// No description provided for @newIdeaQuestionCategory.
  ///
  /// In en, this message translates to:
  /// **'What will be the product category or categories?'**
  String get newIdeaQuestionCategory;

  /// No description provided for @newIdeaQuestionCountry.
  ///
  /// In en, this message translates to:
  /// **'What will be the target country or countries for the product?'**
  String get newIdeaQuestionCountry;

  /// No description provided for @newIdeaQuestionIsEco.
  ///
  /// In en, this message translates to:
  /// **'Will the product be eco-friendly? If so, to what extent?'**
  String get newIdeaQuestionIsEco;

  /// No description provided for @newIdeaQuestionMaterial.
  ///
  /// In en, this message translates to:
  /// **'What will be the product material or materials?'**
  String get newIdeaQuestionMaterial;

  /// No description provided for @newPrice.
  ///
  /// In en, this message translates to:
  /// **'Enter the New Price'**
  String get newPrice;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t Have an Account?'**
  String get noAccount;

  /// No description provided for @noAddress.
  ///
  /// In en, this message translates to:
  /// **'No Address'**
  String get noAddress;

  /// No description provided for @noSave.
  ///
  /// In en, this message translates to:
  /// **'Don\'t Save'**
  String get noSave;

  /// No description provided for @noSpecificProductInfo.
  ///
  /// In en, this message translates to:
  /// **'No specific product information found.'**
  String get noSpecificProductInfo;

  /// No description provided for @noSuggestion.
  ///
  /// In en, this message translates to:
  /// **'No suggestion available'**
  String get noSuggestion;

  /// No description provided for @noWeaknessesFound.
  ///
  /// In en, this message translates to:
  /// **'No Weakness'**
  String get noWeaknessesFound;

  /// No description provided for @ozanUslan.
  ///
  /// In en, this message translates to:
  /// **'Powered by Ozan Uslan'**
  String get ozanUslan;

  /// No description provided for @overallSentiment.
  ///
  /// In en, this message translates to:
  /// **'Overall Sentiment'**
  String get overallSentiment;

  /// No description provided for @passwordsNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsNotMatch;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password reset link sent successfully!'**
  String get passwordResetSuccess;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @priceRange.
  ///
  /// In en, this message translates to:
  /// **'Price Range'**
  String get priceRange;

  /// No description provided for @priceRanges.
  ///
  /// In en, this message translates to:
  /// **'Price Ranges'**
  String get priceRanges;

  /// No description provided for @problematicPart.
  ///
  /// In en, this message translates to:
  /// **'Problematic part'**
  String get problematicPart;

  /// No description provided for @addProduct.
  ///
  /// In en, this message translates to:
  /// **'Add Product'**
  String get addProduct;

  /// No description provided for @products.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products;

  /// No description provided for @processesLabel.
  ///
  /// In en, this message translates to:
  /// **'Products Process Status'**
  String get processesLabel;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile Page'**
  String get profileTitle;

  /// No description provided for @quantityLabel.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantityLabel;

  /// No description provided for @ratingSummary.
  ///
  /// In en, this message translates to:
  /// **'Rating Summary'**
  String get ratingSummary;

  /// No description provided for @restart.
  ///
  /// In en, this message translates to:
  /// **'Restart'**
  String get restart;

  /// No description provided for @risksAndLimitations.
  ///
  /// In en, this message translates to:
  /// **'Risks and Limitations'**
  String get risksAndLimitations;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @seeTheImprovedProduct.
  ///
  /// In en, this message translates to:
  /// **'See the improved product'**
  String get seeTheImprovedProduct;

  /// No description provided for @seeTheMarketResearch.
  ///
  /// In en, this message translates to:
  /// **'See the Market Resarch Results'**
  String get seeTheMarketResearch;

  /// No description provided for @seeTheNewIdeas.
  ///
  /// In en, this message translates to:
  /// **'See the New Ideas'**
  String get seeTheNewIdeas;

  /// No description provided for @sellerInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Sales Info'**
  String get sellerInfoTitle;

  /// No description provided for @sendCodeButton.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get sendCodeButton;

  /// No description provided for @sendMessageFallback.
  ///
  /// In en, this message translates to:
  /// **'Oops! Something went wrong while generating message.'**
  String get sendMessageFallback;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @signInCancelled.
  ///
  /// In en, this message translates to:
  /// **'Login is Cancelled'**
  String get signInCancelled;

  /// No description provided for @signInFailed.
  ///
  /// In en, this message translates to:
  /// **'Login Failure'**
  String get signInFailed;

  /// No description provided for @signInSuccess.
  ///
  /// In en, this message translates to:
  /// **'Login is Successful'**
  String get signInSuccess;

  /// No description provided for @signInWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Login with Google'**
  String get signInWithGoogle;

  /// No description provided for @similarProductsAndMarketplaces.
  ///
  /// In en, this message translates to:
  /// **'Similar Products & Marketplaces'**
  String get similarProductsAndMarketplaces;

  /// No description provided for @similarProductsAvailable.
  ///
  /// In en, this message translates to:
  /// **'Similar Products Available'**
  String get similarProductsAvailable;

  /// No description provided for @soldProductGraph.
  ///
  /// In en, this message translates to:
  /// **'Sold Products Pie Graph'**
  String get soldProductGraph;

  /// No description provided for @starRatingBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Star Rating Breakdown'**
  String get starRatingBreakdown;

  /// No description provided for @strengths.
  ///
  /// In en, this message translates to:
  /// **'Strengths'**
  String get strengths;

  /// No description provided for @summarizeCommentsButton.
  ///
  /// In en, this message translates to:
  /// **'See the Analysis'**
  String get summarizeCommentsButton;

  /// No description provided for @summarizeFeedbackFallBack.
  ///
  /// In en, this message translates to:
  /// **'Oops! Something went wrong while analyzing customer comments.'**
  String get summarizeFeedbackFallBack;

  /// No description provided for @summarizeFeedbackIsDone.
  ///
  /// In en, this message translates to:
  /// **'Product Comments Analysis is Done!'**
  String get summarizeFeedbackIsDone;

  /// No description provided for @summarizeFeedbackWelcomeText.
  ///
  /// In en, this message translates to:
  /// **'EcoBot will now analyze customer feedback (comments and scores) about the product you selected.\n\nIt will summarize the comments to highlight the product’s strengths and weaknesses, and provide suggestions for improvement based on real user experiences.\n\nOur goal is to enhance the user experience and make the product more sustainable by minimizing its environmental impact.\n\nIf you\'re ready, let\'s take your product to the next level with the help of user feedback!'**
  String get summarizeFeedbackWelcomeText;

  /// No description provided for @surname.
  ///
  /// In en, this message translates to:
  /// **'Surname'**
  String get surname;

  /// No description provided for @talkToEcoBot.
  ///
  /// In en, this message translates to:
  /// **'Tap to Talk with EcoBot'**
  String get talkToEcoBot;

  /// No description provided for @targetCountriesLabel.
  ///
  /// In en, this message translates to:
  /// **'Available Countries'**
  String get targetCountriesLabel;

  /// No description provided for @targetCustomerSegments.
  ///
  /// In en, this message translates to:
  /// **'Target Customer Segments'**
  String get targetCustomerSegments;

  /// No description provided for @top5customers.
  ///
  /// In en, this message translates to:
  /// **'Top 5 Customers Who Purchased the Most'**
  String get top5customers;

  /// No description provided for @trendsAndGrowthPattern.
  ///
  /// In en, this message translates to:
  /// **'Trends and Growth Pattern'**
  String get trendsAndGrowthPattern;

  /// No description provided for @userFeedbackSubtitle.
  ///
  /// In en, this message translates to:
  /// **'EcoBot analyzes the comments and ratings of your selected product'**
  String get userFeedbackSubtitle;

  /// No description provided for @userFeedbackTitle.
  ///
  /// In en, this message translates to:
  /// **'Analysis of Customer Comments'**
  String get userFeedbackTitle;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @verificationCode.
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get verificationCode;

  /// No description provided for @verifyButton.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verifyButton;

  /// No description provided for @verifyCodeTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify Code'**
  String get verifyCodeTitle;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @weaknesses.
  ///
  /// In en, this message translates to:
  /// **'Weaknesses'**
  String get weaknesses;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @productStatusBar.
  ///
  /// In en, this message translates to:
  /// **'Delivered/Cancelled Ratio of Products'**
  String get productStatusBar;

  /// No description provided for @notAvailable.
  ///
  /// In en, this message translates to:
  /// **'Not Available'**
  String get notAvailable;

  /// No description provided for @noResponse.
  ///
  /// In en, this message translates to:
  /// **'No Response'**
  String get noResponse;
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
