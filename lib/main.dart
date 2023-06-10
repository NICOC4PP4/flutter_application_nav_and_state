import 'package:flutter/material.dart';
import './screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

enum Actions { Increment, Decrement }

int counterReducer(int state, dynamic action) {
  if (action == Actions.Increment) {
    return state + 1;
  } else if (action == Actions.Decrement) {
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
    return StoreProvider(
      store: store,
      child: MaterialApp(
        onGenerateRoute: (settings) {
          if (settings.name == '/profile') {
            return MaterialPageRoute(builder: (context) {
              return const ProfileScreen();
            });
          } else if (settings.name == '/home') {
            return MaterialPageRoute(builder: (context) {
              return const HomeScreen();
            });
          }
          return null;
        },
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Home Screen'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StoreConnector<int, String>(
                converter: (store) => store.state.toString(),
                builder: (context, count) {
                  return Text(
                    count,
                    style: const TextStyle(fontSize: 24),
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  store.dispatch(Actions.Increment);
                },
                child: const Text('Increment'),
              ),
              ElevatedButton(
                onPressed: () {
                  store.dispatch(Actions.Decrement);
                },
                child: const Text('Decrement'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                },
                child: const Text('Go to Profile Screen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
