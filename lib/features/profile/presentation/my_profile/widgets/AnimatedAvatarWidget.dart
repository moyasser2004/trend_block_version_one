import 'package:flutter/material.dart';
import 'package:trend/features/posts/presentation/widgets/Networkimage.dart';

class AnimatedAvatarWidget extends StatelessWidget {
  final bool isVisible;
  final String avatarUrl;

  const AnimatedAvatarWidget({
    Key? key,
    required this.isVisible,
    required this.avatarUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Positioned.fill(
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(child: Container()),
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: 100),
                  duration: Duration(milliseconds: 70),
                  builder: (context, size, child) {
                    return Networkimages(
                      imageUrl: avatarUrl.startsWith('http')
                          ? avatarUrl
                          : 'http://167.71.92.176$avatarUrl',
                      size: size,
                    );
                  },
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
