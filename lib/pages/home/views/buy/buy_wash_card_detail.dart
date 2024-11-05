import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/pages/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class BuyWashCardDetail extends StatefulWidget {
  final Function()? onTap;
  final int currentIndex;
  final String titleText;
  final String subTitleText;
  final String description;
  final List<String> amount;
  final String washRecommeded;
  final List<String> keyPoints;
  const BuyWashCardDetail(
      {super.key,
      required this.onTap,
      required this.currentIndex,
      required this.titleText,
      required this.subTitleText,
      required this.description,
      required this.amount,
      required this.washRecommeded,
      required this.keyPoints});

  @override
  State<BuyWashCardDetail> createState() => _BuyWashCardDetailState();
}

class _BuyWashCardDetailState extends State<BuyWashCardDetail> {
  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        color: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
                color: (homeController.selectedCardIndex.value ==
                        widget.currentIndex)
                    ? Get.theme.colorScheme.primary
                    : AppColors.disableColor)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.titleText,
                    textAlign: TextAlign.center,
                    style: Get.textTheme.headlineLarge!.copyWith(
                      color: Get.theme.colorScheme.primary,
                    ),
                  ),
                  washRecommendedWidget(),
                  const SizedBox(height: 10),
                  Text(widget.subTitleText, style: Get.textTheme.bodyMedium),
                ],
              ),
              Text(widget.description, style: Get.textTheme.bodySmall),
              keyPointsWidget(),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Get.theme.colorScheme.primary,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      (widget.amount.isNotEmpty && widget.amount.length == 2)
                          ? RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Transform.translate(
                                      offset: const Offset(0.0, -10.0),
                                      child: Text(
                                        '\$',
                                        style: Get.textTheme.headlineSmall,
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                      text: widget.amount.first,
                                      style: Get.textTheme.headlineLarge),
                                  WidgetSpan(
                                    child: Transform.translate(
                                      offset: const Offset(0.0, -10.0),
                                      child: Text(
                                        widget.amount.last,
                                        style: Get.textTheme.headlineSmall,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : (widget.amount.isNotEmpty &&
                                  widget.amount.length == 1)
                              ? RichText(
                                  text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Transform.translate(
                                        offset: const Offset(0.0, -10.0),
                                        child: Text(
                                          '\$',
                                          style: Get.textTheme.headlineSmall,
                                        ),
                                      ),
                                    ),
                                    TextSpan(
                                        text: widget.amount.first,
                                        style: Get.textTheme.headlineLarge),
                                  ],
                                ))
                              : const IgnorePointer(),
                      // Text(amount, style: Get.textTheme.headlineLarge),
                      Text('Monthly + Tax', style: Get.textTheme.titleSmall)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  washRecommendedWidget() {
    return widget.washRecommeded.isNotEmpty
        ? Column(
            children: [
              const SizedBox(height: 10),
              Container(
                  // alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Get.theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(widget.washRecommeded,
                        style: Get.textTheme.bodyMedium!.copyWith(
                            color: Get.theme.colorScheme.secondary,
                            fontWeight: FontWeight.w800)),
                  )),
            ],
          )
        : const IgnorePointer();
  }

  keyPointsWidget() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.keyPoints.length,
        itemBuilder: (context, index) {
          return Row(children: [
            MyBullet(),
            Text(
              widget.keyPoints[index],
              style: Get.textTheme.bodySmall,
            )
          ]);
        },
      ),
    );
  }
}

class MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5.0,
      height: 5,
      margin: const EdgeInsets.only(right: 10),
      decoration: const BoxDecoration(
        color: AppColors.blackColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
