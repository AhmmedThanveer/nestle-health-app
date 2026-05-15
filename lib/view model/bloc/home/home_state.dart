import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final bool isLoaded;

  const HomeState({this.isLoaded = false});

  HomeState copyWith({bool? isLoaded}) =>
      HomeState(isLoaded: isLoaded ?? this.isLoaded);

  @override
  List<Object?> get props => [isLoaded];
}
