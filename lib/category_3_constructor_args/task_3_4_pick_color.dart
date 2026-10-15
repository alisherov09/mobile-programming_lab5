import 'package:flutter/material.dart';

void main() => runApp(const Task3_4App());

class Task3_4App extends StatelessWidget {
  const Task3_4App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ColorDisplayScreen(),
    );
  }
}

class ColorDisplayScreen extends StatefulWidget {
  const ColorDisplayScreen({super.key});

  @override
  State<ColorDisplayScreen> createState() => _ColorDisplayScreenState();
}

class _ColorDisplayScreenState extends State<ColorDisplayScreen> {
  Color _selectedColor = Colors.deepPurple;

  Future<void> _chooseColor() async {
    // Await the result returned from Navigator.pop(context, color)
    final Color? chosenColor = await Navigator.push<Color>(
      context,
      MaterialPageRoute(builder: (context) => const ColorPickerScreen()),
    );

    // If the user selected a colour and the widget is still mounted, update the state
    if (chosenColor != null && mounted) {
      setState(() {
        _selectedColor = chosenColor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick a Colour (Return Result)'),
        backgroundColor: _selectedColor,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: _selectedColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: _selectedColor.withOpacity(0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Current Colour: ${_colorName(_selectedColor)}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                icon: const Icon(Icons.palette),
                label: const Text('Choose colour'),
                onPressed: _chooseColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _colorName(Color color) {
    if (color == Colors.redAccent) return 'Red';
    if (color == Colors.green) return 'Green';
    if (color == Colors.amber) return 'Amber';
    if (color == Colors.deepPurple) return 'Deep Purple';
    return color.toString();
  }
}

class ColorPickerScreen extends StatelessWidget {
  const ColorPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const choices = [
      {'name': 'Ruby Red', 'color': Colors.redAccent},
      {'name': 'Emerald Green', 'color': Colors.green},
      {'name': 'Sunny Amber', 'color': Colors.amber},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Colour'),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Tap a colour button to return it to Screen 1:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              for (final choice in choices) ...[
                SizedBox(
                  width: 220,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: choice['color'] as Color,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      // Return the selected Color object back to Screen 1
                      Navigator.pop(context, choice['color'] as Color);
                    },
                    child: Text(
                      choice['name'] as String,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
