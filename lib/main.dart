import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/navigation_cubit.dart';
import 'app.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => NavigationCubit(),
      child: const MyApp(),
    ),
  );
}
