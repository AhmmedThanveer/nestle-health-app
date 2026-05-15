import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/auth_remote_datasource.dart';
import '../datasources/remote/user_remote_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authDs;
  final UserRemoteDataSource _userDs;

  const AuthRepositoryImpl({
    required AuthRemoteDataSource authDataSource,
    required UserRemoteDataSource userDataSource,
  })  : _authDs = authDataSource,
        _userDs = userDataSource;

  @override
  Stream<UserEntity?> get authStateChanges =>
      _authDs.authStateChanges.asyncMap((user) async {
        if (user == null) return null;
        try {
          return await _userDs.getUserById(user.uid);
        } catch (_) {
          return null;
        }
      });

  @override
  UserEntity? get currentUser {
    final u = _authDs.currentUser;
    if (u == null) return null;
    return UserModel(
      uid: u.uid,
      firstName: '',
      familyName: '',
      email: u.email ?? '',
      mobile: '',
      profession: '',
      city: '',
      workplace: '',
      saudiCouncilNumber: '',
    );
  }

  @override
  Future<Result<UserEntity>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _authDs.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = await _userDs.getUserById(cred.user!.uid);
      return Success(user);
    } on AuthException catch (e) {
      return Failure(AuthFailure(e.message));
    } on ServerException catch (e) {
      return Failure(ServerFailure(e.message));
    } catch (e) {
      return Failure(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Result<UserEntity>> signUp({
    required String email,
    required String password,
    required String firstName,
    required String familyName,
    required String mobile,
    required String profession,
    required String city,
    required String workplace,
    required String saudiCouncilNumber,
    required String selectedTopic,
    required String eventId,
  }) async {
    try {
      final cred = await _authDs.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = UserModel(
        uid: cred.user!.uid,
        firstName: firstName,
        familyName: familyName,
        email: email,
        mobile: mobile,
        profession: profession,
        city: city,
        workplace: workplace,
        saudiCouncilNumber: saudiCouncilNumber,
        selectedTopic: selectedTopic,
        eventId: eventId,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _userDs.createUser(user);
      return Success(user);
    } on AuthException catch (e) {
      return Failure(AuthFailure(e.message));
    } on ServerException catch (e) {
      return Failure(ServerFailure(e.message));
    } catch (e) {
      return Failure(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      await _authDs.signOut();
      return const Success(null);
    } on AuthException catch (e) {
      return Failure(AuthFailure(e.message));
    } catch (e) {
      return Failure(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> sendPasswordResetEmail({required String email}) async {
    try {
      await _authDs.sendPasswordResetEmail(email: email);
      return const Success(null);
    } on AuthException catch (e) {
      return Failure(AuthFailure(e.message));
    } catch (e) {
      return Failure(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await _authDs.reauthenticateAndChangePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      return const Success(null);
    } on AuthException catch (e) {
      return Failure(AuthFailure(e.message));
    } catch (e) {
      return Failure(UnexpectedFailure(e.toString()));
    }
  }
}
