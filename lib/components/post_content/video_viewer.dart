import 'package:flutter/material.dart';
import '/components/post_content/video_player_screen.dart';

class VideoViewer extends StatelessWidget {
  final videoPath;
  const VideoViewer(this.videoPath);
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
        2.0,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 20.0, bottom: 20.0, left: 5.0, right: 5.0),
        child: VideoPlayerScreen( videoPath),
        
      ),
    );
  }
  }
