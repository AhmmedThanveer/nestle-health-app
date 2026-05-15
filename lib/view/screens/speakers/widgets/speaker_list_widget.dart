import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/models/speaker_models.dart';
import '../../../../view%20model/bloc/speakers/speakers_state.dart';
import '../speaker_detail_screen.dart';
import 'speaker_list_tile_widget.dart';

/// Scrollable list of speakers for the current category.
class SpeakerListWidget extends StatelessWidget {
  final SpeakersState state;

  const SpeakerListWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final List<Speaker> speakers = state.speakers;
    final double bottomPad = 80.h + MediaQuery.of(context).padding.bottom;

    if (speakers.isEmpty) {
      return Center(
        child: Text(
          'No speakers in this category.',
          style: TextStyle(color: Colors.white60, fontSize: 14.sp),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.only(top: 8.h, bottom: bottomPad),
      itemCount: speakers.length,
      itemBuilder: (context, index) => SpeakerListTileWidget(
        speaker: speakers[index],
        isLast: index == speakers.length - 1,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SpeakerDetailScreen(speaker: speakers[index]),
          ),
        ),
      ),
    );
  }
}
