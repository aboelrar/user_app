import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? backButton;
  SearchAppBar({this.backButton = true});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context) ? WebMenuBar() : AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 5, leadingWidth: backButton! ? 20 : 0,
      leading: backButton! ? Padding(
        padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        child: IconButton(
          icon: Icon(Icons.arrow_back_ios,),
          color: Theme.of(context).primaryColorLight,
          onPressed: () => Navigator.pop(context),
        ),
      ) : SizedBox(),
      title: SearchWidget(),
    );
  }

  @override
  Size get preferredSize => Size(Dimensions.WEB_MAX_WIDTH, GetPlatform.isDesktop ? 70 : 60);
}