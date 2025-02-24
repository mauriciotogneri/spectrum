import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/utils/palette.dart';

class Project implements Dropdownable {
  final String id;
  final String name;
  final String description;
  final List<String> components;
  final List<String> platforms;
  final List<String> environments;
  final List<String> devices;
  final List<String> versions;

  const Project({
    required this.id,
    required this.name,
    required this.description,
    required this.components,
    required this.platforms,
    required this.environments,
    required this.devices,
    required this.versions,
  });

  @override
  String toString() => name;

  @override
  Widget get dropdownItem => Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      CachedNetworkImage(
        imageUrl:
            'https://cdn.jsdelivr.net/gh/alohe/avatars/png/vibrent_${Random().nextInt(26) + 1}.png',
        placeholder:
            (context, url) => const CircleAvatar(
              backgroundColor: Palette.backgroundEmpty,
              radius: 12,
            ),
        imageBuilder:
            (context, image) =>
                CircleAvatar(backgroundImage: image, radius: 12),
      ),
      const HBox(8),
      Text(toString()),
    ],
  );
}
