import 'package:ecomarket/config/theme/app_theme.dart';
import 'package:ecomarket/core/mock/mock_datas.dart';
import 'package:ecomarket/core/models/seller.dart';
import 'package:ecomarket/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //todo: Edit Butonu aktif değil yapılabilir


  @override
  Widget build(BuildContext context) {
    // You would fetch the seller data from a service in a real application
    final Seller seller = mockSellers[0];

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.profileTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.edit,color: AppTheme.primaryGreenLight),
            onPressed: () {
              // Handle settings action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with avatar and basic info
            Container(
              padding: const EdgeInsets.all(24.0),
              width: double.infinity,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    // ImageProvider vermemiz gerekli ama Image.asset bir widget
                    // o yüzden AssetImage kullanıyoruz
                    backgroundImage: AssetImage(seller.avatarUrl),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${seller.name} ${seller.surName}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    seller.location,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Profile details section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.contactInfoTitle,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryGreenLight
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(Icons.email,color: AppTheme.primaryGreen),
                    title: Text(seller.email),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone,color: AppTheme.primaryGreen),
                    title: Text(seller.phone),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    AppLocalizations.of(context)!.sellerInfoTitle,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                        color: AppTheme.primaryGreenLight
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(Icons.shopping_bag,color: AppTheme.primaryGreen),
                    title: Text(
                      '${AppLocalizations.of(context)!.differentProductCountLabel}: ${seller.differentProductCount}',
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.public,color: AppTheme.primaryGreen),
                    title: Text(
                      '${AppLocalizations.of(context)!.targetCountriesLabel}: ${seller.targetCountries.join(', ')}',
                    ),
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
