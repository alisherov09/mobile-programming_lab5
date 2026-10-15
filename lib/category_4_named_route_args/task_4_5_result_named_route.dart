import 'package:flutter/material.dart';

void main() => runApp(const Task4_5App());

class Task4_5App extends StatelessWidget {
  const Task4_5App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/rate': (context) => const RateScreen(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const String movieTitle = 'Inception';
  int? _rating;
  String _ratingFeedback = 'Not rated yet';

  Future<void> _openRating() async {
    // Open /rate with movie title as argument and await int rating result
    final int? result = await Navigator.pushNamed<int>(
      context,
      '/rate',
      arguments: movieTitle,
    );

    // What does Home display if the user returns with the back arrow?
    // Answer: If the user returns with the back arrow, `result` is null.
    // We check if result is null and retain or inform accordingly without crashing!
    if (!mounted) return;

    setState(() {
      if (result != null) {
        _rating = result;
        _ratingFeedback = '$movieTitle: $_rating/5 stars';
      } else {
        // User exited via back arrow without rating
        if (_rating == null) {
          _ratingFeedback = 'Rating cancelled (No stars given)';
        } else {
          _ratingFeedback = '$movieTitle: kept previous rating ($_rating/5)';
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Rating Demo'),
        backgroundColor: Colors.amber.shade800,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.movie, size: 70, color: Colors.amber),
              const SizedBox(height: 16),
              const Text(
                movieTitle,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amber.shade300),
                ),
                child: Text(
                  _ratingFeedback,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.amber.shade900,
                  ),
                ),
              ),
              if (_rating != null) ...[
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < _rating! ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 28,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 28),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber.shade800,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                icon: const Icon(Icons.star_rate),
                label: const Text('Rate Movie', style: TextStyle(fontSize: 16)),
                onPressed: _openRating,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RateScreen extends StatelessWidget {
  const RateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Read movie title passed as argument
    final movie = ModalRoute.of(context)!.settings.arguments as String? ?? 'Movie';

    return Scaffold(
      appBar: AppBar(
        title: Text('Rate $movie'),
        backgroundColor: Colors.amber.shade800,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'How would you rate "$movie"?',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              // Five star buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final starCount = index + 1;
                  return IconButton(
                    iconSize: 42,
                    tooltip: '$starCount Stars',
                    icon: const Icon(Icons.star, color: Colors.amber),
                    onPressed: () {
                      // Return the selected rating value back to Home
                      Navigator.pop(context, starCount);
                    },
                  );
                }),
              ),
              const SizedBox(height: 16),
              const Text(
                'Tap a star (1 to 5) to submit rating.\nOr tap the back arrow to cancel.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
