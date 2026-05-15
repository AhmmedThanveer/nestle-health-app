import '../../entities/user_entity.dart';
import '../../repositories/auth_repository.dart';
import '../../../core/utils/result.dart';

class RegisterParams {
  final String email;
  final String password;
  final String firstName;
  final String familyName;
  final String mobile;
  final String profession;
  final String city;
  final String workplace;
  final String saudiCouncilNumber;
  final String selectedTopic;
  final String eventId;

  const RegisterParams({
    required this.email,
    required this.password,
    required this.firstName,
    required this.familyName,
    required this.mobile,
    required this.profession,
    required this.city,
    required this.workplace,
    required this.saudiCouncilNumber,
    required this.selectedTopic,
    required this.eventId,
  });
}

class RegisterUseCase {
  final AuthRepository _repository;
  const RegisterUseCase(this._repository);

  Future<Result<UserEntity>> call(RegisterParams p) => _repository.signUp(
        email: p.email,
        password: p.password,
        firstName: p.firstName,
        familyName: p.familyName,
        mobile: p.mobile,
        profession: p.profession,
        city: p.city,
        workplace: p.workplace,
        saudiCouncilNumber: p.saudiCouncilNumber,
        selectedTopic: p.selectedTopic,
        eventId: p.eventId,
      );
}
