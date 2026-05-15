import '../../repositories/auth_repository.dart';
import '../../../core/utils/result.dart';

class SignOutUseCase {
  final AuthRepository _repository;
  const SignOutUseCase(this._repository);

  Future<Result<void>> call() => _repository.signOut();
}
