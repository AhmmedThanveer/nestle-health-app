import '../entities/user_entity.dart';
import '../../core/utils/result.dart';

abstract class UserRepository {
  Future<Result<UserEntity>> getUserById(String uid);
  Future<Result<UserEntity>> updateUser(UserEntity user);
  Future<Result<void>> updateFcmToken({required String uid, required String token});
}
