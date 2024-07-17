import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sound_mind/core/routes/routes.dart';
import 'package:sound_mind/core/services/injection_container.dart' as di;
import 'package:sound_mind/core/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(
      fileName: '.env'); // Load environment variables from application folder
  await di.init(); // Initialize dependency injection
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'sound_mind',
      theme: appTheme,
      darkTheme: darkTheme,
      routerConfig: Routes.router,
    );
  }
}
