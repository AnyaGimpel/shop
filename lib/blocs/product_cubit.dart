import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:shop/models/product.dart';

/// Cubit to manage the state of a selected [Product] item.
class ProductCubit extends Cubit<Product?>{
  /// Initializes the cubit with no selected product (null state).
  ProductCubit() : super (null);

  /// Sets the provided [product] as the currently selected product.
  ///
  /// This method emits the new product, updating any listeners.
  void selectProduct (Product product){
    emit(product);
  } 

}