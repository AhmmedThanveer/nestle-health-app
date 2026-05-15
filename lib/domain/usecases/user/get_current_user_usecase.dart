import '../../entities/user_entity.dart';
import '../../repositories/user_repository.dart';
import '../../../core/utils/result.dart';

class GetCurrentUserUseCase {
  final UserRepository _repository;
  const GetCurrentUserUseCase(this._repository);

  Future<Result<UserEntity>> call(String uid) => _repository.getUserById(uid);
}
