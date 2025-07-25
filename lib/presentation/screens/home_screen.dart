import 'package:ecomarket/config/theme/app_theme.dart';
import 'package:ecomarket/presentation/screens/ecobot_chat.dart';
import 'package:ecomarket/presentation/widgets/info_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../config/locale/locale_provider.dart';
import '../../config/theme/theme_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final localeProvider = context.read<LocaleProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(local.appTitle),
        actions: [
          IconButton(
            icon: ShaderMask(
              shaderCallback: (bounds) {
                final isTurkish = localeProvider.locale.languageCode == 'tr';
                return isTurkish
                    ? AppTheme.turkishGradient.createShader(bounds)
                    : AppTheme.englishGradient.createShader(bounds);
              },
              child: const Icon(Icons.language, size: 24, color: Colors.white),
            ),
            onPressed: () {
              localeProvider.setLocale(
                localeProvider.locale.languageCode == 'tr'
                    ? const Locale('en')
                    : const Locale('tr'),
              );
            },
          ),

          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              context.read<ThemeModeProvider>().toggleTheme();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Scrollable içerik
          Padding(
            padding: const EdgeInsets.only(bottom: 80), // Alttaki Row için boşluk bırak
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Center(child: Text('${local.homeWelcome} Ozan')),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SizedBox(width: 20),
                        InfoCard(
                          title: AppLocalizations.of(context)!.newIdeasTitle,
                          subtitle: AppLocalizations.of(context)!.newIdeasSubtitle,
                          icon: Icons.lightbulb,
                          onTap: () {
                            // Navigasyon, dialog vs.
                          },
                        ),

                        const SizedBox(width: 20),
                        InfoCard(
                          title: AppLocalizations.of(context)!.ecoProductTitle,
                          subtitle:AppLocalizations.of(context)!.ecoProductSubtitle,
                          icon: Icons.recycling,
                          onTap: () {
                            // Navigasyon, dialog vs.
                          },
                        ),
                        const SizedBox(width: 20),
                        InfoCard(
                          title: AppLocalizations.of(context)!.marketResearchTitle,
                          subtitle: AppLocalizations.of(context)!.marketResearchSubtitle,
                          icon: Icons.sell,
                          onTap: () {
                            // Navigasyon, dialog vs.
                          },
                        ),
                        const SizedBox(width: 20),
                        InfoCard(
                          title: AppLocalizations.of(context)!.userFeedbackTitle,
                          subtitle: AppLocalizations.of(context)!.userFeedbackSubtitle,
                          icon: Icons.star,
                          onTap: () {
                            // Navigasyon, dialog vs.
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),



                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: AppTheme.primaryGradient,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Icon(Icons.auto_awesome, size: 30, color: Colors.white),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.geminiSuggestion,
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Yeni ürünler için geri dönüştürülebilir malzeme listeni güncelle.",
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),


                  Align(
                    alignment: Alignment.bottomCenter,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) => EcobotChat(),
                        );
                      },
                      icon: Icon(Icons.android), //todo: daha sonra ekstra icon eklenebilir
                      label: Text('EcoBot'),
                    ),
                  )



                ],
              ),
            ),
          ),



          Stack(
            children: [
              // Sabit alt kısım
              //NOT! Positioned mutlaka stack içinde olmalı
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 60,
                  //color: AppTheme.primaryGreen,
                  color: AppTheme.primaryGreenLight,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(

                        ),
                        onPressed: () {},
                        child: const Icon(Icons.local_shipping,color: Colors.white,),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Icon(Icons.bar_chart_sharp,color: Colors.white),
                      ),

                      ElevatedButton(
                        onPressed: () {},
                        child: const Icon(Icons.shopping_cart,color: Colors.white),
                      ),

                      ElevatedButton(
                        onPressed: () {},
                        child: const Icon(Icons.person,color: Colors.white),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),


        ],
      ),
    );
  }
}

