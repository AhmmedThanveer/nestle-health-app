import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class RegisterButtonPressedEvent extends RegisterEvent {
  final String firstName;
  final String familyName;
  final String email;
  final String mobile;
  final String password;
  final String profession;
  final String topic;
  final String city;
  final String saudiCouncil;
  final String placeOfWork;

  const RegisterButtonPressedEvent({
    required this.firstName,
    required this.familyName,
    required this.email,
    required this.mobile,
    required this.password,
    required this.profession,
    required this.topic,
    required this.city,
    required this.saudiCouncil,
    required this.placeOfWork,
  });

  @override
  List<Object?> get props => [
        firstName,
        familyName,
        email,
        mobile,
        password,
        profession,
        topic,
        city,
        saudiCouncil,
        placeOfWork,
      ];
}
