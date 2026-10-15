import 'package:flutter/material.dart';

class User {
  final String name;
  final String role;
  final String department;

  const User({
    required this.name,
    required this.role,
    required this.department,
  });
}

void main() => runApp(const Task4_4App());

class Task4_4App extends StatelessWidget {
  const Task4_4App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      // Note: `routes` table is removed; all route generation is handled dynamically in onGenerateRoute
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(
            builder: (c) => const HomeScreen(),
            settings: settings,
          );
        }

        if (settings.name == '/profile') {
          // Check type of settings.arguments safely
          if (settings.arguments is User) {
            final user = settings.arguments as User;
            // Create ProfileScreen using its constructor!
            return MaterialPageRoute(
              builder: (c) => ProfileScreen(user: user),
              settings: settings,
            );
          } else {
            // Handle invalid argument payload
            return MaterialPageRoute(
              builder: (c) => const Scaffold(
                body: Center(
                  child: Text('Error: Invalid arguments passed to /profile'),
                ),
              ),
              settings: settings,
            );
          }
        }

        // Return null for unhandled routes (falls back to onUnknownRoute if defined)
        return null;
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const sampleUser = User(
      name: 'Dr. Gregory House',
      role: 'Head of Diagnostic Medicine',
      department: 'Nephrology & Pathology',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('onGenerateRoute Example'),
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
                'Dynamic Route Dispatcher',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Uses onGenerateRoute instead of static routes table.\n'
                'It extracts arguments from settings, validates the type, '
                'and passes it into ProfileScreen(user: user) via constructor.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                icon: const Icon(Icons.badge),
                label: const Text('Open Profile with onGenerateRoute'),
                onPressed: () {
                  Navigator.pushNamed(context, '/profile', arguments: sampleUser);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  // Receives user via constructor parameter
  final User user;

  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.indigo.shade100,
                      child: const Icon(Icons.person, size: 40, color: Colors.indigo),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      user.name,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),
                  Text('Role: ${user.role}', style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text('Department: ${user.department}', style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 24),
                  Center(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Go Back'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
