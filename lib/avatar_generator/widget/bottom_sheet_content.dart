// ignore_for_file: lines_longer_than_80_chars

import 'package:avatars_app/avatar_generator/prediction/cubit/prediction_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomSheetContent extends StatefulWidget {
  const BottomSheetContent({required this.isAvatarGenerator, this.image = '', super.key});

  final bool isAvatarGenerator;
  final String image;

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  @override
  Widget build(BuildContext context) {
    final predictionCubit = context.read<PredictionCubit>();

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Astronaut'),
            leading: const Text(
              '🚀',
              style: TextStyle(fontSize: 25),
            ),
            onTap: () {
              if (widget.isAvatarGenerator) {
                predictionCubit.createAvatarPrediction(
                  prompt: 'face of TOK as an astronaut, serious expresion, looking at the camera',
                  image: 'https://cdn.kqed.org/wp-content/uploads/sites/10/2019/07/neil-armstrong.jpg',
                );
              } else {
                predictionCubit.createImagePrediction(
                  prompt: 'A photo of man img, as an astronaut, wearing a spacesuit, serious expresion, looking at the camera',
                  image: widget.image,
                  style: 'Cinematic',
                );
              }

              Navigator.pop(context);
              setState(() {});
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Gladiator'),
            leading: const Text(
              '🛡️',
              style: TextStyle(fontSize: 25),
            ),
            onTap: () {
              if (widget.isAvatarGenerator) {
                predictionCubit.createAvatarPrediction(
                  prompt: 'face of TOK as a galdiator, shouting, angry expression',
                  image: 'https://album.mediaset.es/eimg/2022/08/23/russell-crowe_5bfc.jpg?w=1200&h=900',
                );
              } else {
                predictionCubit.createImagePrediction(
                  prompt: 'A photo of man img, as a galdiator, shouting, angry expression',
                  image: widget.image,
                  style: 'Cinematic',
                );
              }

              Navigator.pop(context);
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
