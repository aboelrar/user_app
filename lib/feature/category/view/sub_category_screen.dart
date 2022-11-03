import 'package:demandium/core/core_export.dart';

class SubCategoryScreen extends StatelessWidget {
  final String categoryTitle;
  const SubCategoryScreen({Key? key, required this.categoryTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: categoryTitle,),
      body: CustomScrollView(
        slivers: [
          SubCategoryView(isScrollable: true,),
        ],
      )
    );
  }
}
