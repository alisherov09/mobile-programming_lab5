import 'package:flutter/material.dart';

void main() => runApp(const Task5_3App());

class Task5_3App extends StatelessWidget {
  const Task5_3App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide From Bottom (Sheet)'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Button 1: Normal slide from right (from Task 5.2)
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade700,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(260, 48),
                ),
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Open (Slide Right - 400ms)'),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 400),
                      pageBuilder: (context, anim, secAnim) =>
                          const DetailsScreen(source: 'Slid from Right'),
                      transitionsBuilder: (context, anim, secAnim, child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(1, 0),
                            end: Offset.zero,
                          ).animate(anim),
                          child: child,
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              // Button 2: Required by Task 5.3: "Open as a sheet" (Offset(0, 1), Curves.easeOut, 500ms)
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(260, 48),
                ),
                icon: const Icon(Icons.arrow_upward),
                label: const Text('Open as a sheet'),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 500),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const DetailsScreen(source: 'Slid from Bottom (Sheet)'),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        // Use CurvedAnimation with Curves.easeOut and Offset(0, 1)
                        final curvedAnimation = CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOut,
                        );

                        final offsetAnimation = Tween<Offset>(
                          begin: const Offset(0, 1), // Starts bottom offscreen
                          end: Offset.zero,
                        ).animate(curvedAnimation);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
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
  final String source;
  const DetailsScreen({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(source),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.vertical_align_top, size: 64, color: Colors.teal),
              const SizedBox(height: 16),
              Text(
                source,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Configured with Offset(0, 1), Curves.easeOut, and duration of 500ms.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Close / Dismiss'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
