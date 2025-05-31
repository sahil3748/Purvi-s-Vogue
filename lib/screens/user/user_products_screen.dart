import 'package:flutter/material.dart';
import 'package:purvis_vogue/theme/app_theme.dart';
import 'package:purvis_vogue/services/data_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProductsScreen extends StatelessWidget {
  final String? category;

  const UserProductsScreen({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    final DataService dataService = DataService();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          category ?? 'Our Products',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.richGold,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Container(
        decoration: AppTheme.backgroundGradient,
        child: StreamBuilder<QuerySnapshot>(
          stream: category != null
              ? dataService.getProductsByCategory(category!)
              : dataService.getProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final products = snapshot.data?.docs ?? [];

            if (products.isEmpty) {
              return Center(
                child: Text(
                  category != null
                      ? 'No products available in $category'
                      : 'No products available',
                ),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index].data() as Map<String, dynamic>;
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(product['imageUrl'] ?? ''),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['name'] ?? 'Unnamed Product',
                              style: Theme.of(context).textTheme.titleMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '₹${product['price']?.toString() ?? '0'}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: AppTheme.richGold,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            if (category == null)
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  product['category'] ?? 'Uncategorized',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Colors.grey,
                                      ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
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
