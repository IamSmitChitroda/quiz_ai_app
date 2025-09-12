import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/chat/presentation/chat_screen.dart';
import 'features/dashboard/presentation/dashboard_screen.dart';
import 'features/quiz/repositories/quiz_repository.dart';
import 'features/quiz/services/quiz_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<QuizRepository>(
          create: (_) => QuizRepository(),
        ),
        Provider<QuizService>(
          create: (_) => QuizService(prefs),
        ),
      ],
      child: MaterialApp(
        title: 'AI Study Buddy',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const DashboardScreen(),
      ),
    );
  }
}
