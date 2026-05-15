import '../../entities/user_entity.dart';
import '../../repositories/auth_repository.dart';
import '../../../core/utils/result.dart';

class LoginUseCase {
  final AuthRepository _repository;
  const LoginUseCase(this._repository);

  Future<Result<UserEntity>> call({
    required String email,
    required String password,
  }) =>
      _repository.signIn(email: email, password: password);
}
