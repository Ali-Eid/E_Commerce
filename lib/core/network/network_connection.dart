import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkConnection {
  Future<bool> get isConnected;
}

class NetworkConnectionImplements implements NetworkConnection {
  final InternetConnectionChecker isConnection;

  NetworkConnectionImplements(this.isConnection);
  @override
  Future<bool> get isConnected => isConnection.hasConnection;
}
