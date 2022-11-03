import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/service/repository/service_details_repo.dart';

enum ServiceTabControllerState {serviceOverview,faq,review}

class ServiceTabController extends GetxController with GetSingleTickerProviderStateMixin{
  final ServiceDetailsRepo serviceDetailsRepo;
  ServiceTabController({required this.serviceDetailsRepo});

  List<Faqs>? faqs = Get.find<ServiceDetailsController>().service!.faqs;


  List<Widget> serviceDetailsTabs(){
    print("faqs:$faqs");
    if(faqs!.length > 0){
      return  [
        Tab(text: 'service_overview'.tr),
        Tab(text: 'faqs'.tr),
        Tab(text: 'reviews'.tr),
      ];
    }
    return  [
      Tab(text: 'service_overview'.tr),
      Tab(text: 'reviews'.tr),
    ];
  }

  TabController? controller;
  var servicePageCurrentState = ServiceTabControllerState.serviceOverview;
  void updateServicePageCurrentState(ServiceTabControllerState serviceDetailsTabControllerState){
    servicePageCurrentState = serviceDetailsTabControllerState;
    update();
  }

  bool? _isLoading;
  int? _pageSize = 0;
  List<ReviewData>? _reviewList = [];
  List<ReviewData> get reviewList => _reviewList!;
  bool get isLoading => _isLoading!;
  int? get pageSize => _pageSize!;
  Rating? _rating;
  String? _serviceID;
  int? _offset = 1;
  Rating get rating => _rating!;
  int? get offset => _offset;
  String? get serviceID => _serviceID;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length:faqs!.length > 0 ? 3 :2);
  }

  Future<void> getServiceReview(String serviceID,int offset, {bool reload = true,}) async {
    print("offset:$offset");
    _isLoading = true;
    _offset = offset;
    Response response = await serviceDetailsRepo.getServiceReviewList(serviceID,offset);
    if (response.statusCode == 200 && response.body['response_code'] ==  'default_200') {
      try{
        response.body['content']['reviews']['data'].forEach((review){
          _reviewList!.add( ReviewData.fromJson(review));
        });
      }catch(error){
        print('error : $error');
      }
      try{
        _rating = Rating.fromJson(response.body['content']['rating']);
      }catch(error){
        print('rating get error : $error');
      }
      _pageSize = response.body['content']['reviews']['last_page']?? 0;
    }
    _isLoading = false;
    update();
  }

  @override
  void onClose() {
    controller!.dispose();
    super.onClose();
  }
}