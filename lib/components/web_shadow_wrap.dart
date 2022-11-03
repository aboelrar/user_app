import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demandium/core/helper/responsive_helper.dart';
import 'package:demandium/utils/dimensions.dart';

class WebShadowWrap extends StatelessWidget {
  final Widget child;
  const WebShadowWrap({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context) ? Padding(
      padding: ResponsiveHelper.isMobile(context) ? EdgeInsets.zero : const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_LARGE, horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,
      ),
      child: Container(
        constraints: BoxConstraints(
          minHeight: !ResponsiveHelper.isDesktop(context) && Get.size.height < 600 ? Get.size.height : Get.size.height - 380,
        ),
        padding: !ResponsiveHelper.isMobile(context) ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT) : null,
        decoration: !ResponsiveHelper.isMobile(context) ? BoxDecoration(
          color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Theme.of(context).shadowColor, blurRadius: 5, spreadRadius: 1)],
        ) : null,
        width: Dimensions.WEB_MAX_WIDTH,
        child: child,
      ),
    ) : child;
  }
}