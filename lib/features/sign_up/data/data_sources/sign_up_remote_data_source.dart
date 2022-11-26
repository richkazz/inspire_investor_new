
import 'dart:convert';

import 'package:inspire_investors/features/sign_up/data/models/sign_up_model.dart';
import 'package:http/http.dart' as http;
import '../../../../core/error/exception.dart';
import '../../domain/entities/sign_up.dart';

abstract class SignUpRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<SignUpModel> postSignUpData(SignUp signUp);

}

class SignUpRemoteDataSourceImpl implements SignUpRemoteDataSource {
  final http.Client client;

  SignUpRemoteDataSourceImpl({required this.client});

  @override
  Future<SignUpModel> postSignUpData(SignUp signUp)async {
    final requestBody = {
      "name" : signUp.name,
      "email" : signUp.email,
      "password" : signUp.password,
      "confirmPassword" : signUp.confirmPassword
    };
    try{
      final response = await client.post(
        Uri.http('http://numbersapi.com/1'),body: requestBody,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return SignUpModel.fromJson(json.decode(response.body));
      } else {
        throw ServerException();
      }
    }catch (s){
      throw ServerException();
    }


  }

 

}