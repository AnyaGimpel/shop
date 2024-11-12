import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/services/cart_storage.dart';
import 'blocs/navigation_cubit.dart';
import 'blocs/product_cubit.dart';
import 'blocs/cart_cubit.dart';
import 'package:shop/services/api_service.dart';
import 'app.dart';

void setupLocator() {
  GetIt.instance.registerLazySingleton<ApiService>(() => ApiService());
  GetIt.instance.registerLazySingleton<CartStorage>(() => CartStorage());
  GetIt.instance.registerLazySingleton<CartCubit>(() => CartCubit(GetIt.instance<CartStorage>()));
}

void main() {
  setupLocator(); 

  runApp(
    
    MultiBlocProvider(
      providers: [
        
        BlocProvider(create: (_) => NavigationCubit()),
        
        BlocProvider(create: (_) => ProductCubit()),

        BlocProvider(create: (_) => GetIt.instance<CartCubit>()),
      ],
      child: const MyApp(), 
    ),
  );
}
