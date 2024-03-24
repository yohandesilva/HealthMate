import 'package:healthmate/constants/common_imports.dart';

import 'doctor_view.dart';

class SearchView extends StatelessWidget {
  final String searchQuery;
  const SearchView({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: "Search results".text.make(),
        elevation: 0,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('doctors').get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 200,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, index) {
                  var doc = snapshot.data!.docs[index];
                  return !(doc['docName']
                          .toString()
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase()))
                      ? Center(
                          child: "No doctor found try another name"
                              .text
                              .makeCentered(),
                        )
                      : GestureDetector(
                          onTap: () {
                            Get.to(
                              () => DoctorProfile(
                                doc: doc,
                              ),
                            );
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
                                /*
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    width: 130,
                                    color: AppColors.primaryColor,
                                    child: Image.asset(
                                      AppAssets.imgDoctor,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Divider(),
                                doc['docName']
                                    .toString()
                                    .text
                                    .size(AppFontSize.size16)
                                    .make(),
                               */


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
                                doc['docName']
                                    .toString()
                                    .text
                                    .size(AppFontSize.size16)
                                    .make(),
                                doc['docCategory']
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
    );
  }
}
