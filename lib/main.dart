import 'package:flutter/material.dart';
import 'package:purvis_vogue/theme/app_theme.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:purvis_vogue/services/data_service.dart';
import 'package:purvis_vogue/services/storage_service.dart';
import 'package:purvis_vogue/router/app_router.dart';
import 'package:purvis_vogue/utils/upload_dummy_data.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Purvi's Vogue",
      theme: AppTheme.themeData,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DataService _dataService = DataService();
  final StorageService _storageService = StorageService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.richGold,
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          if (!kIsWeb) // Only show in mobile app
            IconButton(
              icon: const Icon(Icons.dashboard),
              onPressed: () {
                GoRouter.of(context).go('/admin');
              },
            ),
        ],
      ),
      body: Container(
        decoration: AppTheme.backgroundGradient,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Welcome to Purvi\'s Vogue',
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Discover Elegance',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    kIsWeb
                        ? 'Web Version - View Only'
                        : 'Mobile Version - Full Access',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  if (kIsWeb) ...[
                    const SizedBox(height: 40),
                    ElevatedButton.icon(
                      onPressed: () async {
                        try {
                          final uploader = DummyDataUploader();
                          await uploader.uploadDummyData();
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Dummy data uploaded successfully!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error uploading data: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add Dummy Data'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
      // Only show FAB in mobile app
      floatingActionButton: !kIsWeb
          ? FloatingActionButton(
              onPressed: () {
                GoRouter.of(context).go('/admin/products');
              },
              tooltip: 'Add Item',
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
