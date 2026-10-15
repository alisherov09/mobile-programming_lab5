import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  // errorBuilder to display 404 / route error page
  errorBuilder: (context, state) => NotFoundScreen(
    errorMessage: state.error?.message ?? 'Route not found',
    attemptedLocation: state.uri.toString(),
  ),
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      name: 'settings',
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      name: 'item',
      path: '/item/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? 'N/A';
        return ItemScreen(itemId: id);
      },
    ),
  ],
);

void main() => runApp(const Task6_4App());

class Task6_4App extends StatelessWidget {
  const Task6_4App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Named Routes & 404 Demo'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Navigate with context.goNamed()',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 280,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  icon: const Icon(Icons.settings),
                  label: const Text('Go to Settings (name: "settings")'),
                  onPressed: () {
                    // Navigate to named route 'settings'
                    context.goNamed('settings');
                  },
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: 280,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  icon: const Icon(Icons.tag),
                  label: const Text('Go to Item 42 (name: "item")'),
                  onPressed: () {
                    // Navigate with context.goNamed('item', pathParameters: {'id': '42'})
                    context.goNamed(
                      'item',
                      pathParameters: {'id': '42'},
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 12),
              SizedBox(
                width: 280,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.redAccent,
                    side: const BorderSide(color: Colors.redAccent),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  icon: const Icon(Icons.broken_image),
                  label: const Text('Trigger 404 Error Screen'),
                  onPressed: () {
                    // Direct navigation to an unregistered route triggers errorBuilder
                    context.go('/non-existent-route-404');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Screen'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.settings, size: 64, color: Colors.indigo),
            const SizedBox(height: 16),
            const Text(
              'Reached via context.goNamed(\'settings\')',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.goNamed('home'),
              child: const Text('Back to Home (goNamed("home"))'),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemScreen extends StatelessWidget {
  final String itemId;
  const ItemScreen({super.key, required this.itemId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item #$itemId'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, size: 64, color: Colors.indigo),
              const SizedBox(height: 16),
              Text(
                'Viewing Item ID: $itemId',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Navigated with context.goNamed(\'item\', pathParameters: {\'id\': \'42\'})',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.goNamed('home'),
                child: const Text('Back to Home (goNamed("home"))'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotFoundScreen extends StatelessWidget {
  final String errorMessage;
  final String attemptedLocation;

  const NotFoundScreen({
    super.key,
    required this.errorMessage,
    required this.attemptedLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('404 - Page Not Found'),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 72, color: Colors.redAccent),
              const SizedBox(height: 16),
              const Text(
                '404 Not Found',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Attempted location: $attemptedLocation',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 6),
              Text(
                'Error: $errorMessage',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.home),
                label: const Text('Return to Home'),
                onPressed: () => context.goNamed('home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
