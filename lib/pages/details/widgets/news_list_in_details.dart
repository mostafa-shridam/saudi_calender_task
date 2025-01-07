import 'package:flutter/material.dart';
import 'package:saudi_calender_task/core/services/app_theme.dart';

import '../../../gen/assets.gen.dart';

class NewsListInDetails extends StatelessWidget {
  const NewsListInDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) => Container(
        height: 90,
        width: 382,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsetsDirectional.only(start: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          border: Border.all(
            color: graySwatch.shade200,
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 285,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "اجازة نهاية العام",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "تبدأ اجازة نهاية العام الدراسي من يوم16",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: graySwatch.shade600,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "منذ 3 ساعات",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: graySwatch.shade400,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            ClipRRect(
              borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(4),
                topEnd: Radius.circular(4),
              ),
              child: Image.asset(
                Assets.images.newsPoster.path,
                width: 90,
                height: 90,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
