import '../constants/common_imports.dart';
import 'appointment_details.dart';
import '../controllers/total_appointment.dart';

class TotalAppointment extends StatelessWidget {
  const TotalAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put((TotalAppointmentcontroller()));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: "All Appointments".text.make(),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: controller.getAppointments(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            // While data is being fetched, display a CircularProgressIndicator.
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var data = snapshot.data?.docs;
            return Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: data?.length ?? 0,
                itemBuilder: (BuildContext context, index) {
                  return ListTile(
                    onTap: () {
                      Get.to(() => Appointmentdetails(
                            doc: data[index],
                          ));
                    },
                    leading: CircleAvatar(
                      child: ClipOval(
                        child: Image.asset(
                          AppAssets.imgDoctor,
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                    title: data![index]['appDocName']
                        .toString()
                        .text
                        .semiBold
                        .make(),
                    subtitle:
                        "${data[index]['appDay']} - ${data[index]['appTime']}"
                            .toString()
                            .text
                            .make(),
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