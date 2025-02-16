import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrimaryButton extends ConsumerWidget {
  const PrimaryButton({
    super.key,
    this.onTap,
    required this.title,
  });
  final void Function()? onTap;
  final String title;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xff245D3A),
        ),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
