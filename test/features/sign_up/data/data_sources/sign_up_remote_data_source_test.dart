import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:inspire_investors/features/sign_up/data/data_sources/sign_up_remote_data_source.dart';
import 'package:inspire_investors/features/sign_up/data/models/sign_up_model.dart';
import 'package:inspire_investors/features/sign_up/domain/entities/sign_up.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  SignUpRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient = MockHttpClient();

  dataSource = SignUpRemoteDataSourceImpl(client: mockHttpClient);

  group('getConcreteNumberTrivia', () {
    const signUp = SignUp(
        name: 'karo',
        email: 'edawarekaro@gmail.com',
        password: 'pass',
        confirmPassword: 'pass');

    test(
      'should preform a Post request on a URL with signup being the endpoint and with application/json header',
      () {
        //arrange
        var url = Uri.https('example.com', 'whatsit/create');
        when(mockHttpClient.post(url, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('sign_up.json'), 200),
        );
        // act
        dataSource.postSignUpData(signUp);
        // assert
        final body = {
          "name": "karo",
          "email": "edawarekaro@gmail.com",
          "password": "pass",
          "confirmPassword": "pass"
        };
        verify(mockHttpClient.post(
          url,
          body: body,
          headers: {'Content-Type': 'application/json'},
        ));
      },
    );

    final tNumberTriviaModel =
    SignUpModel.fromJson(json.decode(fixture('trivia.json')));
    test(
    'should return NumberTrivia when the response code is 200 (success)',
    () async {
      var url = Uri.https('example.com', 'whatsit/create');
    // arrange
    when(mockHttpClient.get(url, headers: anyNamed('headers'))).thenAnswer(
    (_) async => http.Response(fixture('trivia.json'), 200),
    );
    // act
    final result = await dataSource.postSignUpData(signUp);
    // assert
    expect(result, equals(tNumberTriviaModel));
    },
    );
  });
}
