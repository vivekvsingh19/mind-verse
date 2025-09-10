# 📱 Flutter Quick Reference Cheat Sheet

## 🚀 Basic Flutter Commands

```bash
# Create new Flutter project
flutter create my_app

# Run the app
flutter run

# Hot reload (while app is running)
r

# Hot restart (while app is running)
R

# Build for release
flutter build apk          # Android
flutter build ios          # iOS
flutter build web          # Web

# Check Flutter installation
flutter doctor

# Get packages
flutter pub get

# Clean build
flutter clean
```

## 🧩 Essential Widgets

### Layout Widgets
```dart
Container()           // Box with padding, margin, decoration
Column()             // Vertical layout
Row()                // Horizontal layout
Stack()              // Layered layout
Expanded()           // Takes available space
Padding()            // Adds padding
Center()             // Centers child widget
Scaffold()           // App structure (AppBar, Body, etc.)
```

### UI Widgets
```dart
Text('Hello')        // Display text
Icon(Icons.home)     // Display icon
Image.asset('path')  // Display image
TextField()          // Text input
ElevatedButton()     // Raised button
Card()              // Material card
ListView()          // Scrollable list
GridView()          // Grid layout
```

### Navigation
```dart
// Navigate to new screen
Navigator.push(context, MaterialPageRoute(
  builder: (context) => NewScreen(),
));

// Go back
Navigator.pop(context);

// Replace current screen
Navigator.pushReplacement(context, MaterialPageRoute(
  builder: (context) => NewScreen(),
));
```

## 🔧 Common Code Patterns

### StatefulWidget Template
```dart
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  // Your state variables here
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Counter: $counter'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            counter++;
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
```

### Custom Widget Function
```dart
Widget buildCustomCard(String title, String subtitle) {
  return Card(
    child: ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: Icon(Icons.star),
    ),
  );
}
```

### Text Styling
```dart
Text(
  'Styled Text',
  style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
    decoration: TextDecoration.underline,
  ),
)
```

### Container Styling
```dart
Container(
  width: 200,
  height: 100,
  padding: EdgeInsets.all(16),
  margin: EdgeInsets.symmetric(vertical: 8),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0, 3),
      ),
    ],
  ),
  child: Text('Content'),
)
```

## 🎨 Colors and Themes

### Predefined Colors
```dart
Colors.red
Colors.blue
Colors.green
Colors.grey[300]    // Light grey
Colors.grey[700]    // Dark grey
```

### Custom Colors
```dart
Color(0xFF123456)           // Hex color
Color.fromRGBO(255, 0, 0, 1.0)  // RGB color
```

### Theme Setup
```dart
MaterialApp(
  theme: ThemeData(
    primarySwatch: Colors.blue,
    fontFamily: 'Roboto',
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    ),
  ),
)
```

## 📱 Screen Sizes and Responsive Design

```dart
// Get screen dimensions
double screenWidth = MediaQuery.of(context).size.width;
double screenHeight = MediaQuery.of(context).size.height;

// Responsive layout
Widget responsiveWidget() {
  return LayoutBuilder(
    builder: (context, constraints) {
      if (constraints.maxWidth > 600) {
        return DesktopLayout();
      } else {
        return MobileLayout();
      }
    },
  );
}
```

## 🎯 Common Mistakes to Avoid

1. **Forgetting setState()** - UI won't update without it
2. **Not using const** - Performance issue with widgets
3. **Deep widget nesting** - Extract to functions/classes
4. **Not handling null values** - Use null checks
5. **Forgetting to dispose controllers** - Memory leaks

## 📁 File Structure Best Practices

```
lib/
├── main.dart
├── screens/
│   ├── home_screen.dart
│   └── profile_screen.dart
├── widgets/
│   ├── custom_button.dart
│   └── loading_widget.dart
├── models/
│   └── user.dart
├── services/
│   └── api_service.dart
└── utils/
    └── constants.dart
```

## 🔄 State Management Quick Reference

### setState (Local State)
```dart
setState(() {
  counter++;
});
```

### TextEditingController
```dart
final controller = TextEditingController();

TextField(controller: controller)

// Get text
String text = controller.text;

// Don't forget to dispose
@override
void dispose() {
  controller.dispose();
  super.dispose();
}
```

### ScrollController
```dart
final scrollController = ScrollController();

ListView(controller: scrollController)

// Scroll to bottom
scrollController.animateTo(
  scrollController.position.maxScrollExtent,
  duration: Duration(milliseconds: 300),
  curve: Curves.easeOut,
);
```

## 🚨 Debugging Tips

### Print Statements
```dart
print('Debug: $variableName');
debugPrint('Debug message'); // Better for production
```

### Widget Inspector
- Use Flutter Inspector in your IDE
- Click on widgets to see their properties
- Understand widget tree structure

### Common Error Solutions
- **Red screen**: Check for missing semicolons, brackets
- **Widget overflow**: Wrap in Expanded or Flexible
- **Asset not found**: Check pubspec.yaml and file paths
- **State not updating**: Make sure you're calling setState()

## 📦 pubspec.yaml Template

```yaml
name: my_app
description: A Flutter application
version: 1.0.0+1

environment:
  sdk: '>=2.19.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0

flutter:
  uses-material-design: true
  
  assets:
    - assets/images/
    - assets/icons/
  
  fonts:
    - family: CustomFont
      fonts:
        - asset: fonts/CustomFont-Regular.ttf
```

---

## 🎓 Learning Path

### Beginner (You are here! ✅)
- ✅ Basic widgets and layouts
- ✅ StatefulWidget vs StatelessWidget
- ✅ Navigation between screens
- ✅ Asset management
- ✅ Basic styling and themes

### Intermediate (Next Steps)
- [ ] State management (Provider/Bloc)
- [ ] HTTP requests and APIs
- [ ] Local storage (SharedPreferences)
- [ ] Form validation
- [ ] Custom animations

### Advanced (Future Goals)
- [ ] Complex state management
- [ ] Platform-specific code
- [ ] Custom widgets and packages
- [ ] Performance optimization
- [ ] Testing and CI/CD

---

**🎉 You've built an amazing mental health app! Keep practicing and exploring Flutter - the possibilities are endless!**
