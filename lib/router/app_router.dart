import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:purvis_vogue/main.dart';
import 'package:purvis_vogue/screens/admin/admin_dashboard.dart';
import 'package:purvis_vogue/screens/admin/categories_screen.dart';
import 'package:purvis_vogue/screens/admin/products_screen.dart';
import 'package:purvis_vogue/screens/user/user_home.dart';
import 'package:purvis_vogue/screens/user/user_products_screen.dart';
import 'package:purvis_vogue/screens/user/user_categories_screen.dart';
import 'package:purvis_vogue/screens/error_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

// Redirect middleware based on platform
String? _guardRoute(BuildContext context, GoRouterState state) {
  final path = state.matchedLocation;

  // Web users can only access user routes
  if (kIsWeb && path.startsWith('/admin')) {
    return '/';
  }

  // Mobile users can only access admin routes
  if (!kIsWeb && !path.startsWith('/admin')) {
    return '/admin';
  }

  return null; // No redirect needed
}

// GoRouter configuration
final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: kIsWeb ? '/' : '/admin',
  debugLogDiagnostics: true,
  redirect: _guardRoute,
  routes: [
    // User routes (Web only)
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const UserHome(title: "Purvi's Vogue"),
    ),
    GoRoute(
      path: '/products',
      name: 'user_products',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final category = extra?['category'] as String?;
        return UserProductsScreen(category: category);
      },
    ),
    GoRoute(
      path: '/categories',
      name: 'user_categories',
      builder: (context, state) => const UserCategoriesScreen(),
    ),

    // Admin routes (Mobile only)
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
  errorBuilder: (context, state) => ErrorScreen(error: state.error.toString()),
);
