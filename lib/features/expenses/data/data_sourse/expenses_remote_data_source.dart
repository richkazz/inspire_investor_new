
import 'package:http/http.dart' as http;

import '../../../../core/error/error.dart';
abstract class ExpensesRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<bool> postExpenses(Map<String, String> expenses);

}

class ExpensesRemoteDataSourceImpl implements ExpensesRemoteDataSource {
  final http.Client client;

  ExpensesRemoteDataSourceImpl({required this.client});

  @override
  Future<bool> postExpenses(Map<String, String> expenses)async {
    final requestBody = {
      "token" : "",
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