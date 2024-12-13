import '../repository/repositories.dart';

class RequestHeader {
  AuthRepository authRepository = AuthRepository();
  Future<Map<String, String>>? authorisedHeader() async => <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await authRepository.getToken()}'
      };
  Future<Map<String, String>>? defaultHeader() async => <String, String>{
        'Content-Type': 'application/json',
        // 'app-key': 'OGV8V1FCa1FXaDVGZw'
      };
}
