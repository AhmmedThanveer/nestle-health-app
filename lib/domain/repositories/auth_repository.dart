import '../entities/user_entity.dart';
import '../../core/utils/result.dart';

abstract class AuthRepository {
  /// Emits [UserEntity] when signed in, null when signed out.
  Stream<UserEntity?> get authStateChanges;

  UserEntity? get currentUser;

  Future<Result<UserEntity>> signIn({
    required String email,
    required String password,
  });

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
  });

  Future<Result<void>> signOut();

  Future<Result<void>> sendPasswordResetEmail({required String email});

  Future<Result<void>> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<Result<void>> deleteAccount({required String password});
}
