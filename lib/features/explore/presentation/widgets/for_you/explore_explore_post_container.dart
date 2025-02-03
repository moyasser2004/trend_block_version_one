import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../data/models/local/explor_explore_post_container_model.dart';

class ExploreExplorePostContainer extends StatelessWidget {
  const ExploreExplorePostContainer({Key? key, required this.model}) : super(key: key);

  final ExplorExplorePostContainerModel model;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 5, // Keeps consistent image ratio
      child: CachedNetworkImage(
        imageUrl: model.imgUrl , // Request high-quality image
        fit: BoxFit.fill, // Prevents stretching
        errorWidget: (context, url, error) => const Icon(Icons.error, size: 40),
      ),
    );
  }
}
