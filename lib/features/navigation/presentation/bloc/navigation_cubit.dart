import 'package:flutter_bloc/flutter_bloc.dart';
import 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit({String? school, String? accountType})
      : super(NavigationInitialState(school: school, accountType: accountType));

  void navigateToHome({String? school, String? accountType}) {
    emit(Home(index: 0, school: school ?? state.school, accountType: accountType ?? state.accountType));
  }

  void navigateToNotifications() {
    emit(const Notifications(index: 1));
  }

  void navigateToSettings() {
    emit(const Settings(index: 2));
  }
}