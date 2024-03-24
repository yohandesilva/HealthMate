import 'package:healthmate/constants/common_imports.dart';

import 'appointment_view.dart';
import '../widgets/custom_button.dart';

class DoctorProfile extends StatelessWidget {
  final DocumentSnapshot doc;
  const DoctorProfile({super.key, required this.doc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: "Doctor details".text.make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.bgDarkColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      clipBehavior: Clip.hardEdge,
                      height: 75,
                      width: 75,
                      child: Image.asset(
                        AppAssets.imgDoctor,
                        fit: BoxFit.cover,
                      ),
                    ),
                    15.widthBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        doc['docName']
                            .toString()
                            .text
                            .size(AppFontSize.size18)
                            .make(),
                        doc['docCategory'].toString().text.make(),
                      ],
                    ),
                  ],
                ),
              ),
              10.heightBox,
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.bgDarkColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "About".text.semiBold.size(AppFontSize.size18).make(),
                    5.heightBox,
                    doc['docAbout']
                        .toString()
                        .text
                        .size(AppFontSize.size14)
                        .make(),
                    10.heightBox,
                    "Address".text.semiBold.size(AppFontSize.size18).make(),
                    5.heightBox,
                    doc['docAddress']
                        .toString()
                        .text
                        .size(AppFontSize.size14)
                        .make(),
                    10.heightBox,
                    "Working Time"
                        .text
                        .semiBold
                        .size(AppFontSize.size18)
                        .make(),
                    5.heightBox,
                    doc['docTime']
                        .toString()
                        .text
                        .size(AppFontSize.size14)
                        .make(),
                    10.heightBox,
                    "Service".text.semiBold.size(AppFontSize.size18).make(),
                    5.heightBox,
                    doc['docService']
                        .toString()
                        .text
                        .size(AppFontSize.size14)
                        .make(),
                    25.heightBox,
                    ListTile(
                      title: "Contact Details"
                          .text
                          .semiBold
                          .size(AppFontSize.size16)
                          .make(),
                      subtitle: "First book an Appointment for contact details"
                          .text
                          .size(AppFontSize.size12)
                          .make(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: CustomButton(
            onTap: () {
              Get.to(
                () => BookAppointmentView(
                  docId: doc['docId'],
                  docName: doc['docName'],
                  docNum: doc['docPhone'],
                ),
              );
            },
            title: "Book an Appointment"),
      ),
    );
  }
}
