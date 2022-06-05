import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetUtils {
  final InternetConnectionChecker checker;

  InternetUtils(this.checker);

  Future<bool> isConnectedToInternet() async {
    return checker.hasConnection;
  }
}