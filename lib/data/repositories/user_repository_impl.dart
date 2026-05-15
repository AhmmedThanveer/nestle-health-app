import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/remote/user_remote_datasource.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _ds;
  const UserRepositoryImpl(this._ds);

  @override
  Future<Result<UserEntity>> getUserById(String uid) async {
    try {
      return Success(await _ds.getUserById(uid));
    } on ServerException catch (e) {
      return Failure(ServerFailure(e.message));
    } catch (e) {
      return Failure(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Result<UserEntity>> updateUser(UserEntity user) async {
    try {
      return Success(await _ds.updateUser(UserModel.fromEntity(user)));
    } on ServerException catch (e) {
      return Failure(ServerFailure(e.message));
    } catch (e) {
      return Failure(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> updateFcmToken({
    required String uid,
    required String token,
  }) async {
    try {
      await _ds.updateFcmToken(uid: uid, token: token);
      return const Success(null);
    } on ServerException catch (e) {
      return Failure(ServerFailure(e.message));
    } catch (e) {
      return Failure(UnexpectedFailure(e.toString()));
    }
  }
}
