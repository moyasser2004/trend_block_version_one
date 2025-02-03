import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trend/shared/widget/shimmer_container.dart';

class CustomerCachedNetworkImage extends StatelessWidget {
  const CustomerCachedNetworkImage({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          const CustomerShimmerContainer(),
      errorWidget: (context, url, error) => const Center(
          child: Icon(
        Icons.error,
        color: Colors.red,
      )),
    );
  }
}
