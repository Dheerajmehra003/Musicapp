import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/screens/mainWrapper.dart';

import 'bloc/playerbloc/player_bloc.dart';

void main() {
  runApp(BlocProvider(create: (_) => PlayerBloc(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MainWrapper(),
    );
  }
}
