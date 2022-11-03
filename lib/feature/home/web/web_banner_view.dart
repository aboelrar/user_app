import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class WebBannerView extends GetView<BannerController> {
  @override
  Widget build(BuildContext context) {
    final PageController _pageController = PageController();
    return GetBuilder<BannerController>(
      initState: (state){
        Get.find<BannerController>().getBannerList(true);
      },
      builder: (bannerController){
        return Container(
          alignment: Alignment.center,
          child: SizedBox(width: Dimensions.WEB_MAX_WIDTH, height: 220, child: bannerController.banners != null ? Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: [

              PageView.builder(
                controller: _pageController,
                itemCount: (bannerController.banners!.length/2).ceil(),
                itemBuilder: (context, index) {
                  String? _baseUrl =  Get.find<SplashController>().configModel.content!.imageBaseUrl;
                  print('$_baseUrl/banner/${bannerController.banners![0].bannerImage}');
                  int index1 = index * 2;
                  int index2 = (index * 2) + 1;
                  bool _hasSecond = index2 < bannerController.banners!.length;
                  return Row(children: [
                    Expanded(child: InkWell(
                      // onTap: () => _onTap(index1, context),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                        child: CustomImage(
                          image: '$_baseUrl/banner/${bannerController.banners![index1].bannerImage}', fit: BoxFit.cover, height: 220,
                        ),
                      ),
                    )),

                    SizedBox(width: Dimensions.PADDING_SIZE_LARGE),

                    Expanded(child: _hasSecond ? InkWell(
                      // onTap: () => _onTap(index2, context),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                        child: CustomImage(
                          image: '$_baseUrl/banner/${bannerController.banners![index2].bannerImage}', fit: BoxFit.cover, height: 220,
                        ),
                      ),
                    ) : SizedBox()),

                  ]);
                },
                onPageChanged: (int index) => bannerController.setCurrentIndex(index, true),
              ),

              bannerController.currentIndex != 0 ? Positioned(
                top: 0, bottom: 0, left: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                  child: InkWell(
                    onTap: () => _pageController.previousPage(duration: Duration(seconds: 1), curve: Curves.easeInOut),
                    child: Container(
                      height: 40, width: 40, alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Theme.of(context).cardColor,
                      ),
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                ),
              ) : SizedBox(),

              bannerController.currentIndex != ((bannerController.banners!.length/2).ceil()-1) ? Positioned(
                top: 0, bottom: 0, right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                  child: InkWell(
                    onTap: () => _pageController.nextPage(duration: Duration(seconds: 1), curve: Curves.easeInOut),
                    child: Container(
                      height: 40, width: 40, alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Theme.of(context).cardColor,
                      ),
                      child: Icon(Icons.arrow_forward),
                    ),
                  ),
                ),
              ) : SizedBox(),

            ],
          )
              : WebBannerShimmer()),
        );
      },
    );
  }

}

class WebBannerShimmer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: Duration(seconds: 2),
      enabled: true,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
        child: Row(children: [

          Expanded(child: Container(
            height: 220,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL), color: Colors.grey[300]),
          )),

          SizedBox(width: Dimensions.PADDING_SIZE_LARGE),

          Expanded(child: Container(
            height: 220,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL), color: Colors.grey[300]),
          )),
        ]),
      ),
    );
  }
}

