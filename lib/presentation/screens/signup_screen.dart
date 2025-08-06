import 'package:ecomarket/config/theme/app_theme.dart';
import 'package:ecomarket/l10n/app_localizations.dart';
import 'package:ecomarket/presentation/screens/home_screen.dart'; // HomeScreen'e yönlendirme için
import 'package:ecomarket/presentation/screens/login_screen.dart'; // LoginScreen'e geri yönlendirme için
import 'package:flutter/material.dart';
// Eğer Firebase Auth kullanılıyorsa bu import'u açın:
// import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _signUp() async {
    if (_isLoading) return; // Zaten yükleniyorsa tekrar çalıştırma

    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        // todo: Maile şifre gelecek
        // todo: Buraya Firebase Authentication ile kullanıcı oluşturma veya
        // başka bir backend servisi ile kayıt olma mantığı eklenecek.
        // Örnek:
        // await FirebaseAuth.instance.createUserWithEmailAndPassword(
        //   email: _emailController.text.trim(),
        //   password: _passwordController.text.trim(),
        // );

        // Demo amaçlı basit kontrol
        if (_emailController.text.trim().isNotEmpty &&
            _passwordController.text.trim().length >= 6 &&
            _passwordController.text == _confirmPasswordController.text) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Kayıt başarılı!')),
          );
          // Başarılı kayıt sonrası HomeScreen'e yönlendirme
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Kayıt başarısız. Lütfen bilgileri kontrol edin.')),
          );
        }
      } catch (e) {
        // Hata yönetimi
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Kayıt başarısız: ${e.toString()}')),
        );
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              // Logo ve Başlık (LoginScreen ile aynı yapı)
              Column(
                children: [
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: AppLocalizations.of(context)!.appTitle,
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            color: AppTheme.primaryGreenLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    indent: 50,
                    endIndent: 50,
                    color: Colors.white70, // Divider rengi eklendi
                  ),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: AppLocalizations.of(context)!.ozanUslan,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.white70, // Metin rengi eklendi
                          ),
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
                    'assets/icons/ecomarket_transparent_logo.png', // Kendi logo dosyanızı ekleyin
                    height: 120,
                    width: 120,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.welcome,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryGreenLight,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.createAccount, // Yeni metin
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.primaryGreen,
                ),
              ),
              const SizedBox(height: 40),

              // Kayıt Formu
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
                        hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic, color: Colors.white54),
                        labelText: AppLocalizations.of(context)!.email,
                        labelStyle: const TextStyle(color: Colors.white70),
                        prefixIcon: Icon(Icons.email, color: AppTheme.primaryGreenLight),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppTheme.primaryGreenLight.withOpacity(0.5))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppTheme.primaryGreenLight)),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.2), // Arka plan rengi
                      ),
                      style: const TextStyle(color: Colors.white), // Yazı rengi
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.enterName; // Yeni metin
                        }
                        return null;
                      },
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic, color: Colors.white54),
                        labelText: AppLocalizations.of(context)!.name, // Yeni metin
                        labelStyle: const TextStyle(color: Colors.white70),
                        prefixIcon: Icon(Icons.person, color: AppTheme.primaryGreenLight),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppTheme.primaryGreenLight.withOpacity(0.5))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppTheme.primaryGreenLight)),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.2),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.enterSurname; // Yeni metin
                        }
                        return null;
                      },
                      controller: _surnameController,
                      decoration: InputDecoration(
                        hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic, color: Colors.white54),
                        labelText: AppLocalizations.of(context)!.surname, // Yeni metin
                        labelStyle: const TextStyle(color: Colors.white70),
                        prefixIcon: Icon(Icons.person_outline, color: AppTheme.primaryGreenLight),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppTheme.primaryGreenLight.withOpacity(0.5))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppTheme.primaryGreenLight)),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.2),
                      ),
                      style: const TextStyle(color: Colors.white),
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
                        hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic, color: Colors.white54),
                        labelText: AppLocalizations.of(context)!.password,
                        labelStyle: const TextStyle(color: Colors.white70),
                        prefixIcon: Icon(Icons.lock, color: AppTheme.primaryGreenLight),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppTheme.primaryGreenLight.withOpacity(0.5))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppTheme.primaryGreenLight)),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.2),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.confirmPassword; // Yeni metin
                        }
                        if (value != _passwordController.text) {
                          return AppLocalizations.of(context)!.passwordsNotMatch; // Yeni metin
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic, color: Colors.white54),
                        labelText: AppLocalizations.of(context)!.confirmPassword, // Yeni metin
                        labelStyle: const TextStyle(color: Colors.white70),
                        prefixIcon: Icon(Icons.lock_reset, color: AppTheme.primaryGreenLight),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppTheme.primaryGreenLight.withOpacity(0.5))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppTheme.primaryGreenLight)),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.2),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _signUp, // Kayıt fonksiyonu
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
                          AppLocalizations.of(context)!.signUp, // "Üye Ol"
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Giriş Yapma Bölümü
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.alreadyHaveAccount, // Yeni metin
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white70),
                  ),
                  const SizedBox(width: 5), // Daha az boşluk
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement( // Geri düğmesine basıldığında LoginScreen'e dönmek için
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context)!.loginTitle, // "Giriş Yap"
                      style: TextStyle(color: AppTheme.primaryGreenLight),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
