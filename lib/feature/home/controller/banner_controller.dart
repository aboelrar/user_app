import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/home/model/banner_model.dart';

class BannerController extends GetxController implements GetxService {
  final BannerRepo bannerRepo;
  BannerController({required this.bannerRepo});

  List<BannerModel>? _banners;
  List<BannerModel>? get banners => _banners;

  int? _currentIndex = 0;
  int? get currentIndex => _currentIndex;

  Future<void> getBannerList(bool reload) async {
    if(_banners == null || reload){
      Response response = await bannerRepo.getBannerList();
      if (response.statusCode == 200) {
        _banners = [];
        response.body['content']['data'].forEach((banner){
          _banners!.add(BannerModel.fromJson(banner));
        });
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
  }

  void setCurrentIndex(int index, bool notify) {
    _currentIndex = index;
    if(notify) {
      update();
    }
  }

  /// if resource type is category then show list of sub-category and if resource type is link then lunch link out of device
  Future<void> navigateFromBanner(String resourceType, String bannerID, String link, String resourceID, {String categoryName = ''})async {
    printLog("resourceType and bannerID: $resourceType $bannerID");
    print("link:$link");
    switch (resourceType){
      case 'category':
        Get.find<CategoryController>().getSubCategoryList(bannerID, 0); //banner id is category here
        Get.toNamed(RouteHelper.subCategoryScreenRoute(categoryName));
        break;

      case 'link':
        final uri = Uri.parse(link);
        if (await canLaunchUrl(uri)) {
         await launchUrl(Uri.parse(link));
        }
        break;
      case 'service':
        Get.toNamed(RouteHelper.getServiceRoute(resourceID));
        break;
      default:
        print("resource type is not implemented:$resourceType");
    }
  }
}
