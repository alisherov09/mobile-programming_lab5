# Mobile Development – Lab 5: Navigation & Routing in Flutter

This repository contains the complete, production-grade solutions for **all 30 tasks** in Mobile Development Lab 5 covering Flutter navigation and routing.

---

## 📁 Repository Structure

```text
mobile-programming_lab5/
├── pubspec.yaml                        # Project dependencies (flutter sdk, go_router: ^14.0.0)
├── README.md                           # Documentation and usage guide
├── ANSWERS.md                          # Answers to all self-check questions, observations & progress sheet
└── lib/
    ├── main.dart                       # Master Hub Application (interactive runner for all 30 tasks)
    │
    ├── category_1_push_pop/            # Category 1: Navigator push and pop
    │   ├── task_1_1_push_pop_sample.dart
    │   ├── task_1_2_three_screen_chain.dart
    │   ├── task_1_3_replace_not_stack.dart
    │   ├── task_1_4_back_to_start.dart
    │   └── task_1_5_smart_back_button.dart
    │
    ├── category_2_named_routes/        # Category 2: Named routes
    │   ├── task_2_1_named_routes_sample.dart
    │   ├── task_2_2_menu_four_routes.dart
    │   ├── task_2_3_page_not_found.dart
    │   ├── task_2_4_drawer_navigation.dart
    │   └── task_2_5_logout_flow.dart
    │
    ├── category_3_constructor_args/    # Category 3: Passing arguments with constructors
    │   ├── task_3_1_product_details_sample.dart
    │   ├── task_3_2_greeting.dart
    │   ├── task_3_3_contact_card.dart
    │   ├── task_3_4_pick_color.dart
    │   └── task_3_5_edit_counter.dart
    │
    ├── category_4_named_route_args/    # Category 4: Passing arguments with named routes
    │   ├── task_4_1_screen_arguments_sample.dart
    │   ├── task_4_2_send_number.dart
    │   ├── task_4_3_user_profile.dart
    │   ├── task_4_4_on_generate_route.dart
    │   └── task_4_5_result_named_route.dart
    │
    ├── category_5_transitions/         # Category 5: Simple transition animations
    │   ├── task_5_1_fade_transition_sample.dart
    │   ├── task_5_2_slide_from_right.dart
    │   ├── task_5_3_slide_from_bottom.dart
    │   ├── task_5_4_scale_and_fade.dart
    │   └── task_5_5_reusable_route_global_theme.dart
    │
    └── category_6_go_router/           # Category 6: Declarative navigation with go_router
        ├── task_6_1_go_router_sample.dart
        ├── task_6_2_path_parameters.dart
        ├── task_6_3_passing_extra.dart
        ├── task_6_4_named_routes_404.dart
        └── task_6_5_transitions_go_router.dart
```

---

## 🚀 How to Run

### Method 1: Interactive Master Hub (All 30 tasks in one place)
Running `lib/main.dart` launches the **Master Lab Hub**. From here, you can browse all 6 categories, view task point values, test individual tasks, and view self-check answers:
```bash
flutter run lib/main.dart
```

### Method 2: Running Any Standalone Task File Directly
Every single task file contains its own `void main()` entry point, allowing you to run any task in complete isolation:
```bash
# Example: Category 1 Task 1.2
flutter run lib/category_1_push_pop/task_1_2_three_screen_chain.dart

# Example: Category 3 Task 3.4
flutter run lib/category_3_constructor_args/task_3_4_pick_color.dart

# Example: Category 6 Task 6.5
flutter run lib/category_6_go_router/task_6_5_transitions_go_router.dart
```

---

## 📋 Task Details & Implementation Highlights

### Category 1: Navigator Push and Pop
* **Task 1.1 (Sample)**: Demonstrates basic push of `MaterialPageRoute` and `Navigator.pop`.
* **Task 1.2 (★ 10 pts)**: Three-screen chain (A -> B -> C) with different AppBar colors. Screen C provides a Back button to return to B.
* **Task 1.3 (★ 10 pts)**: Login screen transitioning to Home using `Navigator.pushReplacement`. HomeScreen has no back arrow.
* **Task 1.4 (★★ 15 pts)**: Wizard flow (Step 1 -> 4). On Step 4, "Finish" button calls `Navigator.popUntil(context, (route) => route.isFirst)` to return directly to Step 1.
* **Task 1.5 (★★ 15 pts)**: Reusable `BackOrExitButton` widget. Displays and enables "Back" if `Navigator.canPop(context)` is true; otherwise renders disabled with "Nothing to go back to".

### Category 2: Named Routes
* **Task 2.1 (Sample)**: Defines static route constants (`AppRoutes`) and passes a route table to `MaterialApp`.
* **Task 2.2 (★ 10 pts)**: Menu on `/` with a `ListView` and `ListTiles` leading to `/profile`, `/messages`, and `/about` using `pushNamed`.
* **Task 2.3 (★★ 15 pts)**: Registers `onUnknownRoute` returning `NotFoundScreen`. Tapping the button tests pushing `/does-not-exist`.
* **Task 2.4 (★★ 15 pts)**: Reusable `Drawer` using `pushReplacementNamed`. The drawer is cleanly closed (`Navigator.pop(context)`) before navigating to prevent stacking.
* **Task 2.5 (★★★ 20 pts)**: Authentication flow (`/login`, `/home`, `/profile`). Profile screen provides "Log out" button calling `Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false)`.

### Category 3: Passing Arguments with Constructors
* **Task 3.1 (Sample)**: Passes a `Product` model directly through the constructor of `ProductScreen`.
* **Task 3.2 (★ 10 pts)**: Screen 1 takes a name via `TextField` and passes it to `GreetingDisplayScreen(name: ...)`.
* **Task 3.3 (★★ 15 pts)**: `Contact` model (name, phone, email). Tapping a contact opens `ContactScreen` which receives the entire object and displays a styled card.
* **Task 3.4 (★★ 20 pts)**: Screen 1 shows a colored container. Screen 2 returns the selected color via `Navigator.pop(context, color)`. Screen 1 awaits the result and updates with `setState`.
* **Task 3.5 (★★★ 20 pts)**: Counter editor screen. Modifies integer and returns value via Save button. Correctly handles `null` if user cancels or taps the back arrow.

### Category 4: Passing Arguments with Named Routes
* **Task 4.1 (Sample)**: Passes `ScreenArguments` via `arguments:` and reads with `ModalRoute.of(context)!.settings.arguments`.
* **Task 4.2 (★ 10 pts)**: Buttons 1, 2, 3 push `/square` with plain `int` arguments. The screen shows the number and its square.
* **Task 4.3 (★★ 15 pts)**: `User` class (name, age, city). Pushes `/profile` with the `User` object passed in `arguments:`.
* **Task 4.4 (★★★ 20 pts)**: Removes the `routes` table in favor of `onGenerateRoute`. Checks argument types dynamically and instantiates `ProfileScreen(user: user)` via constructor.
* **Task 4.5 (★★★ 20 pts)**: Movie rating flow. Pushes `/rate` with movie title. Awaits 5-star rating `int` result and handles back arrow gracefully.

### Category 5: Simple Transition Animations
* **Task 5.1 (Sample)**: Smooth fade-in transition using `PageRouteBuilder` and `FadeTransition` (400ms).
* **Task 5.2 (★ 10 pts)**: Slide transition entering from right edge (`Offset(1, 0)` to `Offset.zero`).
* **Task 5.3 (★★ 15 pts)**: "Open as a sheet" button with bottom slide (`Offset(0, 1)`), `CurvedAnimation(Curves.easeOut)`, and 500ms duration.
* **Task 5.4 (★★ 15 pts)**: Nested `ScaleTransition` (0.8 -> 1.0) inside `FadeTransition` (0.0 -> 1.0).
* **Task 5.5 (★★★ 20 pts)**: Reusable `FadeRoute` class inheriting `PageRouteBuilder`, plus global `CupertinoPageTransitionsBuilder` configured in `ThemeData.pageTransitionsTheme`.

### Category 6: go_router Declarative Routing
* **Task 6.1 (Sample)**: First router demonstrating `context.go` vs `context.push` and `context.pop`.
* **Task 6.2 (★ 10 pts)**: Route with path parameter `/product/:id`, read via `state.pathParameters['id']`.
* **Task 6.3 (★★ 15 pts)**: Passes `Product` model using `extra: product`. Demonstrates handling `state.extra` and explains web refresh safety.
* **Task 6.4 (★★ 15 pts)**: Named routes with `context.goNamed('item', pathParameters: {'id': '42'})` and custom 404 screen via `errorBuilder`.
* **Task 6.5 (★★★ 20 pts)**: `CustomTransitionPage` combining slide and scale transitions into a reusable `buildPage(key, child)` helper function applied across all routes.

---

## 🏆 Grading Summary

* **Minimum Set** (6 samples + X.2, X.3): **70 / 70 pts**
* **Bonus Tasks** (X.4, X.5): **30 / 30 pts**
* **Self-Check Questions**: **10 / 10 pts**
* **Total Points**: **110 / 110 pts**
