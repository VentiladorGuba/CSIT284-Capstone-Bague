import 'dart:io';

import 'package:flutter/material.dart';
import 'package:capstone_bague/models/item.dart';


class ItemImage extends StatelessWidget{
  final Item item;
  final double? width;
  final double height;
  final double iconSize;
  final double radius;

  const ItemImage({
    super.key,
    required this.item,
    required this.height,
    this.width,
    this.iconSize=28,
    this.radius=12,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final scheme = Theme.of(context).colorScheme;

    final placeholder = Container(
      color: scheme.secondaryContainer,
      alignment:  Alignment.center,
      child: Icon(
        item.category.icon,
        size: iconSize,
        color: scheme.onSecondaryContainer,
      ),
    );

    final path = item.imagePath;

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox(
        width: width,
        height: height,
        child: path == null
            ? placeholder
            : Image.file(
                File(path),
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => placeholder,
              ),
      ),
    );
  }
}