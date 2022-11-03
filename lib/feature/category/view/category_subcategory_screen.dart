import 'package:get/get.dart';
import 'package:demandium/components/footer_view.dart';
import 'package:demandium/core/core_export.dart';

class CategorySubCategoryScreen extends StatefulWidget {
  final String categoryID;
  final String categoryName;
  CategorySubCategoryScreen({Key? key, required this.categoryID, required this.categoryName}) : super(key: key);

  @override
  State<CategorySubCategoryScreen> createState() => _CategorySubCategoryScreenState();
}

class _CategorySubCategoryScreenState extends State<CategorySubCategoryScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    moved();
    super.initState();
  }

  moved()async{
    Future.delayed(Duration(seconds: 1), () {
      Scrollable.ensureVisible(
        Get.find<CategoryController>().categoryList!.elementAt(Get.find<CategoryController>().subCategoryIndex!).globalKey!.currentContext!,
        duration: Duration(seconds: 1),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
        initState: (state) {},
        builder: (categoryController) {
          return WillPopScope(
            onWillPop: () async {
              if (categoryController.isSearching!) {
                categoryController.toggleSearch();
                return false;
              } else {
                return true;
              }
            },
            child: Scaffold(
              appBar: CustomAppBar(title: 'available_service'.tr,),
              body: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: SizedBox(height: Dimensions.PADDING_SIZE_LARGE,),),
                  SliverToBoxAdapter(
                    child: (categoryController.categoryList != null && !categoryController.isSearching!) ?
                    Container(
                      height: 108,
                      margin: EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
                      width: Dimensions.WEB_MAX_WIDTH,
                      padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryController.categoryList!.length,
                        padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL,right: Dimensions.PADDING_SIZE_SMALL),
                        itemBuilder: (context, index) {
                          CategoryModel categoryModel = categoryController.categoryList!.elementAt(index);
                          return InkWell(
                            key: categoryModel.globalKey,
                            onTap: () {
                              Get.find<CategoryController>().getSubCategoryList(categoryModel.id!, index);
                            },
                            child: Container(
                              width: Get.width / 4.5,
                              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                              decoration: BoxDecoration(
                                color: index == categoryController.subCategoryIndex ? Theme.of(context).colorScheme.primary : null,
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                                      child: CustomImage(
                                        image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}/category/${categoryController.categoryList![index].image}',
                                        fit: BoxFit.cover, height: 40, width: 40,
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                                    Text(categoryController.categoryList![index].name!,
                                      style: ubuntuMedium.copyWith(
                                          color:index == categoryController.subCategoryIndex ? Theme.of(context).primaryColorLight : Theme.of(context).colorScheme.primary,
                                          fontSize: Dimensions.fontSizeSmall),
                                      maxLines: 2,textAlign: TextAlign.center, overflow: TextOverflow.ellipsis,
                                    ),
                                  ]),
                            ),
                          );
                        },
                      ),
                    )
                        : SizedBox(),
                  ),
                  SliverToBoxAdapter(
                      child: Container(width: Dimensions.WEB_MAX_WIDTH,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_LARGE),
                              child: Center(
                                child: Text(
                                  'sub_categories'.tr, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                                    color:Get.isDarkMode ? Colors.white:Theme.of(context).colorScheme.primary),),)))),
                  SubCategoryView(noDataText: "no_services_found".tr, isScrollable: true),
                  if(ResponsiveHelper.isDesktop(context))
                    SliverToBoxAdapter(child: SizedBox(height: 120)),
                  if(ResponsiveHelper.isDesktop(context))
                    SliverToBoxAdapter(child: FooterView(),)
                ],
              ),
            ),
          );
        });
  }
}
