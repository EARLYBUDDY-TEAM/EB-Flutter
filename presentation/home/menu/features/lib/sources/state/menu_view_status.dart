part of '../../eb_menu_feature.dart';

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
