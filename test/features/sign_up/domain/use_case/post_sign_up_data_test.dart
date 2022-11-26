
import 'package:inspire_investors/features/sign_up/domain/entities/sign_up.dart';
import 'package:inspire_investors/features/sign_up/domain/repositories/sign_up_repositories.dart';
import 'package:inspire_investors/features/sign_up/domain/usecases/post_sign_up_data.dart';
import 'package:mockito/mockito.dart';
class MockSignUpRepositories extends Mock implements SignUpRepositories{

}

void main() {
  PostSignUpData usecase;
  MockSignUpRepositories mockSignUpRepositories;

  // setUp(() {
  //   mockSignUpRepositories = MockSignUpRepositories();
  //   usecase = PostSignUpData(mockSignUpRepositories);
  // });
}