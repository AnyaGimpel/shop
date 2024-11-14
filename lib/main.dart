import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/services/cart_storage.dart';
import 'blocs/navigation_cubit.dart';
import 'blocs/product_cubit.dart';
import 'blocs/cart_cubit.dart';
import 'package:shop/services/api_service.dart';
import 'app.dart';

/// Sets up dependencies for the application using GetIt.
/// Registers single instances for `ApiService`, `CartStorage`, and `CartCubit`.
void setupLocator() {
  GetIt.instance.registerLazySingleton<ApiService>(() => ApiService());
  GetIt.instance.registerLazySingleton<CartStorage>(() => CartStorage());
  GetIt.instance.registerLazySingleton<CartCubit>(() => CartCubit(GetIt.instance<CartStorage>()));
}

/// Entry point for the application.
void main() {
  setupLocator(); // Initialize dependency injection.

  runApp(
    // MultiBlocProvider is used to provide multiple BLoCs to the widget tree.
    MultiBlocProvider(
      providers: [
        // Provides the NavigationCubit
        BlocProvider(create: (_) => NavigationCubit()),
        
        // Provides the ProductCubit
        BlocProvider(create: (_) => ProductCubit()),

        // Provides the CartCubit
        BlocProvider(create: (_) => GetIt.instance<CartCubit>()),
      ],
      // Starts the app with MyApp as the root widget
      child: const MyApp(), 
    ),
  );
}
