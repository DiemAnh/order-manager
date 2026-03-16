import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_manager/presentations/features/tab_navigation/bloc/tab_navigation_bloc.dart';
import 'package:order_manager/presentations/features/tab_navigation/tab_navigation_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quản lý nhà hàng',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 222, 196, 246),
        ),
      ),

      home: BlocProvider(
        create: (_) => TabNavigationBloc(),
        child: const TabNavigatorScreen(),
      ),
    );
  }
}