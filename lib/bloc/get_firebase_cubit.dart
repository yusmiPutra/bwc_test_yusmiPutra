import 'package:bloc/bloc.dart';
import 'package:bwc_test/model/res_product.dart';
import 'package:bwc_test/utils/internet_utils.dart';
import 'package:bwc_test/utils/notification_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import '../repositories/firebase_repo.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'get_firebase_state.dart';

class GetFirebaseCubit extends Cubit<GetFirebaseState> {
  GetFirebaseCubit() : super(GetFirebaseInitial());

  InternetUtils internetUtils = InternetUtils(InternetConnectionChecker());
  FirebaseRepo repo = FirebaseRepo();
  List<Product> productList = [];

  Future<void> getData() async {
    if (await internetUtils.isConnectedToInternet()) {
      try {
        emit(GetFirebaseLoading());
        var res = await repo.getProduct();
        if (res != null) {
          productList = res;
          await repo.saveAllProduct(productList);
          emit(GetFirebaseSuccess(productList));
        } else {
          NotificationUtils.showSnackbar('Gagal menampilkan');
          emit(GetFirebaseError('Gagal menampilkan'));
        }
      } catch (e, st) {
        print(st);
        NotificationUtils.showSnackbar(e.toString());
        emit(GetFirebaseError(e.toString()));
      }
    } else {
      try {
        var localDataSave = await repo.getAllProduct();
        productList = localDataSave;
        emit(GetFirebaseSuccess(localDataSave));
      } catch (e, st) {
        print(st);
        NotificationUtils.showSnackbar(e.toString());
        emit(GetFirebaseError(e.toString()));
      }
    }
  }
}
