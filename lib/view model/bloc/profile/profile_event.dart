import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object?> get props => [];
}

class LoadProfileEvent extends ProfileEvent {
  final String uid;
  const LoadProfileEvent(this.uid);
  @override
  List<Object?> get props => [uid];
}

class UpdateProfileEvent extends ProfileEvent {
  final String uid;
  final String firstName;
  final String familyName;
  final String mobile;
  final String profession;
  final String city;
  final String workplace;
  final String saudiCouncilNumber;
  final String? selectedTopic;

  const UpdateProfileEvent({
    required this.uid,
    required this.firstName,
    required this.familyName,
    required this.mobile,
    required this.profession,
    required this.city,
    required this.workplace,
    required this.saudiCouncilNumber,
    this.selectedTopic,
  });

  @override
  List<Object?> get props => [
        uid,
        firstName,
        familyName,
        mobile,
        profession,
        city,
        workplace,
        saudiCouncilNumber,
        selectedTopic,
      ];
}

class SignOutProfileEvent extends ProfileEvent {}
