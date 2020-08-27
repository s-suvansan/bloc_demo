import 'package:bloc_example/theme_cubit.dart';
import 'package:bloc_example/counter_bloc.dart';
import 'package:bloc_example/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onChange(Cubit cubit, Change change) {
    print(change);
    super.onChange(cubit, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(cubit, error, stackTrace);
  }
}

void main() {
  //Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (_, theme) {
          return MaterialApp(
            title: 'Bloc Demo',
            theme: theme,
            home: BlocProvider(
              create: (_) => CounterCubit(),
              child: MyHome(),
            ),
          );
        },
      ),
    );
  }
}

class MyHome extends StatelessWidget {
  final String title = "Bloc Demo";

  @override
  Widget build(BuildContext context) {
    //print("rebuild");
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Counter',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(
              height: 20.0,
            ),
            BlocBuilder<CounterCubit, int>(
              builder: (_, count) {
                return Text(
                  '$count',
                  style: Theme.of(context).textTheme.headline3,
                );
              },
            ),
            SizedBox(
              height: 100.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: FloatingActionButton(
                    child: const Icon(Icons.add),
                    //onPressed: () => context.bloc<CounterBloc>().add(CounterEvent.increment),
                    onPressed: () => context.bloc<CounterCubit>().increment(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: FloatingActionButton(
                    backgroundColor: Colors.red,
                    child: const Icon(Icons.clear),
                    //onPressed: () => context.bloc<CounterBloc>().add(CounterEvent.reset),
                    onPressed: () => context.bloc<CounterCubit>().reset(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: FloatingActionButton(
                    child: const Icon(Icons.remove),
                    //onPressed: () => context.bloc<CounterBloc>().add(CounterEvent.decrement),
                    onPressed: () => context.bloc<CounterCubit>().decrement(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: FloatingActionButton(
                child: const Icon(Icons.brightness_6),
                onPressed: () => context.bloc<ThemeCubit>().toggleTheme(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
