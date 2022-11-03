import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/category/view/sub_category_widget.dart';

class SubCategoryView extends GetView<CategoryController> {
  final EdgeInsetsGeometry? padding;
  final bool? isScrollable;
  final int? shimmerLength;
  final String? noDataText;
  final String? type;
  final Function(String type)? onVegFilterTap;
  SubCategoryView({this.isScrollable = false, this.shimmerLength = 20, this.padding = const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL), this.noDataText, this.type, this.onVegFilterTap});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
     builder: (categoryController){
       if(categoryController.subCategoryList == null){
         return  SliverGrid(
           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
             crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : 2,
             childAspectRatio: ResponsiveHelper.isDesktop(context) ? 4 : 3.5,
             mainAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
             crossAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,),
           delegate: SliverChildBuilderDelegate((context, index) {
               return Padding(
                 padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                 child: ServiceShimmer(isEnabled: true, hasDivider: index != shimmerLength!-1),
               );
             },
             childCount: 10,
           ),
         );
       }else{
         List<CategoryModel> subCategoryList = categoryController.subCategoryList ?? [];
         return subCategoryList.length > 0 ? SliverGrid(
           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
             crossAxisSpacing: Dimensions.PADDING_SIZE_LARGE,
             mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_LARGE : Dimensions.PADDING_SIZE_SMALL,
             childAspectRatio: ResponsiveHelper.isDesktop(context) ? 4 : 3.2,
             crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : 2,
             mainAxisExtent: 115,
           ),
           delegate: SliverChildBuilderDelegate((context, index) {
             return SubCategoryWidget(categoryModel: subCategoryList[index]);
             },
             childCount: subCategoryList.length,
           ),
         ):
         SliverToBoxAdapter(
           child: Container(
             height: Get.height / 1.5,
             child: NoDataScreen(
               text: noDataText != null ? noDataText : 'no_category_found'.tr,
               type: NoDataType.CATEGORY_SUBCATEGORY,
             ),
           ),
         );
       }
     },
    );
  }
}
