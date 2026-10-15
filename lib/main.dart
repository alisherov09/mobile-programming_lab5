import 'package:flutter/material.dart';

import 'category_1_push_pop/task_1_1_push_pop_sample.dart' as t1_1;
import 'category_1_push_pop/task_1_2_three_screen_chain.dart' as t1_2;
import 'category_1_push_pop/task_1_3_replace_not_stack.dart' as t1_3;
import 'category_1_push_pop/task_1_4_back_to_start.dart' as t1_4;
import 'category_1_push_pop/task_1_5_smart_back_button.dart' as t1_5;

import 'category_2_named_routes/task_2_1_named_routes_sample.dart' as t2_1;
import 'category_2_named_routes/task_2_2_menu_four_routes.dart' as t2_2;
import 'category_2_named_routes/task_2_3_page_not_found.dart' as t2_3;
import 'category_2_named_routes/task_2_4_drawer_navigation.dart' as t2_4;
import 'category_2_named_routes/task_2_5_logout_flow.dart' as t2_5;

import 'category_3_constructor_args/task_3_1_product_details_sample.dart' as t3_1;
import 'category_3_constructor_args/task_3_2_greeting.dart' as t3_2;
import 'category_3_constructor_args/task_3_3_contact_card.dart' as t3_3;
import 'category_3_constructor_args/task_3_4_pick_color.dart' as t3_4;
import 'category_3_constructor_args/task_3_5_edit_counter.dart' as t3_5;

import 'category_4_named_route_args/task_4_1_screen_arguments_sample.dart' as t4_1;
import 'category_4_named_route_args/task_4_2_send_number.dart' as t4_2;
import 'category_4_named_route_args/task_4_3_user_profile.dart' as t4_3;
import 'category_4_named_route_args/task_4_4_on_generate_route.dart' as t4_4;
import 'category_4_named_route_args/task_4_5_result_named_route.dart' as t4_5;

import 'category_5_transitions/task_5_1_fade_transition_sample.dart' as t5_1;
import 'category_5_transitions/task_5_2_slide_from_right.dart' as t5_2;
import 'category_5_transitions/task_5_3_slide_from_bottom.dart' as t5_3;
import 'category_5_transitions/task_5_4_scale_and_fade.dart' as t5_4;
import 'category_5_transitions/task_5_5_reusable_route_global_theme.dart' as t5_5;

import 'category_6_go_router/task_6_1_go_router_sample.dart' as t6_1;
import 'category_6_go_router/task_6_2_path_parameters.dart' as t6_2;
import 'category_6_go_router/task_6_3_passing_extra.dart' as t6_3;
import 'category_6_go_router/task_6_4_named_routes_404.dart' as t6_4;
import 'category_6_go_router/task_6_5_transitions_go_router.dart' as t6_5;

void main() {
  runApp(const LabNavigationHubApp());
}

class LabNavigationHubApp extends StatelessWidget {
  const LabNavigationHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 5: Navigation & Routing in Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const LabMasterScreen(),
    );
  }
}

class TaskItem {
  final String id;
  final String title;
  final String difficulty;
  final int points;
  final String description;
  final Widget Function() appBuilder;

  const TaskItem({
    required this.id,
    required this.title,
    required this.difficulty,
    required this.points,
    required this.description,
    required this.appBuilder,
  });
}

class CategoryGroup {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final List<TaskItem> tasks;

  const CategoryGroup({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.tasks,
  });
}

class LabMasterScreen extends StatefulWidget {
  const LabMasterScreen({super.key});

  @override
  State<LabMasterScreen> createState() => _LabMasterScreenState();
}

class _LabMasterScreenState extends State<LabMasterScreen> {
  final List<CategoryGroup> _categories = [
    CategoryGroup(
      title: 'Category 1: Push and Pop',
      subtitle: 'Basic Navigator stack operations',
      icon: Icons.layers,
      color: Colors.blue,
      tasks: [
        TaskItem(
          id: '1.1',
          title: 'Two screens with push and pop',
          difficulty: 'Solved Example',
          points: 0,
          description: 'Basic push with MaterialPageRoute and pop back.',
          appBuilder: () => const t1_1.Task1_1App(),
        ),
        TaskItem(
          id: '1.2',
          title: 'Three-screen chain (A -> B -> C)',
          difficulty: '★ Easy',
          points: 10,
          description: 'Screens A, B, C with different colors and back on C.',
          appBuilder: () => const t1_2.Task1_2App(),
        ),
        TaskItem(
          id: '1.3',
          title: 'Replace, do not stack',
          difficulty: '★ Easy',
          points: 10,
          description: 'Login to Home with Navigator.pushReplacement.',
          appBuilder: () => const t1_3.Task1_3App(),
        ),
        TaskItem(
          id: '1.4',
          title: 'Back to the start',
          difficulty: '★★ Medium',
          points: 15,
          description: 'Step 1-4 flow, Finish pops until route.isFirst.',
          appBuilder: () => const t1_4.Task1_4App(),
        ),
        TaskItem(
          id: '1.5',
          title: 'Smart back button',
          difficulty: '★★ Medium',
          points: 15,
          description: 'Reusable BackOrExitButton checking Navigator.canPop.',
          appBuilder: () => const t1_5.Task1_5App(),
        ),
      ],
    ),
    CategoryGroup(
      title: 'Category 2: Named routes',
      subtitle: 'Centralized route table and unknown route handling',
      icon: Icons.route,
      color: Colors.teal,
      tasks: [
        TaskItem(
          id: '2.1',
          title: 'Route table and pushNamed',
          difficulty: 'Solved Example',
          points: 0,
          description: 'AppRoutes constants with MaterialApp route table.',
          appBuilder: () => const t2_1.Task2_1App(),
        ),
        TaskItem(
          id: '2.2',
          title: 'Menu with four routes',
          difficulty: '★ Easy',
          points: 10,
          description: 'ListView with ListTiles navigating with pushNamed.',
          appBuilder: () => const t2_2.Task2_2App(),
        ),
        TaskItem(
          id: '2.3',
          title: 'Page not found',
          difficulty: '★★ Medium',
          points: 15,
          description: 'NotFoundScreen registered with onUnknownRoute.',
          appBuilder: () => const t2_3.Task2_3App(),
        ),
        TaskItem(
          id: '2.4',
          title: 'Drawer navigation',
          difficulty: '★★ Medium',
          points: 15,
          description: 'Drawer navigation with pushReplacementNamed.',
          appBuilder: () => const t2_4.Task2_4App(),
        ),
        TaskItem(
          id: '2.5',
          title: 'Log out (Clear Stack)',
          difficulty: '★★★ Challenging',
          points: 20,
          description: 'pushNamedAndRemoveUntil to clear stack on logout.',
          appBuilder: () => const t2_5.Task2_5App(),
        ),
      ],
    ),
    CategoryGroup(
      title: 'Category 3: Constructor Arguments',
      subtitle: 'Type-safe argument passing and returning results',
      icon: Icons.move_to_inbox,
      color: Colors.indigo,
      tasks: [
        TaskItem(
          id: '3.1',
          title: 'Product list to product details',
          difficulty: 'Solved Example',
          points: 0,
          description: 'Passing Product model directly to constructor.',
          appBuilder: () => const t3_1.Task3_1App(),
        ),
        TaskItem(
          id: '3.2',
          title: 'Greeting with TextField',
          difficulty: '★ Easy',
          points: 10,
          description: 'Name passed via constructor: "Hello, <name>!".',
          appBuilder: () => const t3_2.Task3_2App(),
        ),
        TaskItem(
          id: '3.3',
          title: 'Contact card (object argument)',
          difficulty: '★★ Medium',
          points: 15,
          description: 'Contact object with name, phone, email in styled card.',
          appBuilder: () => const t3_3.Task3_3App(),
        ),
        TaskItem(
          id: '3.4',
          title: 'Pick a colour (result back)',
          difficulty: '★★ Medium',
          points: 20,
          description: 'Navigator.pop(context, color) awaited with setState.',
          appBuilder: () => const t3_4.Task3_4App(),
        ),
        TaskItem(
          id: '3.5',
          title: 'Edit a counter',
          difficulty: '★★★ Challenging',
          points: 20,
          description: 'Counter editor returning updated int, handling null.',
          appBuilder: () => const t3_5.Task3_5App(),
        ),
      ],
    ),
    CategoryGroup(
      title: 'Category 4: Named Route Arguments',
      subtitle: 'Passing data via arguments and onGenerateRoute',
      icon: Icons.input,
      color: Colors.deepOrange,
      tasks: [
        TaskItem(
          id: '4.1',
          title: 'ScreenArguments class',
          difficulty: 'Solved Example',
          points: 0,
          description: 'Passing class via arguments and reading ModalRoute.',
          appBuilder: () => const t4_1.Task4_1App(),
        ),
        TaskItem(
          id: '4.2',
          title: 'Send a number',
          difficulty: '★ Easy',
          points: 10,
          description: 'Send plain int to /square and calculate square.',
          appBuilder: () => const t4_2.Task4_2App(),
        ),
        TaskItem(
          id: '4.3',
          title: 'User profile',
          difficulty: '★★ Medium',
          points: 15,
          description: 'User class passed in named route arguments.',
          appBuilder: () => const t4_3.Task4_3App(),
        ),
        TaskItem(
          id: '4.4',
          title: 'onGenerateRoute',
          difficulty: '★★★ Challenging',
          points: 20,
          description: 'Dynamic dispatch and type validation in onGenerateRoute.',
          appBuilder: () => const t4_4.Task4_4App(),
        ),
        TaskItem(
          id: '4.5',
          title: 'Result from a named route',
          difficulty: '★★★ Challenging',
          points: 20,
          description: 'pushNamed<int> awaiting 5-star rating result.',
          appBuilder: () => const t4_5.Task4_5App(),
        ),
      ],
    ),
    CategoryGroup(
      title: 'Category 5: Transition Animations',
      subtitle: 'PageRouteBuilder, slide, scale, fade, and themes',
      icon: Icons.animation,
      color: Colors.purple,
      tasks: [
        TaskItem(
          id: '5.1',
          title: 'Fade transition',
          difficulty: 'Solved Example',
          points: 0,
          description: 'PageRouteBuilder with 400ms FadeTransition.',
          appBuilder: () => const t5_1.Task5_1App(),
        ),
        TaskItem(
          id: '5.2',
          title: 'Slide from the right',
          difficulty: '★ Easy',
          points: 10,
          description: 'SlideTransition starting at Offset(1, 0).',
          appBuilder: () => const t5_2.Task5_2App(),
        ),
        TaskItem(
          id: '5.3',
          title: 'Slide from the bottom',
          difficulty: '★★ Medium',
          points: 15,
          description: 'Sheet slide from Offset(0, 1) with Curves.easeOut.',
          appBuilder: () => const t5_3.Task5_3App(),
        ),
        TaskItem(
          id: '5.4',
          title: 'Scale and fade together',
          difficulty: '★★ Medium',
          points: 15,
          description: 'Nested Scale (0.8 to 1.0) and Fade transitions.',
          appBuilder: () => const t5_4.Task5_4App(),
        ),
        TaskItem(
          id: '5.5',
          title: 'Reusable route & global theme',
          difficulty: '★★★ Challenging',
          points: 20,
          description: 'FadeRoute class and CupertinoPageTransitionsBuilder.',
          appBuilder: () => const t5_5.Task5_5App(),
        ),
      ],
    ),
    CategoryGroup(
      title: 'Category 6: go_router',
      subtitle: 'Declarative routing with parameters and transitions',
      icon: Icons.alt_route,
      color: Colors.green,
      tasks: [
        TaskItem(
          id: '6.1',
          title: 'First router: go, push and pop',
          difficulty: 'Solved Example',
          points: 0,
          description: 'Comparing context.go vs context.push in go_router.',
          appBuilder: () => const t6_1.Task6_1App(),
        ),
        TaskItem(
          id: '6.2',
          title: 'Path parameters',
          difficulty: '★ Easy',
          points: 10,
          description: 'Route /product/:id read via state.pathParameters.',
          appBuilder: () => const t6_2.Task6_2App(),
        ),
        TaskItem(
          id: '6.3',
          title: 'Passing an object with extra',
          difficulty: '★★ Medium',
          points: 15,
          description: 'Passing Product via extra and browser reload handling.',
          appBuilder: () => const t6_3.Task6_3App(),
        ),
        TaskItem(
          id: '6.4',
          title: 'Named routes and 404 page',
          difficulty: '★★ Medium',
          points: 15,
          description: 'context.goNamed with pathParameters & errorBuilder.',
          appBuilder: () => const t6_4.Task6_4App(),
        ),
        TaskItem(
          id: '6.5',
          title: 'Transition in go_router',
          difficulty: '★★★ Challenging',
          points: 20,
          description: 'CustomTransitionPage with buildPage helper function.',
          appBuilder: () => const t6_5.Task6_5App(),
        ),
      ],
    ),
  ];

  void _launchTask(TaskItem task) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskViewerContainer(task: task),
      ),
    );
  }

  void _showAnswersDialog() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LabAnswersScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Lab 5: Navigation & Routing',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'View Self-Check Answers & Grading',
            icon: const Icon(Icons.help_outline),
            onPressed: _showAnswersDialog,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          // Header Card
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: Colors.blue.shade50,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade600,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.school, color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Complete Lab 5 Solution Suite',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                            Text(
                              'All 30 Tasks Implemented (6 Categories × 5 Tasks)',
                              style: TextStyle(fontSize: 13, color: Colors.black85),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Tap any category to expand its tasks. You can run and test each task independently with its complete features, animations, and parameter handling.',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 14),
                  FilledButton.tonalIcon(
                    icon: const Icon(Icons.question_answer),
                    label: const Text('Read Self-Check Answers (10/10 pts)'),
                    onPressed: _showAnswersDialog,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Category Expansion Tiles
          for (final cat in _categories) ...[
            Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              elevation: 1.5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(color: cat.color.withOpacity(0.2)),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  leading: CircleAvatar(
                    backgroundColor: cat.color.withOpacity(0.15),
                    child: Icon(cat.icon, color: cat.color),
                  ),
                  title: Text(
                    cat.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Text(cat.subtitle, style: const TextStyle(fontSize: 12)),
                  children: [
                    const Divider(height: 1),
                    for (final task in cat.tasks) ...[
                      ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                        leading: Container(
                          width: 44,
                          height: 44,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: cat.color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            task.id,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: cat.color,
                            ),
                          ),
                        ),
                        title: Text(
                          task.title,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          '${task.difficulty} • ${task.points > 0 ? '${task.points} pts' : 'Example'}\n${task.description}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        trailing: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: cat.color,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                          ),
                          icon: const Icon(Icons.play_arrow, size: 18),
                          label: const Text('Run'),
                          onPressed: () => _launchTask(task),
                        ),
                      ),
                      const Divider(height: 1, indent: 64),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Container that runs the individual task and provides a "Return to Master Menu" bar
class TaskViewerContainer extends StatelessWidget {
  final TaskItem task;
  const TaskViewerContainer({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(42),
        child: Container(
          color: Colors.grey.shade900,
          child: SafeArea(
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 20),
                  tooltip: 'Back to Lab Hub',
                  onPressed: () => Navigator.pop(context),
                ),
                Text(
                  'Task ${task.id}: ${task.title}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    task.difficulty,
                    style: const TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: task.appBuilder(),
    );
  }
}

/// Screen containing all answers to Self-Check questions from Page 14 & in-text questions
class LabAnswersScreen extends StatelessWidget {
  const LabAnswersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 5 Answers & Self-Check'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Self-Check Questions (Page 14)',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildQuestionCard(
            '1. What is the difference between push and pushReplacement?',
            '• Navigator.push: Places a new route ON TOP of the current navigation stack. The previous screen remains underneath, so pressing the back button (or calling Navigator.pop) returns to it.\n\n'
                '• Navigator.pushReplacement: Disposes and REPLACES the current top route with the new route. The old route is removed from memory and stack. Pressing back will not return to the replaced screen (ideal for Login -> Home flows).',
          ),
          _buildQuestionCard(
            '2. Why should route names be kept in constants?',
            '• Prevents silent typos (e.g. typing "/proflie" instead of "/profile") that only fail at runtime.\n'
                '• Enables IDE autocomplete and compile-time verification.\n'
                '• Simplifies refactoring: if a route path changes, it only needs to be updated in one place (e.g., AppRoutes.profile).',
          ),
          _buildQuestionCard(
            '3. How do you return a value from a screen, and what is received if the user presses the system back button?',
            '• To return a value: Call Navigator.pop(context, resultValue) from the pushed screen. The pushing screen receives it by awaiting the push call: final result = await Navigator.push<T>(...);\n\n'
                '• When the user presses the system back button (or the default AppBar back arrow), Navigator.pop(context) is executed without any arguments, so the awaiting caller receives null.',
          ),
          _buildQuestionCard(
            '4. What is the difference between context.go and context.push in go_router?',
            '• context.go: Declaratively sets the current URI location and replaces the active stack according to the route tree hierarchy. If not a nested subroute, there is no back arrow.\n\n'
                '• context.push: Imperatively pushes the new location on top of the current Navigator stack, regardless of URL tree nesting. The AppBar displays a back arrow and context.pop() will return to the previous screen.',
          ),
          _buildQuestionCard(
            '5. When is a path parameter better than extra?',
            '• Browser reload & Deep linking safety: On Flutter Web, refreshing the browser re-evaluates the URL. Path parameters (e.g. /product/42) are encoded in the URL and survive refreshes, bookmarks, and sharing.\n\n'
                '• state.extra is an in-memory Dart object reference. On browser reload, it becomes null, causing crashes if relied upon without fallback.',
          ),
          const SizedBox(height: 16),
          const Text(
            'In-Text Observation Questions',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildQuestionCard(
            'Category 1: System back button on each screen (A -> B -> C)',
            '• On Screen C: System back pops C, returning to Screen B.\n'
                '• On Screen B: System back pops B, returning to Screen A.\n'
                '• On Screen A: A is the root route (canPop is false), so system back exits or minimizes the app.',
          ),
          _buildQuestionCard(
            'Category 4: What does Home display if user returns with back arrow?',
            'When the user returns from /rate via the back arrow, await Navigator.pushNamed<int>(...) resolves to null. Home checks if rating == null and either maintains the previous rating or indicates that the rating was cancelled, preventing null dereference errors.',
          ),
          _buildQuestionCard(
            'Category 6: Why does AppBar have no back arrow after go, but does after push?',
            '• After context.go(\'/details\'), the router matches /details at root level and rebuilds the page stack with only DetailsScreen. Because there is no route below it in the stack, Navigator.canPop is false and no back arrow is displayed.\n'
                '• After context.push(\'/details\'), DetailsScreen is pushed directly on top of HomeScreen in the existing stack. HomeScreen remains below it, so canPop is true and the back arrow appears.',
          ),
          const SizedBox(height: 20),
          _buildProgressTable(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(String question, String answer) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              answer,
              style: const TextStyle(fontSize: 14, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressTable() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Self-Check and Progress Sheet (Completed)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Table(
              border: TableBorder.all(color: Colors.grey.shade300),
              children: const [
                TableRow(
                  decoration: BoxDecoration(color: Color(0xFFF1F5F9)),
                  children: [
                    Padding(padding: EdgeInsets.all(8), child: Text('Category', style: TextStyle(fontWeight: FontWeight.bold))),
                    Padding(padding: EdgeInsets.all(8), child: Center(child: Text('X.1', style: TextStyle(fontWeight: FontWeight.bold)))),
                    Padding(padding: EdgeInsets.all(8), child: Center(child: Text('X.2', style: TextStyle(fontWeight: FontWeight.bold)))),
                    Padding(padding: EdgeInsets.all(8), child: Center(child: Text('X.3', style: TextStyle(fontWeight: FontWeight.bold)))),
                    Padding(padding: EdgeInsets.all(8), child: Center(child: Text('X.4', style: TextStyle(fontWeight: FontWeight.bold)))),
                    Padding(padding: EdgeInsets.all(8), child: Center(child: Text('X.5', style: TextStyle(fontWeight: FontWeight.bold)))),
                  ],
                ),
                TableRow(children: [
                  Padding(padding: EdgeInsets.all(8), child: Text('1. Push & Pop')),
                  Padding(padding: EdgeInsets.all(8), child: Center(child: Text('✅'))),
                  Padding(padding: EdgeInsets.all(8), child: Center(child: Text('✅'))),
                  Padding(padding: EdgeInsets.all(8), child: Center(child: Text('✅'))),
                  Padding(padding: EdgeInsets.all(8), child: Center(child: Text('✅'))),
                  Padding(padding: EdgeInsets.all(8), child: Center(child: Text('✅'))),
                ]),
                TableRow(children: [
                  Padding(padding: EdgeInsets.all(8), child: Text('2. Named routes')),
                  Padding(padding: EdgeInsets.all(8), child: Center(child: Text('✅'))),
                  Padding(padding: EdgeInsets.all(8), child: Center(child: Text('✅'))),
                  Padding(padding: EdgeInsets.all(8), child: Center(child: Text('✅'))),
                  Padding(padding: EdgeInsets.all(8), child: Center(child: Text('✅'))),
                  Padding(padding: EdgeInsets.all(8), child: Center(child: Text('✅'))),
                ]),
                TableRow(children: [
                  Padding(padding: EdgeInsets.all(8), child: Text('3. Constructor args')),
                  Padding(padding: EdgeInsets.all(8), child: Center(child: Text('✅'))),
                  Padding(padding: EdgeInsets.all(8), child: Center(child: Text('✅'))),
                  Padding(padding: EdgeInsets.all(8), child: Center(child: Text('✅'))),
                  Padding(padding: EdgeInsets.all(8), child: Center(child: Text('✅'))),
                  Padding(padding: EdgeInsets.all(8), child: Center(child: Text('✅'))),
                ]),
                TableRow(children: [
                  Padding(padding: EdgeInsets.all(8), child: Text('4. Named route args')),
                  Padding(padding: EdgeInsets.all(8), child: Center(child: Text('✅'))),
                  Padding(padding: EdgeInsets.all(8), child: Center(child: Text('✅'))),
                  Padding(padding: EdgeInsets.all(8), child: Center(child: Text('✅'))),
                  Padding(padding: EdgeInsets.all(8), child: Center(child: Text('✅'))),
                  Padding(padding: EdgeInsets.all(8), child: Center(child: Text('✅'))),
                ]),
                TableRow(children: [
                  Padding(padding: EdgeInsets.all(8), child: Text('5. Transitions')),
                  Padding(padding: EdgeInsets.all(8), child: Center(child: Text('✅'))),
                  Padding(padding: EdgeInsets.all(8), child: Center(child: Text('✅'))),
                  Padding(padding: EdgeInsets.all(8), child: Center(child: Text('✅'))),
                  Padding(padding: EdgeInsets.all(8), child: Center(child: Text('✅'))),
                  Padding(padding: EdgeInsets.all(8), child: Center(child: Text('✅'))),
                ]),
                TableRow(children: [
                  Padding(padding: EdgeInsets.all(8), child: Text('6. go_router')),
                  Padding(padding: EdgeInsets.all(8), child: Center(child: Text('✅'))),
                  Padding(padding: EdgeInsets.all(8), child: Center(child: Text('✅'))),
                  Padding(padding: EdgeInsets.all(8), child: Center(child: Text('✅'))),
                  Padding(padding: EdgeInsets.all(8), child: Center(child: Text('✅'))),
                  Padding(padding: EdgeInsets.all(8), child: Center(child: Text('✅'))),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
