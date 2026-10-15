import 'package:flutter/material.dart';

void main() => runApp(const Task2_4App());

class Task2_4App extends StatelessWidget {
  const Task2_4App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/inbox': (context) => const InboxScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}

/// Reusable drawer with close-before-navigating and pushReplacementNamed pattern
class AppDrawer extends StatelessWidget {
  final String currentRoute;
  const AppDrawer({super.key, required this.currentRoute});

  void _navigateTo(BuildContext context, String routeName) {
    // 1. Close the drawer first
    Navigator.pop(context);

    // If we're already on this screen, don't re-navigate
    if (currentRoute == routeName) return;

    // 2. Use pushReplacementNamed so the stack does not grow when switching sections
    Navigator.pushReplacementNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo, Colors.deepPurple],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.dashboard, color: Colors.white, size: 40),
                SizedBox(height: 8),
                Text(
                  'Section Drawer',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  'pushReplacementNamed demo',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            selected: currentRoute == '/',
            selectedTileColor: Colors.indigo.withOpacity(0.1),
            onTap: () => _navigateTo(context, '/'),
          ),
          ListTile(
            leading: const Icon(Icons.mail),
            title: const Text('Inbox'),
            selected: currentRoute == '/inbox',
            selectedTileColor: Colors.indigo.withOpacity(0.1),
            onTap: () => _navigateTo(context, '/inbox'),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            selected: currentRoute == '/settings',
            selectedTileColor: Colors.indigo.withOpacity(0.1),
            onTap: () => _navigateTo(context, '/settings'),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Section'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const AppDrawer(currentRoute: '/'),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.home, size: 64, color: Colors.indigo),
              SizedBox(height: 16),
              Text('Welcome to Home',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(
                'Open the drawer (icon at top left or swipe) and pick another section.\n\nNotice that pushReplacementNamed prevents the stack from piling up.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox Section'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      drawer: const AppDrawer(currentRoute: '/inbox'),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.mail, size: 64, color: Colors.teal),
              SizedBox(height: 16),
              Text('Inbox Section',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(
                'Because pushReplacementNamed was used, this replaced Home instead of stacking on top.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
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
        title: const Text('Settings Section'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      drawer: const AppDrawer(currentRoute: '/settings'),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.settings, size: 64, color: Colors.deepPurple),
              SizedBox(height: 16),
              Text('Settings Section',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(
                'Switch back to Home or Inbox using the drawer.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
