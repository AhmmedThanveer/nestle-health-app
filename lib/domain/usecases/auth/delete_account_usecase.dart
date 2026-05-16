import '../../../core/utils/result.dart';
import '../../repositories/auth_repository.dart';

class DeleteAccountUseCase {
  final AuthRepository _repository;
  const DeleteAccountUseCase(this._repository);

  Future<Result<void>> call({required String password}) =>
      _repository.deleteAccount(password: password);
}
