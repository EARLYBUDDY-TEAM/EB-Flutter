part of '../eb_menu_feature.dart';

sealed class MenuEvent extends Equatable {}

final class PressLogoutButton extends MenuEvent {
  @override
  List<Object?> get props => [];
}
