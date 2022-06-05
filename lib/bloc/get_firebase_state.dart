part of 'get_firebase_cubit.dart';

@immutable
abstract class GetFirebaseState {}

class GetFirebaseInitial extends GetFirebaseState {}

class GetFirebaseLoading extends GetFirebaseState {}

class GetFirebaseSuccess extends GetFirebaseState {
  final List<Product>? productList;
  GetFirebaseSuccess(this.productList);
}

class GetFirebaseError extends GetFirebaseState {
  final String? message;
  GetFirebaseError(this.message);
}

class GetFirebaseFailed extends GetFirebaseState {
  final String? message;
  GetFirebaseFailed(this.message);
}
