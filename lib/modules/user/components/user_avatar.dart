import 'dart:io';

import 'package:template/components/image_handler.dart';
import 'package:template/functions/percent_screen.dart';
import 'package:template/index.dart';
import 'package:template/utils/extensions.dart';

class UserAvatar extends StatelessWidget {
  /// size 30, iconSize 20
  const UserAvatar.small(this.photoUrl, {super.key})
      : size = largeIconSize,
        iconSize = extraSmallIconSize,
        localImage = null,
        isCurrent = false,
        shouldClear = false;

  /// size 50, iconSize 30
  const UserAvatar.medium(this.photoUrl, {super.key})
      : size = bigIconSize,
        iconSize = largeIconSize,
        localImage = null,
        isCurrent = false,
        shouldClear = false;

  /// size 40% width, iconSize 40
  UserAvatar.profile(
    this.photoUrl, {
    super.key,
    required this.isCurrent,
    required this.localImage,
    this.shouldClear = false,
  })  : size = percentWidth(40),
        iconSize = extraLargeSize;

  final String? photoUrl;
  final double size;
  final double iconSize;
  final String? localImage;
  final bool isCurrent;
  final bool shouldClear;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: t.tertiary,
        border: Border.all(
          color: t.primary,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      ),
      child: shouldClear
          ? _defaultIcon()
          : isCurrent && localImage.safeNotEmpty
              ? Image.file(
                  File(localImage!),
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _defaultIcon(),
                )
              : (photoUrl.safeNotEmpty
                  ? CachedNetworkImageComplete(imageUrl: photoUrl!, fit: BoxFit.cover)
                  : _defaultIcon()),
    );
  }

  Widget _defaultIcon() {
    return Icon(
      isCurrent ? Icons.photo : Icons.person,
      size: iconSize,
      color: t.onPrimary,
    );
  }
}
