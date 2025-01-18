import 'package:flutter/material.dart';
import 'package:front/presentation/constants/texts.dart';

class FutureLoader<T> extends StatelessWidget {
  final Future<T> future; 
  final Widget Function(T) builder;
  const FutureLoader({super.key, required this.future, required this.builder});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              children: [
                const Text(Texts.errorMessage),
                Text('Error: ${snapshot.error}')
              ],
            ),
          );
        } else if (snapshot.hasData) {
          return builder(snapshot.data as T);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}