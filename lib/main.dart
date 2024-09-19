import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sound_mind/core/routes/routes.dart';
import 'package:sound_mind/core/services/injection_container.dart' as di;
import 'package:sound_mind/core/services/injection_container.dart';
import 'package:sound_mind/core/theme/theme.dart';
import 'package:sound_mind/features/Authentication/presentation/blocs/Authentication_bloc.dart';
import 'package:sound_mind/features/Security/presentation/blocs/Security_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(
      fileName: '.env'); // Load environment variables from application folder
  await di.init(); // Initialize dependency injection
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // l<AuthenticationBloc>(),
        BlocProvider(
          create: (context) => sl<AuthenticationBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<SecurityBloc>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'sound_mind',
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        darkTheme: darkTheme,
        routerConfig: Routes.router,
      ),
    );
  }
}
