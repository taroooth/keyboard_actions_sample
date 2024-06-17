import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'keyboard_actions_visibility_notifier.g.dart';

@riverpod
class KeyboardActionsVisibilityNotifier extends _$KeyboardActionsVisibilityNotifier {
  @override
  bool build() {
    return false;
  }

  void setVisibility(bool isVisible) {
    state = isVisible;
  }
}