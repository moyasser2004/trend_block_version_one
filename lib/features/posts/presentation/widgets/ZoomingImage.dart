import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ZoomingImage extends StatefulWidget {
  const ZoomingImage({Key? key, required this.image}) : super(key: key);
  final String image;
  @override
  State<ZoomingImage> createState() => _ZoomingImageState();
}

class _ZoomingImageState extends State<ZoomingImage>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  double minScale = 1.0;
  double maxScale = 4.0;
  OverlayEntry? entry;
  late TransformationController controller;
  late AnimationController animationcontroller;
  late Animation<Matrix4> animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // animation = Animation();
    controller = TransformationController();
    animationcontroller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200))
          ..addListener(() => controller.value = animation.value)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              removeoverlay();
            }
          });
  }

  void removeoverlay() {
    entry?.remove();
    entry = null;
  }

  void dispose() {
    controller.dispose();
    animationcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: buildimage());
  }

  Widget buildimage() {
    return Builder(
      builder: (context) => InteractiveViewer(
        clipBehavior: Clip.none,
        minScale: minScale, // أقل تكبير (لن تقل الصورة عن حجمها الأصلي)
        maxScale: maxScale, // أكبر تكبير (يمكنك زيادته حسب الحاجة)
        panEnabled: false, // السماح بالحركة
        // boundaryMargin: EdgeInsets.all(0), // المسافة حول الصورة
        transformationController: controller,
        onInteractionEnd: (details) {
          resetanimation();
        },
        onInteractionStart: (details) {
          if (details.pointerCount < 2) return;

          showOverlay(context);
        },
        child: Transform.scale(
            scale: _scale, // تطبيق مقياس الصورة هنا
            child: CachedNetworkImage(
              imageUrl: widget.image, // رابط الصورة
              // imageBuilder: (context, imageProvider) =>
              //     Image.asset('assets/images/avatar.jpg'), // الصورة المحمّلة

              placeholder: (context, url) =>
                  Image.asset('assets/images/avatar.jpg'), // صورة أثناء التحميل

              errorWidget: (context, url, error) =>
                  Image.asset('assets/images/avatar.jpg'), // صورة في حال الخطأ
            )),
      ),
    );
  }

  void showOverlay(BuildContext context) {
    final renderBox = context.findRenderObject()! as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    entry = OverlayEntry(builder: (context) {
      return Positioned(
          left: offset.dx,
          top: offset.dy,
          width: MediaQuery.sizeOf(context).width,
          child: buildimage());
    });
    final overlay = Overlay.of(context);
    overlay.insert(entry!);
  }

  void resetanimation() {
    animation = Matrix4Tween(begin: controller.value, end: Matrix4.identity())
        .animate(CurvedAnimation(
            parent: animationcontroller, curve: Curves.bounceIn));
    animationcontroller.forward(from: 0);
  }
}
