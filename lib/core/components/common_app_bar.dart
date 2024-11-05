import 'package:customer_app/core/app_configuration/app_required.dart';

class CommonAppBar extends AppBar {
  final VoidCallback? onAppBarMenuPressed;
  final IconData? iconData;
  CommonAppBar(
      {super.key,
      Text titleWidget = const Text(''),
      isBackButtonVisible = false,
      this.iconData,
      this.onAppBarMenuPressed})
      : super(
          title: (titleWidget),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              iconData,
              color: AppColors.darkGreyColor,
            ),
            onPressed: onAppBarMenuPressed,
          ),
        );
}
