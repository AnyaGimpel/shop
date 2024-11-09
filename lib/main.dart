import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/navigation_cubit.dart';
import 'package:shop/services/api_service.dart';
import 'app.dart';

void setupLocator() {
  GetIt.instance.registerLazySingleton<ApiService>(() => ApiService());
}

void main() {
  setupLocator();
  runApp(
    BlocProvider(
      create: (_) => NavigationCubit(),
      child: const MyApp(),
    ),
  );
}
