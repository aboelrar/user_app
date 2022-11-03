import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';


class ServiceOverview extends StatelessWidget {
  final String description;
  const ServiceOverview({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: Container(
          width: Dimensions.WEB_MAX_WIDTH,
          constraints:  ResponsiveHelper.isDesktop(context) ? BoxConstraints(
            minHeight: !ResponsiveHelper.isDesktop(context) && Get.size.height < 600 ? Get.size.height : Get.size.height - 550,
          ) : null,
          child: Card(
            color: Theme.of(context).cardColor,
            child: Html(data: description,)
          ),
        ),
      ),
    );
  }
}