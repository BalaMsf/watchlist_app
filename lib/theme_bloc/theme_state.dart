part of 'theme_bloc.dart';

abstract class ThemeState {}

class ThemeInitialState extends ThemeState {}

class ThemeChangeState extends ThemeState {
  final ThemeData themeData;

  ThemeChangeState(this.themeData);
}
