import '../constants/common_imports.dart';
import 'doctor_view.dart';

class CategoryDetailsView extends StatelessWidget {
  final String catName;
  const CategoryDetailsView({super.key, required this.catName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: "$catName doctors".text.make(),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('doctors')
            .where('docCategory', isEqualTo: catName)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var data = snapshot.data?.docs;
            return Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 200,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: data?.length ?? 0,
                itemBuilder: (BuildContext context, index) {
                  return Container(
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
                        /*ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            width: 130,
                            color: AppColors.primaryColor,
                            child: Image.asset(
                              AppAssets.imgLogin,
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
                        VxRating(
                          onRatingUpdate: (value) {},
                          maxRating: 5,
                          count: 5,
                          value:
                              double.parse(data[index]['docRating'].toString()),
                          stepInt: true,
                        ),*/

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
                  ).onTap(() {
                    Get.to(() => DoctorProfile(doc: data[index]));
                  });
                },
              ),
            );
          }
        },
      ),
    );
  }
}
