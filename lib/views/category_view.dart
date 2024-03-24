import 'package:healthmate/constants/common_imports.dart';
import 'package:healthmate/constants/home_icon_list.dart';

import 'category_details.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: "Total Category".text.make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: categoryImage.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            crossAxisCount: 2,
            mainAxisExtent: 200,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Get.to(() => CategoryDetailsView(
                      catName: categoryTitle[index],
                    ));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.bgDarkColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.all(12),
                // margin: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  children: [
                    Image.asset(
                      categoryImage[index],
                      width: 110,
                    ),
                    const Divider(),
                    SizedBox(height: 15),
                    categoryTitle[index].text.size(AppFontSize.size18).make()
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
