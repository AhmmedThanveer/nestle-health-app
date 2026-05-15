import '../../repositories/auth_repository.dart';
import '../../../core/utils/result.dart';

class ForgotPasswordUseCase {
  final AuthRepository _repository;
  const ForgotPasswordUseCase(this._repository);

  Future<Result<void>> call({required String email}) =>
      _repository.sendPasswordResetEmail(email: email);
}
