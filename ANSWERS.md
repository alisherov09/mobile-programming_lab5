# Mobile Development – Lab 5: Navigation & Routing in Flutter
## Self-Check Questions, In-Text Observations & Progress Sheet

---

### Part 1: Answers to Self-Check Questions (Page 14)

#### 1. What is the difference between `push` and `pushReplacement`?
* **`Navigator.push`**:
  * Pushes a new route **on top** of the current navigation history stack.
  * The screen underneath remains active in memory.
  * The newly displayed screen automatically gets a leading back button in its `AppBar` (or can be dismissed with system back / `Navigator.pop`), returning the user to the previous screen.
* **`Navigator.pushReplacement`**:
  * **Replaces** the current top route with the new route.
  * The previous route is disposed and removed from the navigation stack.
  * Pressing the back button will not return to the replaced screen because it no longer exists on the stack.
  * **Common use case**: Transitioning from a **Login screen** or Splash screen to the **Home screen**, ensuring that users cannot press "Back" to re-enter the login or splash page after successfully authenticating.

---

#### 2. Why should route names be kept in constants?
Keeping route names in a dedicated class of static constants (e.g., `AppRoutes.settings = '/settings'`) provides several critical software engineering benefits:
1. **Prevents Typo Bugs at Runtime**: In Flutter's standard named route system, route names are raw strings (`String`). A typo like `Navigator.pushNamed(context, '/settngs')` will not be caught by the Dart compiler and will crash or trigger a 404 at runtime. Using `AppRoutes.settings` ensures compile-time type checking.
2. **IDE Autocomplete & Tooling**: Developers get instant code completion and discoverability in the IDE when referencing `AppRoutes.`.
3. **Single Source of Truth / Easy Refactoring**: If a URL path or route endpoint changes, modifying the single constant in `AppRoutes` updates it throughout the entire project without searching and replacing magic strings across dozens of files.

---

#### 3. How do you return a value from a screen, and what is received if the user presses the system back button?
* **How to return a value**:
  1. On the screen being closed, pass the return value as the optional second argument to `Navigator.pop`:
     ```dart
     Navigator.pop(context, selectedColor);
     ```
  2. On the caller screen, await the `Navigator.push` call typed with the expected return type:
     ```dart
     final Color? result = await Navigator.push<Color>(
       context,
       MaterialPageRoute(builder: (context) => const ColorPickerScreen()),
     );
     if (result != null && mounted) {
       setState(() => _currentColor = result);
     }
     ```
* **What is received if the user presses the system back button (or default AppBar back arrow)?**:
  * Flutter automatically invokes `Navigator.pop(context)` without an argument.
  * Consequently, the awaited `Future` completes with **`null`**.
  * **Handling Best Practice**: Always handle `null` gracefully (e.g. `if (result != null)`) so the app preserves its existing state without throwing runtime `NullCheck` or cast exceptions.

---

#### 4. What is the difference between `context.go` and `context.push` in `go_router`?
* **`context.go(location)`**:
  * **Declarative navigation**.
  * Matches the target URI path against the routing tree and rebuilds the navigation stack according to the URL structure.
  * If the destination is a top-level route (e.g., `/details`), the router replaces the existing navigation stack with just the target screen.
  * As a consequence, `Navigator.canPop(context)` is `false`, no automatic back arrow is shown in the `AppBar`, and calling `context.pop()` will throw an error because there is no prior route in the stack.
* **`context.push(location)`**:
  * **Imperative navigation**.
  * Pushes the destination route directly on top of whatever screen is currently visible, exactly like standard `Navigator.push`.
  * The navigation stack keeps the previous screen intact underneath.
  * An `AppBar` back button is rendered automatically, and `context.pop()` safely returns to the previous screen.

---

#### 5. When is a path parameter better than `extra`?
* **Path Parameters (`/product/:id`)**:
  * Stored directly within the URL string (`/product/42`).
  * **Web & Deep Link Safe**: When running on Flutter Web or handling deep links on mobile, if the user bookmarks the page, copies and shares the link, or presses the browser's **Refresh (F5)** button, the URL remains `/product/42`. The app reads `state.pathParameters['id']` and successfully reloads the resource.
* **`extra` Object (`context.push('/product-details', extra: product)`)**:
  * `extra` passes an in-memory Dart object reference.
  * On Flutter Web, if the user refreshes the page or navigates directly via URL, the in-memory object is lost, and `state.extra` evaluates to **`null`**.
  * Unless complex fallback serialization is implemented, attempting to cast `state.extra as Product` results in an uncaught null exception.
* **Conclusion**: Path parameters (or query parameters) are strictly superior for identifying unique resources (`id`, `uuid`, `slug`) that need to be shareable, reload-safe, and deep-linkable. `extra` is primarily convenient for passing ephemeral, complex non-primitive objects during same-session mobile transitions.

---

### Part 2: Answers to In-Text Observations

#### Observation 1 (Category 1, Page 4): System back button on Three-screen chain (A -> B -> C)
* **On Screen C**: Pressing the system back button triggers `Navigator.pop`, popping Screen C off the stack and revealing Screen B.
* **On Screen B**: Pressing system back pops Screen B, revealing Screen A.
* **On Screen A**: Because Screen A is the root route (`route.isFirst` is true, `Navigator.canPop` is false), pressing the system back button exits/minimizes the Flutter app to the home screen of the device/OS.

#### Observation 2 (Category 4, Page 10): Back arrow behavior on `/rate`
* **Question**: What does Home display if the user returns with the back arrow?
* **Answer**: If the user dismisses `/rate` using the AppBar back arrow or system back, `Navigator.pop(context)` returns `null`. On the Home screen, `final rating = await Navigator.pushNamed<int>(...)` receives `null`. Our implementation checks `if (rating != null)` to update the score; otherwise, it displays an informative message (e.g. `"Rating cancelled"` or keeps the previously selected rating), preventing null errors.

#### Observation 3 (Category 6, Page 13): Missing back arrow after `context.go` vs `context.push`
* **Question**: Observe: after `go`, the AppBar may have no back arrow and `context.pop()` has nothing to pop. After `push`, the arrow is visible and pop works. Why?
* **Answer**:
  * `context.go('/details')` navigates declaratively: it sets the active route configuration to `/details`. Because `/details` is defined at the top level of the routes array rather than as a nested sub-route child of `/`, `go_router` creates a fresh stack containing only `DetailsScreen`. There is no screen below it, so `Navigator.canPop` is `false` and no back arrow is created.
  * `context.push('/details')` pushes `DetailsScreen` onto the existing navigator stack. `HomeScreen` remains underneath on the stack, allowing the back button to show and `context.pop()` to pop back to `HomeScreen`.

#### Observation 4 (Category 6, Page 13): `extra` on browser reload
* **Question**: What happens with `extra` when the app is reloaded in a browser? Why is a path parameter safer?
* **Answer**: In Flutter Web, the browser history only stores the URI string. `extra` is held in ephemeral Dart runtime memory. When the page is reloaded in the browser, the entire Flutter Web app restarts, memory is cleared, and `state.extra` becomes `null`. A path parameter is encoded directly into the browser URL path (e.g. `/product/2`), so when the page reloads, the router extracts the parameter from the URL address and restores the screen correctly.

---

### Part 3: Self-Check and Progress Sheet (All Tasks Completed)

| Category | X.1 (Solved Sample) | X.2 | X.3 | X.4 | X.5 |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **1. Push and pop** | ✅ Solved | ✅ Solved | ✅ Solved | ✅ Solved | ✅ Solved |
| **2. Named routes** | ✅ Solved | ✅ Solved | ✅ Solved | ✅ Solved | ✅ Solved |
| **3. Constructor arguments** | ✅ Solved | ✅ Solved | ✅ Solved | ✅ Solved | ✅ Solved |
| **4. Named-route arguments** | ✅ Solved | ✅ Solved | ✅ Solved | ✅ Solved | ✅ Solved |
| **5. Transitions** | ✅ Solved | ✅ Solved | ✅ Solved | ✅ Solved | ✅ Solved |
| **6. go_router** | ✅ Solved | ✅ Solved | ✅ Solved | ✅ Solved | ✅ Solved |

### Score Calculation
* **Minimum set** (6 samples + tasks X.2, X.3): **70 / 70 pts**
* **Bonus tasks** (tasks X.4, X.5): **30 / 30 pts**
* **Answers to self-check questions**: **10 / 10 pts**
* **Total Points**: **110 / 110 pts (100% + Full Bonus)**
