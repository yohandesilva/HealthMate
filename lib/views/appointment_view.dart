import '../constants/common_imports.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import '../controllers/book_appointment_controller.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';


class BookAppointmentView extends StatelessWidget {
  // Variables
  final String docId;
  final String docNum;
  final String docName;

  // Constructor
  const BookAppointmentView({
    super.key,
    required this.docId,
    required this.docName,
    required this.docNum,
  });

  @override
  Widget build(BuildContext context) {
    // Controller
    var controller = Get.put(AppointmentController());

    // UI
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: docName.text.make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: controller.formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Select Appointment date"
                    .text
                    .size(AppFontSize.size16)
                    .semiBold
                    .make(),
                CustomTextField(
                  validator: controller.validdata,
                  textcontroller: controller.appDayController,
                  hint: "Select date",
                  icon: const Icon(Icons.calendar_month_outlined),
                ),
                10.heightBox,
                "Select Appointment Time"
                    .text
                    .size(AppFontSize.size16)
                    .semiBold
                    .make(),
                CustomTextField(
                  validator: controller.validdata,
                  textcontroller: controller.appTimeController,
                  hint: "Select time",
                  icon: const Icon(Icons.watch_later),
                ),
                10.heightBox,
                "patient's name".text.size(AppFontSize.size16).semiBold.make(),
                CustomTextField(
                  validator: controller.validdata,
                  textcontroller: controller.appNameController,
                  hint: "patient's full name",
                  icon: const Icon(Icons.person),
                ),
                10.heightBox,
                "Mobile Number".text.size(AppFontSize.size16).semiBold.make(),
                CustomTextField(
                  validator: controller.validdata,
                  textcontroller: controller.appMobileController,
                  hint: "Enter patent mobile number",
                  icon: const Icon(Icons.call),
                ),
                10.heightBox,
                "Your problem".text.size(AppFontSize.size16).semiBold.make(),
                TextFormField(
                  controller: controller.appMessageController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.note_add),
                    hintText: "write your problem in short",
                    hintStyle: TextStyle(),
                    border: OutlineInputBorder(borderSide: BorderSide()),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Center(
                    child: Text(
                  'Doctor Fee: Rs.500.00',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Padding(
          padding: const EdgeInsets.all(10),
          child: controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : CustomButton(
                  onTap: () async {

                    if (controller.formkey.currentState!.validate()) {
                      Get.to(() => PaypalCheckout(
                        sandboxMode: true,
                        clientId: "AbF6ZW8LRBN1UnN5_ZaBhb-NRZXPC3FIONGB1PB_s-bsuWeYTsXzj4KO_C7dxAinc_06n2tdRJnsgGhh",
                        secretKey: "ENLBVR7NfnETksIAKTPY28gPM4azhIRphK3FcjIY4ApwrNiLGk4o7xDIJ6jVYEIkhtUA-pcGwrKGJgzG",
                        returnURL: "lk.healthmate",
                        cancelURL: "lk.healthmate",
                        transactions: const [
                          {
                            "amount": {
                              "total": '5',
                              "currency": "USD",
                              "details": {
                                "subtotal": '5',
                                "shipping": '0',
                                "shipping_discount": 0
                              }
                            },
                            "description": "HealthMate Appointment",
                            "item_list": {
                              "items": [
                                {
                                  "name": "Doctor Charges",
                                  "quantity": 1,
                                  "price": '5',
                                  "currency": "USD"
                                }
                              ],
                            }
                          }
                        ],
                        note: "PAYMENT_NOTE",
                        onSuccess: (Map params) async {
                          await controller.bookAppointment(
                              docId, docName, docNum, context
                          );
                        },
                        onError: (error) {
                          VxToast.show(context, msg:"onError: $error");
                          Get.back();
                        }
                      ));

                    }
                  },
                  title: "Pay Now",
                ),
        ),
      ),
    );
  }
}
