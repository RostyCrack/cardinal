import 'package:equatable/equatable.dart';

abstract class NavigationState extends Equatable {
  final int index;
  final String? school;
  final String? accountType;

  const NavigationState({required this.index, this.school, this.accountType});

  @override
  List<Object?> get props => [index, school, accountType];
}

class NavigationInitialState extends NavigationState {
  const NavigationInitialState({String? school, String? accountType})
      : super(index: 0, school: school, accountType: accountType);
}

class Home extends NavigationState {
  const Home({required int index, String? school, String? accountType})
      : super(index: index, school: school, accountType: accountType);
}

class Notifications extends NavigationState {
  const Notifications({required int index})
      : super(index: index);
}

class Settings extends NavigationState {
  const Settings({required int index})
      : super(index: index);
}