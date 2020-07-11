import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './../../../bloc/_bloc.dart';
import './../../../model/shop/_shop.dart';
import './../../../presentation/_presentation.dart' as PRESENTATION;

class PaymentSummaryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12.0,
            ),
            child: Text(
              "Payment Summary",
              style: PRESENTATION.PAYMENT_HEADING_TEXT_STYLE,
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Subtotal: ",
                  style: PRESENTATION.PAYMENT_SUMMARY_ITEM_TEXT_STYLE,
                ),
                BlocBuilder<BlocCart, Cart>(
                  builder: (BuildContext context, Cart cart) {
                    return Text(
                      cart.total.toString(),
                      style: PRESENTATION.PAYMENT_SUMMARY_ITEM_TEXT_STYLE,
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Total: ",
                  style: PRESENTATION.PAYMENT_SUMMARY_TOTAL_TEXT_STYLE,
                ),
                BlocBuilder<BlocCart, Cart>(
                  builder: (BuildContext context, Cart cart) {
                    return Text(
                      cart.total.toString(),
                      style: PRESENTATION.PAYMENT_SUMMARY_TOTAL_TEXT_STYLE,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
