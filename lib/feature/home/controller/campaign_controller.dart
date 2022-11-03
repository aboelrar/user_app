import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/home/model/campaign_model.dart';

class CampaignController extends GetxController implements GetxService {
  final CampaignRepo campaignRepo;
  CampaignController({required this.campaignRepo});

  List<CampaignData>? _campaignList ;
  List<Service>? _itemCampaignList;
  int? _currentIndex = 0;
  bool? _isLoading = false;

  List<CampaignData>? get campaignList => _campaignList;
  List<Service>? get itemCampaignList => _itemCampaignList;
  int? get currentIndex => _currentIndex;
  bool? get isLoading => _isLoading;

  Future<void> getCampaignList(bool reload) async {
    if(_campaignList == null || reload){
      print("inside_get_campaign_list");
      Response? response = await campaignRepo.getcampaignList();
      if (response!.statusCode == 200) {
        _campaignList = [];
        response.body['content']['data'].forEach((campaign) => _campaignList!.add(CampaignData.fromJson(campaign)));
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

  /// fetch service list based on campaign id and navigate to all service list screen
  Future<void> navigateFromCampaign(String campaignID,String discountType)async {
    print("discountType:$discountType");
    _isLoading = true;
    update();
    printLog("campaignID: $campaignID");
    if(discountType == 'category'){
      Get.find<CategoryController>().getCampaignBasedCategoryList(campaignID,false);
    }else if(discountType == 'mixed'){
      Get.find<ServiceController>().getMixedCampaignList(campaignID,false);
    }else{
      Get.find<ServiceController>().getCampaignBasedServiceList(campaignID,false);
    }
    _isLoading = false;
    update();
  }
}