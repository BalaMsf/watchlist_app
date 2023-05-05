import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/watchlist_screen.dart';
import 'theme_bloc/theme_bloc.dart';
import 'themes/light_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          ThemeData themeData = lightTheme();
          if (state is ThemeChangeState) {
            themeData = state.themeData;
          }
          return MaterialApp(
            theme: themeData,
            home: WatchlistScreen(),
          );
        },
      ),
    );
  }
}
