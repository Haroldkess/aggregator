import 'package:benji_aggregator/controller/operation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/order_list_model.dart';
import '../../theme/colors.dart';
import '../providers/constants.dart';

class AllOrdersContainer extends StatelessWidget {
  const AllOrdersContainer({
    super.key,
    required this.mediaWidth,
    required String orderImage,
    required int orderID,
    required Icon orderStatusIcon,
    required this.formattedDateAndTime,
    required String orderItem,
    required int itemQuantity,
    required double itemPrice,
    required String customerName,
    required String customerAddress,
    required this.order,
  })  : _orderImage = orderImage,
        _orderID = orderID,
        _orderStatusIcon = orderStatusIcon,
        _orderItem = orderItem,
        _itemQuantity = itemQuantity,
        _itemPrice = itemPrice,
        _customerName = customerName,
        _customerAddress = customerAddress;

  final double mediaWidth;
  final String _orderImage;
  final int _orderID;
  final String formattedDateAndTime;
  final Icon _orderStatusIcon;
  final String _orderItem;
  final int _itemQuantity;
  final double _itemPrice;
  final String _customerName;
  final String _customerAddress;
  final OrderItem order;

  @override
  Widget build(BuildContext context) {
    int qty = 0;
    if (order.orderitems != null) {
      if (order.orderitems!.isNotEmpty)
        order.orderitems!.forEach((element) {
          qty += int.tryParse(element.quantity!.toString())!;
        });
    }
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: kDefaultPadding / 2,
      ),
      padding: const EdgeInsets.only(
        top: kDefaultPadding / 2,
        left: kDefaultPadding / 2,
        right: kDefaultPadding / 2,
      ),
      width: mediaWidth / 1.1,
      height: 150,
      decoration: ShapeDecoration(
        color: kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultPadding),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 24,
            offset: Offset(0, 4),
            spreadRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: kPageSkeletonColor,
                  borderRadius: BorderRadius.circular(16),
                  // image: DecorationImage(
                  //   image: AssetImage(
                  //     "assets/images/products/$_orderImage.png",
                  //   ),
                  // ),
                ),
                child: CachedNetworkImage(
                  imageUrl: order.client!.image ?? "",
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                          child: CupertinoActivityIndicator(
                    color: kRedColor,
                  )),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: kRedColor,
                  ),
                ),
              ),
              kHalfSizedBox,
              SizedBox(
                width: 60,
                child: Text(
                  "#00${1234.toString()}",
                  style: TextStyle(
                    color: kTextGreyColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 5),
              DottedBorder(
                borderType: BorderType.RRect,
                color: kGreyColor,
                padding: EdgeInsets.all(kDefaultPadding / 3),
                radius: Radius.circular(kDefaultPadding),
                child: _orderStatusIcon,
              ),
            ],
          ),
          kWidthSizedBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: mediaWidth / 1.55,
                // color: kAccentColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      child: Text(
                        "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Text(
                        order.created == null
                            ? ""
                            : Operation.convertDate(order.created!),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              kHalfSizedBox,
              Container(
                color: kTransparentColor,
                width: 250,
                child: Text(
                  _orderItem,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              kHalfSizedBox,
              Container(
                width: 200,
                color: kTransparentColor,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "x $qty",
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const TextSpan(text: "  "),
                      TextSpan(
                        text:
                            "₦ ${convertToCurrency(order.totalPrice.toString())}",
                        style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'sen',
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              kHalfSizedBox,
              Container(
                color: kLightGreyColor,
                height: 1,
                width: mediaWidth / 1.8,
              ),
              kHalfSizedBox,
              SizedBox(
                width: mediaWidth / 1.8,
                child: Text(
                  "${order.client!.lastName} ${order.client!.firstName}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                width: mediaWidth / 1.8,
                child: Text(
                  order.deliveryAddress == null
                      ? ""
                      : "${order.deliveryAddress!.streetAddress ?? ""}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
