import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import 'custom_divider.dart';

class AdSpace extends StatelessWidget {
  const AdSpace({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomDivider(),
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              height: 66,
              width: double.infinity,
              color: Colors.white,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,
                width: 320,
                decoration: BoxDecoration(
                  color: graySwatch.shade200,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    "AD SPACE",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: graySwatch.shade400,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        const CustomDivider(),
      ],
    );
  }
}
