import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './../../../bloc/_bloc.dart';
import './../../../const/_const.dart' as CONSTANTS;
import './../../../model/_model.dart';
import './../../../presentation/_presentation.dart' as PRESENTATION;

class BasketWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: BlocBuilder<BlocCart, Cart>(
          builder: (BuildContext context, Cart _cart) {
        return GestureDetector(
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Icon(
                PRESENTATION.Font_awesome_icons.shopping_basket,
                size: 36.0,
              ),
              BlocBuilder<BlocCart, Cart>(
                  builder: (BuildContext context, Cart cart) {
                Widget widget;
                var cartLength = cart.length;
                if (cartLength == 0) {
                  widget = Container();
                } else
                  widget = Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: CircleAvatar(
                      radius: 8.0,
                      backgroundColor: PRESENTATION.PRIMARY_COLOR,
                      foregroundColor: Colors.white,
                      child: BlocBuilder<BlocCart, Cart>(
                          builder: (BuildContext context, Cart _cart) {
                        var _cartLength = _cart.length;
                        return _cartLengthText(_cartLength);
                      }),
                    ),
                  );
                return widget;
              }),
            ],
          ),
          onTap: () {
            if (_cart.isNotEmpty)
              Navigator.pushNamed(
                context,
                CONSTANTS.PageName.BASKET,
              );
          },
        );
      }),
    );
  }

  Widget _cartLengthText(int cartLength) {
    return Text(
      cartLength.toString(),
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12.0,
      ),
    );
  }
}
