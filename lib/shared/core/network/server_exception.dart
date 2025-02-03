import '../error_model/error_server_model.dart';


class ServerException implements Exception {
  final ErrorServerModel errorServerModel;

  ServerException({required this.errorServerModel});
}
