import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(BlocProvider(
    create: (context) {
      return CounterBloc();
    },
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              IconButton(
                onPressed: () => context
                    .read<CounterBloc>()
                    .add(ChangeCounterEvent(by: 2)),
                icon: const Icon(Icons.add),
              ),
              BlocBuilder<CounterBloc, int>(builder: (
                  context,
                  counter,
                  ) {
                return Text('Current Value: $counter');
              }),
              IconButton(
                onPressed: () => context
                    .read<CounterBloc>()
                    .add(ChangeCounterEvent(by: -2)),
                icon: const Icon(Icons.remove),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

sealed class CounterEvent {}

class IncrementCounterEvent extends CounterEvent {}

class DecrementCounterEvent extends CounterEvent {}

class ChangeCounterEvent extends CounterEvent {
  ChangeCounterEvent({required this.by});

  final int by;
}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<IncrementCounterEvent>((event, emit) => emit(state + 1));
    on<DecrementCounterEvent>((event, emit) => emit(state - 1));
    on<ChangeCounterEvent>((event, emit) => emit(state + event.by));
  }
}
