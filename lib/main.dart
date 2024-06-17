import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends HookConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // keyboard_actions pluginの_kBarSizeを参照
    // https://github.com/diegoveloper/flutter_keyboard_actions/blob/master/lib/keyboard_actions.dart#L15
    const defaultKeyboardActionsHeight = 45.0;
    final focusNode = useFocusNode();
    final isShowKeyboardActions = useState(false);

    useEffect(() {
      focusNode.addListener(() {
        isShowKeyboardActions.value = focusNode.hasFocus;
      });
      return null;
    }, []);

    return GestureDetector(
      onTap: () => focusNode.unfocus(),
      child: Column(
        children: [
          Expanded(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: Text(title),
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        KeyboardActions(
                          autoScroll: false,
                          config: buildConfig(context, focusNode),
                          child: TextField(
                            focusNode: focusNode,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  focusNode.requestFocus();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('メッセージ'),
                      duration: Duration(seconds: 100),
                    ),
                  );
                },
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
            ),
          ),
          if (isShowKeyboardActions.value)
            Container(
              height: defaultKeyboardActionsHeight,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
        ],
      ),
    );
  }

  KeyboardActionsConfig buildConfig(
    BuildContext context,
    FocusNode focusNode,
  ) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      nextFocus: false,
      actions: [
        KeyboardActionsItem(
          focusNode: focusNode,
          toolbarButtons: [
            (node) {
              return GestureDetector(
                onTap: () => node.unfocus(),
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 12,
                    bottom: 12,
                    right: 18,
                  ),
                  child: const Text('完了'),
                ),
              );
            }
          ],
        ),
      ],
    );
  }
}
