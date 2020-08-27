import 'package:flutter_bloc/flutter_bloc.dart';

enum CounterEvent { increment, decrement, reset }

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0);

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.decrement:
        yield state - 1;
        break;
      case CounterEvent.increment:
        yield state + 1;
        break;
      case CounterEvent.reset:
        yield 0;
        break;
      default:
        addError(Exception('unsupported event'));
    }
  }
}
