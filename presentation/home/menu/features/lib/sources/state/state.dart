part of '../../eb_menu_feature.dart';

final class MenuState extends Equatable {
  final ChangePasswordState changePasswordState;
  final bool isNotification;
  final MenuViewStatus menuViewStatus;

  const MenuState({
    this.changePasswordState = const ChangePasswordState(),
    this.isNotification = false,
    this.menuViewStatus = const MenuViewStatus(),
  });

  MenuState copyWith({
    ChangePasswordState? changePasswordState,
    bool? isNotification,
    MenuViewStatus? menuViewStatus,
  }) {
    return MenuState(
      changePasswordState: changePasswordState ?? this.changePasswordState,
      isNotification: isNotification ?? this.isNotification,
      menuViewStatus: menuViewStatus ?? this.menuViewStatus,
    );
  }

  @override
  List<Object?> get props => [
        changePasswordState,
        isNotification,
        menuViewStatus,
      ];
}

final class MenuViewStatus extends Equatable {
  final BaseStatus changePasswordStatus;
  final BaseStatus removeUserStatus;

  const MenuViewStatus({
    this.changePasswordStatus = BaseStatus.init,
    this.removeUserStatus = BaseStatus.init,
  });

  MenuViewStatus copyWith({
    BaseStatus? changePasswordStatus,
    BaseStatus? removeUserStatus,
  }) {
    return MenuViewStatus(
      changePasswordStatus: changePasswordStatus ?? this.changePasswordStatus,
      removeUserStatus: removeUserStatus ?? this.removeUserStatus,
    );
  }

  @override
  List<Object?> get props => [
        changePasswordStatus,
        removeUserStatus,
      ];
}
