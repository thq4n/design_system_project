import 'package:flutter/material.dart';

import '../../base/ds_base.dart';
import '../../constants/constants.dart';
import '../../extensions/extensions.dart';
import '../../gen/assets.gen.dart';
import '../../theme/ds_theme.dart';
import '../ds_components.dart';

class DSAvatar extends _DSAvatar {
  DSAvatar.default_({
    super.key,
    super.type = DSAvaterTypes.defaultType,
    required super.source,
    required super.size,
    super.isMale,
  }) : super(placeholder: DSAssets.avatar.icDefault);

  DSAvatar.text({
    super.key,
    super.type = DSAvaterTypes.textType,
    required super.source,
    required super.size,
    super.isMale,
  }) : super(placeholder: DSAssets.avatar.icDefault);

  DSAvatar.logoWhite({
    super.key,
    super.type = DSAvaterTypes.logoWhiteType,
    required super.source,
    required super.size,
    super.isMale,
  }) : super(placeholder: DSAssets.avatar.icLogoWhite);

  DSAvatar.logoRed({
    super.key,
    super.type = DSAvaterTypes.logoRedType,
    required super.source,
    required super.size,
    super.isMale,
  }) : super(placeholder: DSAssets.avatar.icLogoRed);

  DSAvatar.gender({
    super.key,
    super.type = DSAvaterTypes.genderType,
    required super.source,
    required super.size,
    super.isMale,
  }) : super(
          placeholder: isMale != null
              ? (isMale ? DSAssets.avatar.icMale : DSAssets.avatar.icFemale)
              : DSAssets.avatar.icDefault,
        );
}

class _DSAvatar extends StatefulWidget {
  final String source;
  final DSAvatarSizes size;
  final bool? isMale;
  final String? placeholder;
  final DSAvaterTypes type;

  const _DSAvatar({
    super.key,
    required this.source,
    required this.size,
    this.isMale,
    this.placeholder,
    required this.type,
  });

  @override
  State<_DSAvatar> createState() => _DSAvatarState();
}

class _DSAvatarState extends DSStateBase<_DSAvatar> {
  DSAvatarTheme get componentTheme => theme
      .extension<DSAvatarThemeExtension>()!
      .getDSAvatarThemeByType(widget.type, widget.size);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.value,
      height: widget.size.value,
      decoration: componentTheme.decoration,
      padding: componentTheme.padding,
      child: _buildChild(),
    );
  }

  Widget _buildChild() {
    // Text avatar
    if (widget.type == DSAvaterTypes.textType && widget.source.isNotEmpty) {
      return Center(
        child: Text(
          widget.source.getInitials,
          style: componentTheme.textStyle,
          textAlign: TextAlign.center,
        ),
      );
    }

    // Default, logo, or gender avatar (all use image)
    return ClipOval(
      child: FittedBox(
        child: DSImageView(
          source: widget.source,
          placeHolder: widget.placeholder,
          width: widget.size.value,
          height: widget.size.value,
        ),
      ),
    );
  }
}
