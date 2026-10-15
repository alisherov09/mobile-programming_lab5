import 'package:flutter/material.dart';

void main() => runApp(const Task3_5App());

class Task3_5App extends StatelessWidget {
  const Task3_5App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CounterDisplayScreen(),
    );
  }
}

class CounterDisplayScreen extends StatefulWidget {
  const CounterDisplayScreen({super.key});

  @override
  State<CounterDisplayScreen> createState() => _CounterDisplayScreenState();
}

class _CounterDisplayScreenState extends State<CounterDisplayScreen> {
  int _counter = 10;
  String _statusMessage = 'Counter ready.';

  Future<void> _editCounter() async {
    // Open editor screen passing current counter via constructor.
    // Await the int result returned by Navigator.pop.
    final int? updatedValue = await Navigator.push<int>(
      context,
      MaterialPageRoute(
        builder: (context) => CounterEditorScreen(initialValue: _counter),
      ),
    );

    // Correctly handle the null result:
    // If user saved, updatedValue is non-null.
    // If user tapped system back arrow or AppBar back, updatedValue is null.
    if (!mounted) return;

    if (updatedValue != null) {
      setState(() {
        _counter = updatedValue;
        _statusMessage = 'Saved new value: $_counter';
      });
    } else {
      setState(() {
        _statusMessage = 'Cancelled: kept previous value ($_counter)';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 3.5: Edit a Counter'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Current Counter Value:',
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
              const SizedBox(height: 12),
              Text(
                '$_counter',
                style: const TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  _statusMessage,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              const SizedBox(height: 28),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                icon: const Icon(Icons.edit),
                label: const Text('Edit Counter', style: TextStyle(fontSize: 16)),
                onPressed: _editCounter,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CounterEditorScreen extends StatefulWidget {
  final int initialValue;

  const CounterEditorScreen({super.key, required this.initialValue});

  @override
  State<CounterEditorScreen> createState() => _CounterEditorScreenState();
}

class _CounterEditorScreenState extends State<CounterEditorScreen> {
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Counter'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Adjust Value',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton.filled(
                    iconSize: 32,
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() => _currentValue--);
                    },
                  ),
                  const SizedBox(width: 32),
                  Text(
                    '$_currentValue',
                    style: const TextStyle(
                      fontSize: 54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 32),
                  IconButton.filled(
                    iconSize: 32,
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() => _currentValue++);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                ),
                icon: const Icon(Icons.save),
                label: const Text('Save and Return', style: TextStyle(fontSize: 16)),
                onPressed: () {
                  // Returns the new modified value
                  Navigator.pop(context, _currentValue);
                },
              ),
              const SizedBox(height: 12),
              TextButton(
                child: const Text('Cancel (or press AppBar back arrow)'),
                onPressed: () {
                  // Pop without returning a value -> caller receives null
                  Navigator.pop(context, null);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
