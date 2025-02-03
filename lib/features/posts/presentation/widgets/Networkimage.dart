import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Networkimages extends StatelessWidget {
  const Networkimages({super.key, required this.imageUrl, required this.size});
  final String imageUrl;
  final double size;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size,
      backgroundColor: Colors.white,
      child: CachedNetworkImage(
        imageUrl: imageUrl, // رابط الصورة
        imageBuilder: (context, imageProvider) => CircleAvatar(
          radius: size,
          backgroundImage: imageProvider, // الصورة المحمّلة
        ),
        placeholder: (context, url) => CircleAvatar(
          radius: size,
          backgroundImage:
              AssetImage('assets/images/avatar.jpg'), // صورة أثناء التحميل
        ),
        errorWidget: (context, url, error) => CircleAvatar(
          radius: size,
          backgroundImage:
              AssetImage('assets/images/avatar.jpg'), // صورة في حال الخطأ
        ),
      ),
    );
  }
}
