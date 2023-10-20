import 'package:flutter/material.dart';

import '/core/constant/styles.dart';

class CustomCard extends StatelessWidget {
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final Widget child;
  final bool hasOutline;
  final void Function()? onTap;

  const CustomCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.hasOutline = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: borderRadius ?? borderRadiusDefault,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: borderRadius ?? borderRadiusDefault,
          border: !hasOutline
              ? null
              : Border.all(
                  color: colorScheme.outline.withOpacity(0.5),
                ),
        ),
        padding: padding ?? const EdgeInsets.all(paddingDefault),
        child: child,
      ),
    );
  }
}
