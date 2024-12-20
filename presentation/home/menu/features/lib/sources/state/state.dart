part of '../../eb_menu_feature.dart';

final class MenuState extends Equatable {
  final ChangePasswordState changePasswordState;
  final NotificationStatus notificationStatus;
  final MenuViewStatus menuViewStatus;

  const MenuState({
    this.changePasswordState = const ChangePasswordState(),
    this.notificationStatus = NotificationStatus.disabled,
    this.menuViewStatus = const MenuViewStatus(),
  });

  MenuState copyWith({
    ChangePasswordState? changePasswordState,
    NotificationStatus? notificationStatus,
    MenuViewStatus? menuViewStatus,
  }) {
    return MenuState(
      changePasswordState: changePasswordState ?? this.changePasswordState,
      notificationStatus: notificationStatus ?? this.notificationStatus,
      menuViewStatus: menuViewStatus ?? this.menuViewStatus,
    );
  }

  @override
  List<Object?> get props => [
        changePasswordState,
        notificationStatus,
        menuViewStatus,
      ];
}
