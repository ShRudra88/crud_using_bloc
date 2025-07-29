import 'package:crud_using_bloc/bloc/counter_bloc.dart' show CounterBloc;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {

   // final CounterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueAccent,
      title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have clicked the button this many times',
            ),
            BlocBuilder<CounterBloc, int>(
              builder: (context, counter) {
                return Text(
                  '$counter',
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=> const )
        );
      }),
    );
  }
}
