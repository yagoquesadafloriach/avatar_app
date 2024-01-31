// ignore_for_file: lines_longer_than_80_chars

import 'package:avatars_app/avatar_generator/prediction/cubit/prediction_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageGenerated extends StatelessWidget {
  const ImageGenerated({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PredictionCubit, PredictionState>(
      buildWhen: (previous, current) => previous.image != current.image,
      builder: (context, state) {
        final image = state.image;

        if (image.isEmpty || image == '') {
          return Expanded(
            child: Center(
              child: Text(
                'Error!!!',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
          );
        }

        return Expanded(
          child: Center(
            child: Image.network(
              image,
              frameBuilder: (
                context,
                child,
                frame,
                wasSynchronouslyLoaded,
              ) =>
                  Padding(
                padding: const EdgeInsets.all(8),
                child: child,
              ),
              errorBuilder: (
                context,
                exception,
                stackTrace,
              ) =>
                  Text(
                'Error!!!',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              loadingBuilder: (
                context,
                child,
                loadingProgress,
              ) {
                if (loadingProgress == null) {
                  return child;
                }

                return CircularProgressIndicator(
                  value: loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!.toDouble(),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
