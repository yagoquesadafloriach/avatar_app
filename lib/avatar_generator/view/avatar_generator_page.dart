// ignore_for_file: lines_longer_than_80_chars

import 'package:avatars_app/avatar_generator/prediction/cubit/prediction_cubit.dart';
import 'package:avatars_app/avatar_generator/training/cubit/training_cubit.dart';
import 'package:avatars_app/avatar_generator/widget/bottom_sheet_content.dart';
import 'package:avatars_app/avatar_generator/widget/image_generated.dart';
import 'package:avatars_app/common/enums/form_status.dart';
import 'package:avatars_app/common/utils/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvatarGeneratorPage extends StatefulWidget {
  const AvatarGeneratorPage({super.key});

  @override
  State<AvatarGeneratorPage> createState() => _AvatarGeneratorPageState();
}

class _AvatarGeneratorPageState extends State<AvatarGeneratorPage> {
  @override
  Widget build(BuildContext context) {
    final trainingCubit = context.read<TrainingCubit>();

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 30,
        horizontal: 5,
      ),
      child: Column(
        children: [
          BlocBuilder<TrainingCubit, TrainingState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: state.status.isLoading ? null : trainingCubit.createTraining,
                child: switch (state.status) {
                  FormStatus.error => const Text('ERROR!!!'),
                  FormStatus.loading => const Text('Loading...'),
                  _ => const Text('Create Training 💪🏼'),
                },
              );
            },
          ),
          const SizedBox(height: 15),
          BlocBuilder<PredictionCubit, PredictionState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: state.status.isLoading
                    ? null
                    : () => showModalBottomSheet<BottomSheetContent>(
                          context: context,
                          builder: (context) => const BottomSheetContent(
                            isAvatarGenerator: true,
                          ),
                        ),
                child: switch (state.status) {
                  FormStatus.loading => const Text('Loading...'),
                  _ => const Text('Create Avatar 🦸🏻‍♂️'),
                },
              );
            },
          ),
          const SizedBox(height: 15),
          BlocBuilder<PredictionCubit, PredictionState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: state.status.isLoading
                    ? null
                    : () async {
                        final imageFile = await ImageUtils.pickSingleImage();
                        if (imageFile != null) {
                          if (context.mounted) {
                            await showModalBottomSheet<BottomSheetContent>(
                              context: context,
                              builder: (context) => const BottomSheetContent(
                                isAvatarGenerator: false,
                                image:
                                    'https://scontent.fbcn13-1.fna.fbcdn.net/v/t1.6435-9/89829217_3171750786192273_5436620271005990912_n.jpg?stp=cp0_dst-jpg_e15_q65_s640x640&_nc_cat=102&ccb=1-7&_nc_sid=512d91&_nc_ohc=bvwjesN1R9YAX8c2Nog&_nc_ht=scontent.fbcn13-1.fna&oh=00_AfD1V93tJa8ek52v3sqKSfPiJU8TkLD7OeUj8n-JQ3crYg&oe=65DF36D7',
                              ),
                            );
                          }
                        }
                      },
                child: switch (state.status) {
                  FormStatus.loading => const Text('Loading...'),
                  _ => const Text('Generate Image 🖼️'),
                },
              );
            },
          ),
          const ImageGenerated(),
        ],
      ),
    );
  }
}
