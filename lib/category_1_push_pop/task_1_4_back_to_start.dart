import 'package:flutter/material.dart';

void main() => runApp(const Task1_4App());

class Task1_4App extends StatelessWidget {
  const Task1_4App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StepScreen(step: 1),
    );
  }
}

class StepScreen extends StatelessWidget {
  final int step;
  const StepScreen({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.blue,
      Colors.orange,
      Colors.teal,
      Colors.purple,
    ];
    final color = colors[(step - 1) % colors.length];

    return Scaffold(
      appBar: AppBar(
        title: Text('Step $step of 4'),
        backgroundColor: color,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: color.withOpacity(0.2),
                child: Text(
                  '$step',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Current Screen: Step $step',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                step < 4
                    ? 'Press Next to push Step ${step + 1} onto the navigation stack.'
                    : 'Press Finish to pop until route.isFirst (returning to Step 1 directly).',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 30),
              if (step < 4)
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  icon: const Icon(Icons.arrow_forward),
                  label: Text('Next (Go to Step ${step + 1})'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StepScreen(step: step + 1),
                      ),
                    );
                  },
                )
              else
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 14),
                  ),
                  icon: const Icon(Icons.done_all),
                  label: const Text(
                    'Finish (Back to Step 1)',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    // Pops all routes on top until the root route is reached
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
