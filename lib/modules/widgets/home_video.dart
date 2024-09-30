import 'package:flutter/material.dart';
import 'package:ghena_alshaam/modules/widgets/logo.dart';
import 'package:video_player/video_player.dart';

class HomeVideo extends StatefulWidget {
  const HomeVideo({Key? key}) : super(key: key);

  @override
  State<HomeVideo> createState() => _HomeVideoState();
}

class _HomeVideoState extends State<HomeVideo> {
  late VideoPlayerController _videoPlayerController;

  double? screenWidth;
  double? screenHeight;
  double? videoHeight;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoPlayerController =
        VideoPlayerController.asset("assets/videos/home_video2.mp4");
    _videoPlayerController.initialize().then((_) {
      setState(() {
        _videoPlayerController.setLooping(true);
        _videoPlayerController.setVolume(3);
        _videoPlayerController.play();
      });
    });
  }

  @override
  void dispose() {
    _videoPlayerController.pause();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    videoHeight = screenHeight! * 0.75;

    return Stack(
      children: <Widget>[
        SizedBox(
          width: screenWidth,
          height: videoHeight,
          child: (_videoPlayerController.value.isInitialized)
              ? AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController),
                )
              : Container(),
        ),
        const Logo(),
      ],
    );
  }
}
