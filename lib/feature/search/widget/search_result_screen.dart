import 'package:get/get.dart';
import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/components/web_shadow_wrap.dart';
import 'package:demandium/core/core_export.dart';



class SearchResultScreen extends StatefulWidget {
  final String? queryText;

  const SearchResultScreen({Key? key, required this.queryText}) : super(key: key);

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {

  @override
  void initState() {
    if(widget.queryText!.length > 0){
      Get.find<SearchController>().searchData(widget.queryText!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  SearchAppBar(backButton: true),
      body: GetBuilder<SearchController>(
        initState: (state) {
          Get.find<SearchController>().removeService();
        },
        builder: (searchController){
          return FooterBaseView(
              isCenter: (searchController.isSearchComplete || searchController.isLoading!) ? ( searchController.searchServiceList == null || searchController.searchServiceList!.length == 0):false,
              child: WebShadowWrap(
                child: searchController.isLoading! ?
                CircularProgressIndicator(color: Get.isDarkMode ? Theme.of(context).primaryColorLight : Theme.of(context).colorScheme.primary) :
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                  ItemView(),]),
          ));
        },
      ),
    );
  }
}
