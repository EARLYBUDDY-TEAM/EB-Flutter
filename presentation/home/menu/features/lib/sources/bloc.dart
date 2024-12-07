part of '../eb_menu_feature.dart';

final class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(const MenuState()) {
    on<PressLogoutButton>(_onPressLogoutButton);
  }
}

extension on MenuBloc {
  void _onPressLogoutButton(
    PressLogoutButton event,
    Emitter<MenuState> emit,
  ) {
    log('PressLogoutButton');
  }
}
