import 'package:aeda/View/bottom_nav_bar.dart';
import 'package:aeda/View/event_details.dart';
import 'package:aeda/View/filter.dart';
import 'package:aeda/View/filtered_posts.dart';
import 'package:aeda/View/interested_area.dart';
import 'package:aeda/View/login.dart';
import 'package:aeda/View/my_feed.dart';
import 'package:aeda/View/register.dart';
import 'package:aeda/ViewModel/login_viewModel.dart';
import 'package:aeda/ViewModel/register_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => RegisterViewModel()),
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
