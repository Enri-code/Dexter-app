import 'package:flutter/material.dart';
import 'package:dexter_test/core/utils/custom_loader.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key? key,
    this.imageUrl,
    this.size = 48,
    this.decoration,
  }) : super(key: key);

  final double? size;
  final String? imageUrl;
  final BoxDecoration? decoration;

  Widget errorBuilder(_, __, ___) => Padding(
        padding: const EdgeInsets.all(8),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Icon(Icons.person, color: Colors.grey[600]),
        ),
      );

  Widget frameBuilder(_, img, val, ___) {
    return val == null ? CustomLoader.widget() : img;
  }

  @override
  Widget build(BuildContext context) {
    String value = imageUrl ?? '';
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.hardEdge,
      decoration: decoration ??
          BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black),
          ),
      child: Image.network(
        value,
        fit: BoxFit.cover,
        errorBuilder: errorBuilder,
        frameBuilder: frameBuilder,
      ),
    );
  }
}
