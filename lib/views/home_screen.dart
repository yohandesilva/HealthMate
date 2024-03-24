import 'package:healthmate/constants/common_imports.dart';

import '../constants/home_icon_list.dart';
import '../controllers/profile_controller.dart';
import 'category_details.dart';
import 'doctor_view.dart';
import '../controllers/search_controller.dart';
import 'search_view.dart';
import '../widgets/custom_textfield.dart';
import '../controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var searchcontroller = Get.put(DocSearchController());
    var profileController = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppString.welcome.text.make(),
            profileController.username.value.text.make()
          ],
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            //search section
            Container(
              padding: const EdgeInsets.all(8),
              height: 70,
              color: AppColors.primaryColor,
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      textcontroller: searchcontroller.searchQueryController,
                      hint: AppString.search,
                      icon: const Icon(Icons.person_search_sharp),
                    ),
                  ),
                  10.widthBox,
                  IconButton(
                      onPressed: () {
                        Get.to(() => SearchView(
                              searchQuery:
                                  searchcontroller.searchQueryController.text,
                            ));
                      },
                      icon: const Icon(Icons.search))
                ],
              ),
            ),
            4.heightBox,
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  SizedBox(
                    height: 110,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: iconList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          //ontap for list
                          onTap: () {
                            Get.to(() => CategoryDetailsView(
                                catName: iconListTitle[index]));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            child: Column(
                              children: [
                                Image.asset(
                                  iconList[index],
                                  width: 50,
                                ),
                                5.heightBox,
                                iconListTitle[index].text.make()
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  15.heightBox,
                  //populer doctors
                  Align(
                    alignment: Alignment.centerLeft,
                    child: "Available Doctors"
                        .text
                        .color(AppColors.primaryColor)
                        .size(AppFontSize.size16)
                        .make(),
                  ),
                  10.heightBox,
                  FutureBuilder<QuerySnapshot>(
                    future: controller.getDoctorList(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        var data = snapshot.data?.docs;
                        return SizedBox(
                          height: 195,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: data?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => DoctorProfile(
                                        doc: data[index],
                                      ));
                                },
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    color: AppColors.bgDarkColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: const EdgeInsets.only(bottom: 5),
                                  margin: const EdgeInsets.only(right: 8),
                                  height: 120,
                                  width: 130,
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Container(
                                          color: AppColors.primaryColor,
                                          child: Image.asset(
                                            AppAssets.imgDoctor,
                                            height: 130,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const Divider(),
                                      data![index]['docName']
                                          .toString()
                                          .text
                                          .size(AppFontSize.size16)
                                          .make(),
                                      data[index]['docCategory']
                                          .toString()
                                          .text
                                          .size(AppFontSize.size12)
                                          .make(),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
