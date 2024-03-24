import '../constants/common_imports.dart';

class CustomIconButton extends StatelessWidget {
  final Function()? onTap;
  final String title;
  final Color? color;
  // ignore: prefer_typing_uninitialized_variables
  final icon;

  const CustomIconButton({
    Key? key,
    required this.onTap,
    required this.title,
    this.color,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: const StadiumBorder(),
      ),
      onPressed: onTap,
      icon: icon,
      label: title.text.white.make(),
    );
  }
}
