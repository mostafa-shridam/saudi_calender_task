import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saudi_calender_task/core/theme/app_theme.dart';

class SocialButton extends ConsumerWidget {
  const SocialButton({
    super.key,
    this.onTap,
    required this.title,
    required this.image,
  });
  final void Function()? onTap;
  final String title, image;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48,
        margin: EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1,
            color: graySwatch.shade200,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              image,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}
