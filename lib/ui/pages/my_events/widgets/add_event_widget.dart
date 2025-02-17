import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/repos/auth_repo_impl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../add_event/add_event_page.dart';
import '../../auth/sign_in_page.dart';

class AddEventWidget extends ConsumerWidget {
  const AddEventWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 335,
      height: 178,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: graySwatch.shade50,
        border: Border.all(color: graySwatch.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "لا توجد مناسبات",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              "عذرا, لم تقم بإضافة اي مناسبات حتى الان!\nقم بإضافة اول مناسبة",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            FilledButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(graySwatch.shade200),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              onPressed: () {
                final isSignedIn =
                    ref.read(authRepoProvider).getUserDataLocal();

                if (isSignedIn != null) {
                  context.pushNamed(AddEditEventPage.routeName);
                } else {
                  context.pushNamed(SignInPage.routeName);
                }
              },
              child: Text(
                "إضافة مناسبة",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            )
          ],
        ),
      ),
    );
  }
}
