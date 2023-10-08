import 'package:aeda/View/login.dart';
import 'package:aeda/ViewModel/create_viewModel.dart';
import 'package:aeda/ViewModel/login_viewModel.dart';
import 'package:aeda/ViewModel/my_feed_viewModel.dart';
import 'package:aeda/ViewModel/profile_viewModel.dart';
import 'package:aeda/ViewModel/register_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => RegisterViewModel()),
        ChangeNotifierProvider(create: (context) => ProfileViewModel()),
        ChangeNotifierProvider(create: (context) => CreateViewModel()),
        ChangeNotifierProvider(create: (context) => MyFeedViewModel()),
      ],
      child: MaterialApp(
        title: 'AEDA',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF333333),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white70),
          useMaterial3: true,
        ),
        home: const LoginPage(),
      ),
    );
  }
}
