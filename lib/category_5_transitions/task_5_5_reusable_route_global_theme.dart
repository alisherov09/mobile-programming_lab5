import 'package:flutter/material.dart';

void main() => runApp(const Task5_5App());

/// 1. Reusable custom PageRouteBuilder class
class FadeRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeRoute(this.page)
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(opacity: animation, child: child),
        );
}

class Task5_5App extends StatelessWidget {
  const Task5_5App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // 2. Global theme configuration using CupertinoPageTransitionsBuilder across platforms
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.indigo,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
            TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reusable Route & Global Theme'),
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
                'Comparing Route Transitions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Demonstrates both a reusable FadeRoute class and '
                'global ThemeData pageTransitionsTheme (Cupertino transitions on Android/all platforms).',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 28),
              // Option A: Reusable FadeRoute class
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(280, 48),
                ),
                icon: const Icon(Icons.opacity),
                label: const Text('Push with FadeRoute(page)'),
                onPressed: () {
                  // Any push becomes Navigator.push(context, FadeRoute(const DetailsScreen()))
                  Navigator.push(
                    context,
                    FadeRoute(const DetailsScreen(
                      title: 'Opened with FadeRoute',
                      description:
                          'This screen was pushed via the custom reusable FadeRoute class.',
                    )),
                  );
                },
              ),
              const SizedBox(height: 16),
              // Option B: Standard MaterialPageRoute utilizing global CupertinoPageTransitionsBuilder
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(280, 48),
                ),
                icon: const Icon(Icons.phone_iphone),
                label: const Text('Push with Global Cupertino Theme'),
                onPressed: () {
                  // Uses standard MaterialPageRoute which automatically adopts CupertinoPageTransitionsBuilder
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailsScreen(
                        title: 'Opened with Cupertino Transition',
                        description:
                            'This screen used standard MaterialPageRoute, but animated with '
                            'iOS Cupertino slide-and-parallax due to the global ThemeData setting.',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  final String title;
  final String description;

  const DetailsScreen({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.compare_arrows, size: 64, color: Colors.indigo),
              const SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 24),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
