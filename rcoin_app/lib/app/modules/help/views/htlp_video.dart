import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:otc_app/app/modules/help/controllers/help_controller.dart';
import 'package:otc_app/common/widgets/toast.dart';
import 'package:otc_app/config.dart';
import 'package:video_player/video_player.dart';

class HelpVideoPage extends StatefulWidget {
  const HelpVideoPage();

  @override
  State<StatefulWidget> createState() {
    return HelpVideoPageState();
  }
}

class HelpVideoPageState extends State<HelpVideoPage> {
  late VideoPlayerController _controller;

  bool hideBtn = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse('https://91pay.s3.ap-south-1.amazonaws.com/91pay.mp4'),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    )..initialize().then((_) {
        setState(() {});
      });
    _controller.addListener(() async {
      HelpController.to.updateVideoPlayRefresh();
      Duration p = _controller.value.position;
      if (p.inMilliseconds != 0) {
        Toast.hideLoading();
      }
      Duration d = _controller.value.duration;
      if (p.inMilliseconds == d.inMilliseconds) {
        // 播放完毕
        _controller.seekTo(const Duration(milliseconds: 0));
        _controller.pause();
        setState(() {
          hideBtn = false;
        });
        return;
      }
      if (!hideBtn && _controller.value.isPlaying) {
        Future.delayed(const Duration(milliseconds: 1500)).then((value) {
          if (_controller.value.isPlaying) {
            setState(() {
              hideBtn = true;
            });
          }
        });
      }
    });

    Toast.showLoading(message: "loading");
    Future.delayed(const Duration(milliseconds: 1)).then((value) {
      if (_controller.value.isInitialized) {
        Toast.hideLoading();
      } else {
        Future.delayed(const Duration(milliseconds: 2)).then((value) {
          if (_controller.value.isInitialized) {
            Toast.hideLoading();
          } else {
            Future.delayed(const Duration(milliseconds: 2)).then((value) {
              Toast.hideLoading();
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.kTheme!.bgMain,
      body: Stack(
        children: [
          Positioned.fill(
              child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
          )),
          Positioned.fill(child: _operateView()),
          Positioned(
              left: 10,
              top: MediaQuery.of(context).padding.top,
              child: MaterialButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    alignment: Alignment.center,
                    // padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(24)),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 16,
                      color: Color(0xffffffff),
                    ),
                  ))),
          Positioned(left: 0, bottom: 30, child: _progressView())
        ],
      ),
    );
  }

  Widget _operateView() {
    return GetBuilder<HelpController>(
        id: HelpController.to.videoPlayRefreshId,
        builder: (context) {
          return GestureDetector(
              onTap: () {
                if (hideBtn) {
                  setState(() {
                    hideBtn = false;
                  });
                  return;
                }
                // 如果是播放状态 则立即播放
                if (_controller.value.isPlaying) {
                  setState(() {
                    _controller.pause();
                  });
                  return;
                }
                // 如果非播放状态，切准备就绪 则去启动播放
                if (_controller.value.isInitialized) {
                  setState(() {
                    _controller.play();
                  });
                } else {
                  Toast.showMessage('loading'.tr);
                }
              },
              child: !hideBtn
                  ? SizedBox(
                      width: Get.width,
                      height: Get.height,
                      child: Container(
                        alignment: Alignment.center,
                        // color: Colors.green,
                        child: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Container(
                      width: Get.width,
                      height: Get.height,
                      color: Colors.white.withOpacity(0),
                    ));
        });
  }

  Widget _progressView() {
    return GetBuilder<HelpController>(
        id: HelpController.to.videoPlayRefreshId,
        builder: (contxt) {
          int seconds = _controller.value.position.inSeconds;
          String ctime = seconds >= 60
              ? '01:${seconds % 60}'
              : seconds >= 10
                  ? '00:${seconds}'
                  : '00:0${seconds}';
          int secondsEnd = _controller.value.duration.inSeconds;
          String endtime = secondsEnd >= 60
              ? '01:${secondsEnd % 60}'
              : secondsEnd >= 10
                  ? '00:${secondsEnd}'
                  : '00:0${secondsEnd}';
          return Container(
            width: Get.width,
            // padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 70,
                  child: Text(
                    ctime,
                    textAlign: TextAlign.end,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  height: 3,
                  width: Get.width - 160,
                  child: LinearProgressIndicator(
                    value: secondsEnd == 0 ? 0 : seconds / secondsEnd,
                    backgroundColor: const Color.fromARGB(255, 206, 206, 206),
                    color: const Color.fromARGB(255, 113, 191, 255),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 70,
                  child: Text(
                    endtime,
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }
}
