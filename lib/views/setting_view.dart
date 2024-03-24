import 'package:healthmate/constants/common_imports.dart';

import '../controllers/signup_controller.dart';
import 'auth/login_page.dart';
import '../widgets/custom_iconbutton.dart';
import '../controllers/profile_controller.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: "Settings".text.make(),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAssets.imgLogin,
                        width: 200,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Align(
                          alignment: Alignment.center,
                          child: controller.username.value.text.size(20).bold.make(),
                        ),
                      ),
                      10.heightBox,
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Align(
                          alignment: Alignment.center,
                          child: controller.email.value.text.size(17).make(),
                        ),
                      ),
                      40.heightBox,
                      CustomIconButton(
                        color: AppColors.redcolor,
                        onTap: () {
                          SignupController().signout();
                          Get.offAll(() => const LoginView());
                        },
                        title: "Logout",
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
