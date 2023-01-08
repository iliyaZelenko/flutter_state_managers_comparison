import 'package:flutter/material.dart';
import 'package:todos_state_managers_comparison/presentation/mobx/widgets/body_mob_x.dart';

void main() {
  // Track MobX events
  // mainContext
  //   ..config = mainContext.config.clone(
  //     isSpyEnabled: true,
  //   )
  //   ..spy(print);

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
          child: BodyMobX(), // BodyBloc, BodyCubit
        ),
      ),
    );
  }
}
