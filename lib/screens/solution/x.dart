import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectresearch/blocs/floating_button/floating_button_bloc.dart';

class X extends StatefulWidget {
  const X({super.key});

  @override
  State<X> createState() => _XState();
}

class _XState extends State<X> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FloatingButtonBloc, FloatingButtonState>(
        builder: (context, state) {
          if (state is TopicButtonState) {
            return Center(
              child: Text('${state.countNumber}'),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
