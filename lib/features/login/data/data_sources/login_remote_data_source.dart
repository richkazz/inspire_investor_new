
import 'dart:convert';

import 'package:inspire_investors/features/login/data/models/login_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/error.dart';
import '../../domain/entities/login.dart';


abstract class LoginRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<LoginModel> postLogin(Login login);

}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final http.Client client;

  LoginRemoteDataSourceImpl({required this.client});

  @override
  Future<LoginModel> postLogin(Login login)async {
    final requestBody = {
      "email" : login.email,
      "password" : login.password,
    };
    try{
      final response = await client.post(
        Uri.http('http://numbersapi.com/1'),body: requestBody,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return LoginModel.fromJson(json.decode(response.body));
      } else {
        throw ServerException();
      }
    }catch (s){
      throw ServerException();
    }


  }



}