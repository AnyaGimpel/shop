import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:shop/models/product.dart';

class ProductCubit extends Cubit<Product?>{
  ProductCubit() : super (null);

  void selectProduct (Product product){
    emit(product);
  } 

}