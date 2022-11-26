

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/error/error.dart';
import '../models/change_password_profile_model.dart';

class ChangePasswordProfileRemoteDataSourceImpl{

  ChangePasswordProfileRemoteDataSourceImpl();

  Future<ChangePasswordProfileModel> postChangePassword(ChangePasswordProfileModel changePassword)async {
    http.Client client = http.Client();
    try{
      final response = await client.post(
        Uri.http('http://numbersapi.com/1'),body: changePassword.toJson(),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return ChangePasswordProfileModel.fromJson(json.decode(response.body));
      } else {
        throw ServerException();
      }
    }catch (s){
      throw ServerException();
    }


  }



}