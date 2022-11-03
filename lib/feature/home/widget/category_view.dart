import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class CategoryView extends StatelessWidget {
  CategoryView();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(initState: (state) {
      Get.find<CategoryController>().getCategoryList(1,false);
    }, builder: (categoryController) {
      if(categoryController.categoryList != null && categoryController.categoryList!.length == 0){
        return SizedBox() ;
      }else{
        if(categoryController.categoryList != null){
          return Center(
            child: Container(
              width: Dimensions.WEB_MAX_WIDTH,
              child: Padding(
                padding: EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT, 15, Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_SMALL,),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('all_categories'.tr, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge)),
                          InkWell(
                            onTap: () {
                              Get.toNamed(RouteHelper.getCategoryProductRoute(
                                categoryController.categoryList![0].id!,
                                categoryController.categoryList![0].name!,
                              ));
                              Get.find<CategoryController>().getSubCategoryList(
                                categoryController.categoryList![0].id!,
                                0,
                              );
                            },
                            child: Text('see_all'.tr, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                              decoration: TextDecoration.underline,
                              color:Get.isDarkMode ?Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6) : Theme.of(context).colorScheme.primary,
                            )),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: ResponsiveHelper.isDesktop(context) ? 6 : ResponsiveHelper.isTab(context) ? 4 : 4,
                            crossAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
                            mainAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
                            childAspectRatio: .85,
                            mainAxisExtent:ResponsiveHelper.isMobile(context) ?  null : 260,
                        ),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: categoryController.categoryList!.length > 8 ? 8 : categoryController.categoryList!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.toNamed(RouteHelper.getCategoryProductRoute(
                                categoryController.categoryList![index].id!,
                                categoryController.categoryList![index].name!,
                              ));
                              Get.find<CategoryController>().getSubCategoryList(
                                categoryController.categoryList![index].id!,
                                index,
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.only(top : Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              decoration: BoxDecoration(
                                color: Theme.of(context).hoverColor,
                                borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_DEFAULT), ),
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                                      child: CustomImage(
                                        image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}/category/${categoryController.categoryList![index].image}',
                                        fit: BoxFit.cover, height: MediaQuery.of(context).size.width/10, width: MediaQuery.of(context).size.width/10,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all( Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                      child: Text(categoryController.categoryList![index].name!,
                                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                                        maxLines: 2,textAlign: TextAlign.center, overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ]),
                            ),
                          );
                        },
                      ) ,
                    ]),
              ),
            ),
          );
        }else{
          return WebCategoryShimmer(categoryController: categoryController);
        }
      }
    });
  }
}



class WebCategoryShimmer extends StatelessWidget {
  final CategoryController categoryController;

  WebCategoryShimmer({required this.categoryController});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
        width: Dimensions.WEB_MAX_WIDTH,
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 8,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              decoration: BoxDecoration(
                  color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300],
                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_DEFAULT))),
              margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_LARGE),
              child: Shimmer(
                duration: Duration(seconds: 2),
                enabled: true,
                child: Row(children: [
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL), color: Colors.grey[300]),
                  ),
                  SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                  Container( color: Colors.grey[Get.find<ThemeController>().darkTheme ? 600 : 300]),
                ]),
              ),
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: ResponsiveHelper.isDesktop(context) ? 6 : ResponsiveHelper.isTab(context) ? 4 : 4,
              crossAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
              mainAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
              childAspectRatio: .95
          ),
        ),
      ),
    );
  }
}
