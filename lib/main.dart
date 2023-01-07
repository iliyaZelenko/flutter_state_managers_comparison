import 'package:flutter/material.dart';
import 'package:todos_state_managers_comparison/presentation/cubit/widgets/body_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 60),
          // TODO Profile
          child: BodyCubit(), // BodyMobX(),
        ),
      ),
    );
  }
}
