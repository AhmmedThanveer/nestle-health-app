import '../../entities/user_entity.dart';
import '../../repositories/user_repository.dart';
import '../../../core/utils/result.dart';

class UpdateProfileUseCase {
  final UserRepository _repository;
  const UpdateProfileUseCase(this._repository);

  Future<Result<UserEntity>> call(UserEntity user) =>
      _repository.updateUser(user);
}
