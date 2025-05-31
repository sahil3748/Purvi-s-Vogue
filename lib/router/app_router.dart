import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:purvis_vogue/main.dart';
import 'package:purvis_vogue/screens/admin/admin_dashboard.dart';
import 'package:purvis_vogue/screens/admin/categories_screen.dart';
import 'package:purvis_vogue/screens/admin/products_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

// GoRouter configuration
final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const MyHomePage(title: "Purvi's Vogue"),
    ),
    GoRoute(
      path: '/admin',
      name: 'admin',
      builder: (context, state) => const AdminDashboard(),
    ),
    GoRoute(
      path: '/admin/categories',
      name: 'categories',
      builder: (context, state) => const CategoriesScreen(),
    ),
    GoRoute(
      path: '/admin/products',
      name: 'products',
      builder: (context, state) => const ProductsScreen(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Error: ${state.error}'),
    ),
  ),
);
