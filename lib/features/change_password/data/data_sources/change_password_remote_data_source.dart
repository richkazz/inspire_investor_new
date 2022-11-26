
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../../core/error/exception.dart';
import '../../domain/entities/change_password.dart';
import '../models/change_password_model.dart';

abstract class ChangePasswordRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ChangePasswordModel> postChangePassword(ChangePassword changePassword);

}

class ChangePasswordRemoteDataSourceImpl implements ChangePasswordRemoteDataSource {
  final http.Client client;

  ChangePasswordRemoteDataSourceImpl({required this.client});

  @override
  Future<ChangePasswordModel> postChangePassword(ChangePassword changePassword)async {
    final requestBody = {
      "email" : changePassword.email,
      "password" : changePassword.password,
      "confirmPassword" : changePassword.confirmPassword
    };
    try{
      final response = await client.post(
        Uri.http('http://numbersapi.com/1'),body: requestBody,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return ChangePasswordModel.fromJson(json.decode(response.body));
      } else {
        throw ServerException();
      }
    }catch (s){
      throw ServerException();
    }


  }

 

}