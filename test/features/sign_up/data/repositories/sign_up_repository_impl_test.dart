
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inspire_investors/core/error/exception.dart';
import 'package:inspire_investors/core/error/failures.dart';
import 'package:inspire_investors/core/platform/network_info.dart';
import 'package:inspire_investors/features/sign_up/data/data_sources/sign_up_remote_data_source.dart';
import 'package:inspire_investors/features/sign_up/data/models/sign_up_model.dart';
import 'package:inspire_investors/features/sign_up/data/repositories/sign_up_repository_impl.dart';
import 'package:inspire_investors/features/sign_up/domain/entities/sign_up.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock
    implements SignUpRemoteDataSource {}


class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  SignUpRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;
  const signUp = SignUp(name: 'karo', email: 'edawarekaro@gmail.com',password: 'pass',confirmPassword: 'pass');
  const signUpModel = SignUpModel(name: 'karo', email: 'edawarekaro@gmail.com',password: 'pass',confirmPassword: 'pass');

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = SignUpRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
    group('getConcreteNumberTrivia', () {
      // DATA FOR THE MOCKS AND ASSERTIONS
      // We'll use these three variables throughout all the tests


      test('should check if the device is online', () {
        //arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.postSignUpData(signUp);
        // assert
        verify(mockNetworkInfo.isConnected);
      });
    });

    group('device is online', () {
      // This setUp applies only to the 'device is online' group
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
        'should return remote data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.postSignUpData(signUp))
              .thenAnswer((_) async => signUpModel);
          // act
          final result = await repository.postSignUpData(signUp);
          // assert
          verify(mockRemoteDataSource.postSignUpData(signUp));
          expect(result, equals(const Right(signUpModel)));
        },
      );
    });

    test(
      'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.postSignUpData(signUp))
            .thenThrow(ServerException());
        // act
        final result = await repository.postSignUpData(signUp);
        // assert
        verify(mockRemoteDataSource.postSignUpData(signUp));
        expect(result, equals(Left(ServerFailure())));
      },
    );

  });


}