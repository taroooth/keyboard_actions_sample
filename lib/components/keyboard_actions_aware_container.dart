import 'package:flutter/material.dart';

///
/// SnackBarなどが表示された際に、KeyboardActionsで隠れないようにするためのコンテナ
/// 下部にKeyboardActionsの高さ分の余白を持つ
///
class KeyboardActionsAwareContainer extends StatelessWidget {
  const KeyboardActionsAwareContainer({
    super.key,
    required this.isShowKeyboardActions,
    required this.child,
  });

  final bool isShowKeyboardActions;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // keyboard_actions pluginの_kBarSizeを参照
    // https://github.com/diegoveloper/flutter_keyboard_actions/blob/master/lib/keyboard_actions.dart#L15
    const defaultKeyboardActionsHeight = 45.0;

    return Column(
      children: [
        Expanded(
          child: child,
        ),
        if (isShowKeyboardActions)
          Container(
            height: defaultKeyboardActionsHeight,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
      ],
    );
  }
}