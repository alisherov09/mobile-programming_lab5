import 'package:flutter/material.dart';

void main() => runApp(const Task3_2App());

class Task3_2App extends StatelessWidget {
  const Task3_2App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GreetingInputScreen(),
    );
  }
}

class GreetingInputScreen extends StatefulWidget {
  const GreetingInputScreen({super.key});

  @override
  State<GreetingInputScreen> createState() => _GreetingInputScreenState();
}

class _GreetingInputScreenState extends State<GreetingInputScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _greet() {
    final name = _nameController.text.trim();
    final displayName = name.isEmpty ? 'Friend' : name;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GreetingDisplayScreen(name: displayName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Greeting Input'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.waving_hand, size: 64, color: Colors.teal),
              const SizedBox(height: 16),
              const Text(
                'Enter your name to be greeted',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Your Name',
                  hintText: 'e.g. Alice',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                onSubmitted: (_) => _greet(),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                ),
                icon: const Icon(Icons.send),
                label: const Text('Greet', style: TextStyle(fontSize: 16)),
                onPressed: _greet,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GreetingDisplayScreen extends StatelessWidget {
  final String name;

  // The name argument is passed directly through the constructor
  const GreetingDisplayScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Greeting'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Hello, $name!',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'The name was passed into GreetingDisplayScreen via constructor argument.',
                style: TextStyle(color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              OutlinedButton.icon(
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back to Input'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
