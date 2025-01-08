import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:saudi_calender_task/core/theme/app_theme.dart';

import '../../../../gen/assets.gen.dart';

class CategoryFilterData extends StatelessWidget {
  const CategoryFilterData({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "All",
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Colors.black),
          ),
          const Spacer(),
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: graySwatch,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      8,
                    ),
                  ),
                ),
                height: 40,
                width: 92,
                child: const CustomGridButton(),
              ),
              Container(
                color: const Color(0xffE2E8F0),
                width: 1,
                height: 16,
              )
            ],
          ),
          SizedBox(
            width: 6,
          ),
          GestureDetector(
            child: SvgPicture.asset(
              Assets.images.arrowSwapHorizontal,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomButtonIsSelected extends StatelessWidget {
  const CustomButtonIsSelected({
    super.key,
    required this.isSelected,
    required this.icon,
  });
  final bool isSelected;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.transparent,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            12,
          ),
        ),
      ),
      child: SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(
          isSelected ? const Color(0xff6B7DCF) : const Color(0xff64748B),
          BlendMode.srcIn,
        ),
        fit: BoxFit.fill,
      ),
    );
  }
}

class CustomGridButton extends StatefulWidget {
  const CustomGridButton({
    super.key,
  });

  @override
  State<CustomGridButton> createState() => _CustomGridButtonState();
}

class _CustomGridButtonState extends State<CustomGridButton> {
  int currentIndex = 0;
  @override
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(
        2,
        (index) {
          return GestureDetector(
            onTap: () => setState(() => currentIndex = index),
            child: CustomButtonIsSelected(
              icon: index == 0
                  ? Assets.images.bellActiveAlt
                  : Assets.images.gallerySlash,
              isSelected: currentIndex == index,
            ),
          );
        },
      ),
    );
  }
}
