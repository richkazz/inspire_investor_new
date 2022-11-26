import 'package:http/http.dart' as http;

import '../../../../core/error/error.dart';
abstract class EmailVerificationRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<bool> postEmailVerification(String token);
  Future<bool> postRequestNewToken(String email);

}

class EmailVerificationRemoteDataSourceImpl implements EmailVerificationRemoteDataSource {
  final http.Client client;

  EmailVerificationRemoteDataSourceImpl({required this.client});

  @override
  Future<bool> postEmailVerification(String token)async {
    final requestBody = {
      "token" : token,
    };
    try{
      final response = await client.post(
        Uri.http('http://numbersapi.com/1'),body: requestBody,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw ServerException();
      }
    }catch (s){
      throw ServerException();
    }


  }

@override
  Future<bool> postRequestNewToken(String email)async {
    final requestBody = {
      "token" : email,
    };
    try{
      final response = await client.post(
        Uri.http('http://numbersapi.com/1'),body: requestBody,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw ServerException();
      }
    }catch (s){
      throw ServerException();
    }


  }



}