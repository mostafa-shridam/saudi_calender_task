// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:saudi_calender_task/core/theme/app_theme.dart';
import 'package:saudi_calender_task/gen/assets.gen.dart';
import 'package:saudi_calender_task/ui/widgets/custom_show_snack_bar.dart';
import 'package:saudi_calender_task/ui/widgets/custom_text_filed.dart';
import 'package:saudi_calender_task/ui/widgets/primary_button.dart';
import 'package:saudi_calender_task/ui/widgets/social_button.dart';

import '../../../providers/auth_service.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});
  static const routeName = '/sign-in';
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        appBar: AppBar(),
        body: Form(
          autovalidateMode: autovalidateMode,
          key: formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                height: 100,
                color: graySwatch.shade200,
                child: Row(
                  children: [
                    Text(
                      "مرحبا بك\nفي تطبيق تقويم السعودية",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Spacer(),
                    SvgPicture.asset(
                      Assets.images.group,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              SocialButton(
                title: "التسجيل بإستخدام جوجل",
                image: Assets.images.google,
                onTap: () async {
                  context.loaderOverlay.show();
                  final result = await ref
                      .read(authServiceProvider.notifier)
                      .signInWithGoogle();
                  if (result) {
                    log("Sign In With Google");
                    context.loaderOverlay.hide();
                    context.pop();
                  } else {
                    context.loaderOverlay.hide();
                    customShowSnackBar(context,
                        message: "حدث خطأ ما تاكد من اتصالك بالانترنت");
                  }
                },
              ),
              Divider(
                endIndent: 40,
                indent: 40,
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    CustomTextField(
                      onChanged: (value) {},
                      controller: emailController,
                      hint: "البريد الالكتروني",
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => value!.isEmpty
                          ? "برجاء ادخال البريد الاكتروني"
                          : null,
                      withBorder: true,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Visibility(
                      visible: index == 1 && emailController.text.isNotEmpty
                          ? true
                          : false,
                      child: CustomTextField(
                        onChanged: (value) {},
                        hint: "كلمة المرور",
                        maxLines: 1,
                        controller: passController,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) =>
                            value!.isEmpty ? "برجاء ادخال كلمة المرور" : null,
                        withBorder: true,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    PrimaryButton(
                      title: "تسجيل الدخول",
                      onTap: () {
                        setState(() {
                          if (index == 0) {
                            index++;
                          } else {
                            index == 1;
                          }
                          log(index.toString());
                        });
                        if (formKey.currentState!.validate()) {
                          ref
                              .read(authServiceProvider.notifier)
                              .signInWithEmailAndPass(
                                email: emailController.text,
                                password: passController.text,
                              );
                              
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
