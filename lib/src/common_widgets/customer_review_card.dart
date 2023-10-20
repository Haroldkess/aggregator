import 'package:flutter/material.dart';
import '../../model/vendor_rating_model.dart';
import '../../theme/colors.dart';
import '../providers/constants.dart';


class CostumerReviewCard extends StatelessWidget {
  const CostumerReviewCard({
    super.key,
    required this.mediaWidth,
    this.rateData,
  });
  final double mediaWidth;
  final RatingItem? rateData;

  @override
  Widget build(BuildContext context) {
    return rateData == null
        ? SizedBox.shrink()
        : Container(
            width: mediaWidth,
            padding: const EdgeInsets.all(kDefaultPadding),
            decoration: ShapeDecoration(
              color: const Color(0xFFFEF8F8),
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 0.50,
                  color: Color(0xFFFDEDED),
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x0F000000),
                  blurRadius: 24,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      decoration: ShapeDecoration(
                        shape: OvalBorder(),
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/customer/ebuka_henry.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    kHalfWidthSizedBox,
                    Text(
                      rateData!.client!.username ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF131514),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
                kSizedBox,
                Text(
                  rateData!.comment ?? '.',
                  style: TextStyle(
                    color: kTextGreyColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                kSizedBox,
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 20,
                      color: kStarColor,
                    ),
                    kHalfWidthSizedBox,
                    Text(
                      rateData!.ratingValue == null
                          ? ""
                          : "${double.tryParse(rateData!.ratingValue.toString())!.toStringAsFixed(1)} Ratings",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: kTextGreyColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
  }}
