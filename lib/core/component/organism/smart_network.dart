import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shamo_mobile/core/core.dart';

class SmartNetworkImage extends StatelessWidget {
  const SmartNetworkImage(
    this.url, {
    Key? key,
    this.width,
    this.height,
    this.fit,
    this.radius,
    this.withCache,
    this.address,
  }) : super(key: key);

  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final BorderRadius? radius;
  final bool? withCache;
  final String? address;

  ImageProvider get _provider =>
      (withCache == true ? CachedNetworkImageProvider(url) : NetworkImage(url))
          as ImageProvider<Object>;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radius ?? BorderRadius.zero,
      child: FadeInImage(
        image: _provider,
        width: width,
        height: height,
        fit: fit,
        placeholderFit: BoxFit.cover,
        placeholder: const AssetImage(
          MainAssets.image,
        ),
        imageErrorBuilder: (context, _, __) {
          return SkeletonAnimation(
            width: width,
            height: height,
            borderRadius: radius ?? BorderRadius.zero,
          );
        },
      ),
    );
  }
}
