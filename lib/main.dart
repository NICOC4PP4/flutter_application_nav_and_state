import 'package:flutter/material.dart';
import './screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

enum Actions { Increment, Decrement }

int counterReducer(int state, dynamic action) {
  if (action is IncrementAction) {
    return state + 1;
  } else if (action is DecrementAction) {
    return state - 1;
  }
  return state;
}

void main() {
  final store = Store<int>(counterReducer, initialState: 0);

  runApp(StoreProvider<int>(
    store: store,
    child: MainApp(store: store),
  ));
}

class MainApp extends StatelessWidget {
  final Store<int> store;

  const MainApp({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Navigator(
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (context) => HomeScreen());
            case '/profile':
              return MaterialPageRoute(builder: (context) => ProfileScreen());
            default:
              return null;
          }
        },
        initialRoute: '/home',
      ),
    );
  }
}

class IncrementAction {
  IncrementAction();
}

class DecrementAction {
  DecrementAction();
}
