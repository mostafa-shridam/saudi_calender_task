import 'package:flutter/material.dart';
import 'package:saudi_calender_task/core/theme/app_theme.dart';

class RemainingWidget extends StatelessWidget {
  const RemainingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          endIndent: 16,
          thickness: 1,
          color: graySwatch.shade100,
          height: 0,
        ),
        InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(16),
            color: Colors.transparent,
            child: Row(
              children: [
                Text(
                  "تنبية",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                Text(
                  "في التوقيت",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: graySwatch.shade600,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Icon(Icons.arrow_forward_ios_outlined)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
