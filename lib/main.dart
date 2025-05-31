import 'package:flutter/material.dart';
import 'package:purvis_vogue/theme/app_theme.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:purvis_vogue/services/data_service.dart';
import 'package:purvis_vogue/services/storage_service.dart';
import 'package:purvis_vogue/router/app_router.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        title: Text(widget.title),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome to Purvi\'s Vogue',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 20),
              Text(
                'Discover Elegance',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              Text(
                kIsWeb
                    ? 'Web Version - View Only'
                    : 'Mobile Version - Full Access',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
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
