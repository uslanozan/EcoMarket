import 'package:ecomarket/config/theme/app_theme.dart';
import 'package:ecomarket/core/globals/globals.dart';
import 'package:ecomarket/core/utils/logger.dart';
import 'package:ecomarket/presentation/providers/gemini_provider.dart';
import 'package:ecomarket/presentation/providers/locale_provider.dart';
import 'package:ecomarket/presentation/screens/home_screen.dart';
import 'package:ecomarket/presentation/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecomarket/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
//import 'package:firebase_auth/firebase_auth.dart';

// Şifremi unuttum kısmı için
enum ForgotPasswordStep { enterEmail, enterCode }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();


}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false; // Email/Password login için


  /* //todo: Google ve normal login implemente edilecek
  // Varsayılan email/şifre ile giriş fonksiyonu
  Future<void> _loginDefault() async {
    if (_isLoading) return; // Zaten yükleniyorsa tekrar çalıştırma

    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        // Başarılı giriş sonrası yönlendirme
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Giriş başarılı!')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Giriş başarısız')),
        );
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }
   */

  Future<void> _loginDemo() async {
    if (_isLoading) return; // Zaten yükleniyorsa tekrar çalıştırma

    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {

          String email = _emailController.text.trim();
          String password = _passwordController.text.trim();

        // Başarılı giriş sonrası yönlendirme
        if (email == "uslanozan@gmail.com" && password == "123123") {

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      } catch (e) {
        logPrint(logTag: "_loginDemo",logMessage: "Login Unsuccessful");
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  void _forgotPassword(BuildContext context) {


    // Dialog'un içindeki durumu yönetmek için TextEditingController'lar
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _codeController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        // StatefulBuilder, AlertDialog'un içeriğinin kendi iç durumunu yönetmesini sağlar.
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            // Varsayılan adım e-posta girişi
            ForgotPasswordStep currentStep = ForgotPasswordStep.enterEmail;

            // Eğer _emailController'da bir değer varsa ve doğrulama kodu ekranına geçildiyse
            // bu state'i korumak için basit bir mekanizma.
            // Gerçek uygulamada bu durum yönetimi daha karmaşık olabilir (örn: Provider, BLoC).
            if (_emailController.text.isNotEmpty &&
                ModalRoute.of(context)?.settings.arguments == 'showCode') {
              currentStep = ForgotPasswordStep.enterCode;
            }

            return AlertDialog(
              title: Text(
                currentStep == ForgotPasswordStep.enterEmail
                    ? AppLocalizations.of(context)!.forgotPasswordTitle
                    : AppLocalizations.of(context)!.verifyCodeTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppTheme.primaryGreenLight,
                ),
              ),
              content: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (currentStep == ForgotPasswordStep.enterEmail) ...[
                        Text(
                          AppLocalizations.of(context)!.enterEmailForReset,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.email,
                            prefixIcon: Icon(Icons.email, color: AppTheme.primaryGreenLight),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: AppTheme.primaryGreenLight.withOpacity(0.5)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: AppTheme.primaryGreenLight),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!.enterEmail;
                            }
                            if (!value.contains('@')) {
                              return AppLocalizations.of(context)!.enterValidEmail;
                            }
                            return null;
                          },
                        ),
                      ] else ...[
                        Text(
                          '${AppLocalizations.of(context)!.codeSentToEmail} ${_emailController.text}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _codeController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.verificationCode,
                            prefixIcon: Icon(Icons.vpn_key, color: AppTheme.primaryGreenLight),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: AppTheme.primaryGreenLight.withOpacity(0.5)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: AppTheme.primaryGreenLight),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!.enterCode;
                            }
                            // Sadece UI olduğu için basit bir doğrulama
                            if (value != '123456') { // Örnek bir kod
                              return AppLocalizations.of(context)!.invalidCode;
                            }
                            return null;
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Diyaloğu kapat
                  },
                  child: Text(AppLocalizations.of(context)!.cancelButton),
                ),
                if (currentStep == ForgotPasswordStep.enterEmail)
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // TODO: Burada mail gönderme işlemi başlatılacak (şimdilik UI)
                        setState(() {
                          currentStep = ForgotPasswordStep.enterCode;
                          // Doğrulama kodu ekranına geçiş için bir işaret
                          Navigator.of(context).popAndPushNamed(
                            '/forgotPassword', // Herhangi bir named route olabilir, önemli olan dialogu kapatıp yeni bir tane açmak
                            arguments: 'showCode',
                          );
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryGreenLight,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(AppLocalizations.of(context)!.sendCodeButton),
                  )
                else
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // TODO: Doğrulama kodu kontrolü ve şifre sıfırlama işlemi başlatılacak
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(AppLocalizations.of(context)!.passwordResetSuccess)),
                        );
                        Navigator.of(context).pop(); // Diyaloğu kapat
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryGreenLight,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(AppLocalizations.of(context)!.verifyButton),
                  ),
              ],
            );
          },
        );
      },
    ).then((_) {
      // Diyalog kapandığında controller'ları temizle
      _emailController.dispose();
      _codeController.dispose();
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final localeProvider = context.read<LocaleProvider>();
    final geminiProvider = context.watch<GeminiProvider>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              Column(
                children: [
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: AppLocalizations.of(context)!.appTitle,
                          style: TextTheme.of(context).headlineLarge?.copyWith(
                            color: AppTheme.primaryGreenLight
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    indent: 50,
                    endIndent: 50,
                    color: Colors.grey,
                  ),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: AppLocalizations.of(context)!.ozanUslan,
                          style: TextTheme.of(context).labelSmall?.copyWith(

                          )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/ecomarket_transparent_logo.png',
                    height: 120,
                    width: 120,
                  ),
                ],
              ),
              const SizedBox(height: 20),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.welcome,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryGreenLight,
                    ),
                  ),
                  IconButton(
                    icon: ShaderMask(
                      shaderCallback: (bounds) {
                        final isTurkish = localeProvider.locale.languageCode == 'tr';
                        return isTurkish
                            ? AppTheme.turkishGradient.createShader(bounds)
                            : AppTheme.englishGradient.createShader(bounds);
                      },
                      child: const Icon(Icons.language, size: 30, color: Colors.white),
                    ),
                    onPressed: () async {
                      localeProvider.setLocale(
                        localeProvider.locale.languageCode == 'tr'
                            ? const Locale('en')
                            : const Locale('tr'),
                      );

                      if (geminiProvider.dailySuggestion.isEmpty ?? true) {
                        await geminiProvider.getDailySuggestion(
                            answerLanguage: global_language,
                            fallBackText: AppLocalizations.of(context)!.noSuggestion);
                      } else {
                        await geminiProvider.translateSuggestion(
                            newLanguage: global_language,
                            fallBackText: AppLocalizations.of(context)!.noSuggestion);
                      }
                    },
                  ),
                ],
              ),

              const SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.loginWithAccount,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.primaryGreen
                ),
              ),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.enterEmail;
                        }
                        if (!value.contains('@')) {
                          return AppLocalizations.of(context)!.enterValidEmail;
                        }
                        return null;
                      },
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontStyle: FontStyle.italic),
                        labelText:  AppLocalizations.of(context)!.email,
                        prefixIcon: Icon(Icons.email, color: AppTheme.primaryGreenLight),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppTheme.primaryGreenLight.withOpacity(0.5)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppTheme.primaryGreenLight),
                        ),
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.enterPassword;
                        }
                        if (value.length < 6) {
                          return AppLocalizations.of(context)!.enterValidPassword;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontStyle: FontStyle.italic),
                        labelText: AppLocalizations.of(context)!.password,
                        prefixIcon: Icon(Icons.lock, color: AppTheme.primaryGreenLight),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppTheme.primaryGreenLight.withOpacity(0.5)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppTheme.primaryGreenLight),
                        ),
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          _forgotPassword(context);
                          print('Şifremi unuttum tıklandı');
                        },
                        child: Text(
                          AppLocalizations.of(context)!.forgotPassword,
                          style: TextStyle(color: AppTheme.primaryGreenLight),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _loginDemo,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryGreenLight,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text(
                          AppLocalizations.of(context)!.loginTitle,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.noAccount,
                      style: TextTheme.of(context).bodySmall,

                    ),
                    SizedBox(width: 20,),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          //todo: üye olma sayfası implemente edilecek
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignUpScreen()),
                          );
                        },
                        child: Text(
                          AppLocalizations.of(context)!.signUp,
                          style: TextStyle(color: AppTheme.primaryGreenLight),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
