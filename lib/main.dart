import 'package:auth_app/screens/app/home_screen.dart';
import 'package:auth_app/screens/auth/core/launch_screen.dart';
import 'package:auth_app/screens/auth/login_screen.dart';
import 'package:auth_app/screens/auth/register_phone_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/launch_screen',
          routes: {
            '/launch_screen': (context) => const LaunchScreen(),
            '/login_screen': (context) => const LoginScreen(),
            '/register_phone_screen': (context) => const RegisterPhoneScreen(),
            '/home_screen': (context) => const HomeScreen(),
          },
        );
      },
    );
  }
}
