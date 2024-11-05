import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:get/get.dart';

class BuyWashCard extends StatelessWidget {
  final Function()? onTap;
  final String titleText;
  final String subTitleText;
  final String description;
  final List<String> amount;
  final String washRecommeded;
  final String washDenomination;
  const BuyWashCard(
      {super.key,
      required this.onTap,
      required this.titleText,
      required this.subTitleText,
      required this.description,
      required this.amount,
      required this.washRecommeded,
      required this.washDenomination});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 4,
        child: IntrinsicHeight(
          child: Stack(alignment: AlignmentDirectional.centerStart, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(titleText,
                          style: Get.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Get.theme.colorScheme.primary)),
                      Text(subTitleText, style: Get.textTheme.bodyMedium),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(description,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: Get.textTheme.bodySmall),
                      ),
                      washRecommendedWidget()
                    ],
                  ),
                ),
                Container(
                  // constraints: BoxConstraints.expand(),
                  decoration: BoxDecoration(
                      color: Get.theme.colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        (amount.isNotEmpty && amount.length == 2)
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
                                        text: amount.first,
                                        style: Get.textTheme.headlineLarge),
                                    WidgetSpan(
                                      child: Transform.translate(
                                        offset: const Offset(0.0, -10.0),
                                        child: Text(
                                          amount.last,
                                          style: Get.textTheme.headlineSmall,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : (amount.isNotEmpty && amount.length == 1)
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
                                          text: amount.first,
                                          style: Get.textTheme.headlineLarge),
                                    ],
                                  ))
                                : const IgnorePointer(),
                        // Text(amount, style: Get.textTheme.headlineLarge),
                        Text(washDenomination, style: Get.textTheme.titleSmall)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  washRecommendedWidget() {
    return washRecommeded.isNotEmpty
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
                    child: Text(washRecommeded,
                        style: Get.textTheme.bodyMedium!.copyWith(
                            color: Get.theme.colorScheme.secondary,
                            fontWeight: FontWeight.w800)),
                  )),
            ],
          )
        : const IgnorePointer();
  }
}
