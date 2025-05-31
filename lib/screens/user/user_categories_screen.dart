import 'package:flutter/material.dart';
import 'package:purvis_vogue/theme/app_theme.dart';
import 'package:purvis_vogue/services/data_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

class UserCategoriesScreen extends StatelessWidget {
  const UserCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DataService dataService = DataService();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Categories',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.richGold,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Container(
        decoration: AppTheme.backgroundGradient,
        child: StreamBuilder<QuerySnapshot>(
          stream: dataService.getCategories(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final categories = snapshot.data?.docs ?? [];

            if (categories.isEmpty) {
              return const Center(child: Text('No categories available'));
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category =
                    categories[index].data() as Map<String, dynamic>;
                return InkWell(
                  onTap: () {
                    // Navigate to products filtered by category
                    context
                        .go('/products', extra: {'category': category['name']});
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(category['imageUrl'] ?? ''),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.4),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          category['name'] ?? 'Unnamed Category',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
