import 'package:flutter/material.dart';
import 'package:ninety/constants/constants.dart';
import 'package:video_player/video_player.dart';

import '../models/intrusion.dart';

class IntrusionDetails extends StatefulWidget {
  final Intrusion intrusion;
  const IntrusionDetails({super.key, required this.intrusion});

  @override
  State<IntrusionDetails> createState() => _IntrusionDetailsState();
}

class _IntrusionDetailsState extends State<IntrusionDetails> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
      widget.intrusion.intrusionVideo != null
          ? widget.intrusion.intrusionVideo!.videoLink
          : "",
    );

    _initializeVideoPlayerFuture = _controller.initialize().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainPurple,
        title: const Text("Intrusion Details"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
            top: 20,
            left: PADDING_LEFT,
            right: PADDING_RIGHT,
          ),
          child: Column(
            children: [
              widget.intrusion.intrusionVideo != null
                  ? FutureBuilder(
                      future: _initializeVideoPlayerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          // If the VideoPlayerController has finished initialization, use
                          // the data it provides to limit the aspect ratio of the video.

                          return Column(
                            children: [
                              AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                // Use the VideoPlayer widget to display the video.
                                child: VideoPlayer(_controller),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Center(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: Color(0xfffF50057),
                                      minimumSize: const Size(100, 50),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                    ),
                                    child: Icon(
                                      _controller.value.isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _controller.value.isPlaying
                                            ? _controller.pause()
                                            : _controller.play();
                                      });
                                    }),
                              ),
                            ],
                          );
                        } else {
                          // If the VideoPlayerController is still initializing, show a
                          // loading spinner.
                          return Center(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: CircularProgressIndicator(
                                color: mainPurple,
                              ),
                            ),
                          );
                        }
                      },
                    )
                  : const Text(
                      "No any video found",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      ),
                    ),
              const SizedBox(
                height: 5,
              ),
              const SizedBox(
                height: 10,
              ),
              ...widget.intrusion.intrusionImages
                  .map(
                    (item) => Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Image.network(
                        item.link.isNotEmpty
                            ? item.link
                            : "https://ninetycamera.blob.core.windows.net/intrusion-images/broken-image.png",
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
