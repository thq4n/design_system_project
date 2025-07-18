import 'package:flutter/material.dart';

import '../extensions/extensions.dart';
import '../theme/ds_theme.dart';

class InputTitleWidget extends StatelessWidget {
  const InputTitleWidget({
    super.key,
    required this.title,
    this.required = true,
    this.style,
  });

  final String? title;
  final bool required;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Text.rich(
      TextSpan(
        text: title,
        style: style ?? textTheme.sm?.regular,
        children: [
          if (required)
            TextSpan(
              text: ' *',
              style: textTheme.sm?.regular,
            ),
        ],
      ),
    );
  }
}
