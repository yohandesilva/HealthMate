import '../constants/common_imports.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String title;
  const CustomButton({super.key, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primeryColor,
        shape: const StadiumBorder(),
      ),
      onPressed: onTap,
      child: title.text.white.make(),
    );
  }
}