import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitialState()) {
    on<ThemeEvent>((event, emit) {
      print('===>ThemeModeBloc');
      emit(ThemeChangeState(event.themeData));
    });
  }
}
