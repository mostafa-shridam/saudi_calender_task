import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../gen/assets.gen.dart';

class SendGift extends ConsumerWidget {
  const SendGift({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 43,
      width: double.infinity,
      color: const Color(0xffFFFAEF),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(Assets.images.gift),
          const SizedBox(width: 4),
          const Text("اضغط هنا لارسال هدية لاحبابك"),
        ],
      ),
    );
  }
}
