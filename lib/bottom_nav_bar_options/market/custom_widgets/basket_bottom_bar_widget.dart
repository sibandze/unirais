import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './../../../bloc/_bloc.dart';
import './../../../const/_const.dart' as CONSTANTS;
import './../../../model/_model.dart';
import './../../../presentation/_presentation.dart' as PRESENTATION;

enum BasketBottomBarType {
  TO_BASKET,
  TO_CHECKOUT, /*PLACE_ORDER*/
}

class BasketBottomBar extends StatelessWidget {
  final BasketBottomBarType _basketBottomBarType;
  final Map<BasketBottomBarType, String> _leftText = {
    BasketBottomBarType.TO_BASKET: "Your basket",
    BasketBottomBarType.TO_CHECKOUT: "Proceed to checkout",
    // BasketBottomBarType.PLACE_ORDER: "Place order",
  };

  BasketBottomBar(this._basketBottomBarType);

  Widget build(BuildContext context) {
    return BlocBuilder<BlocCart, Cart>(
      builder: (BuildContext context, Cart _cart) {
        return InkWell(
          onTap: () {
            switch (_basketBottomBarType) {
              case BasketBottomBarType.TO_BASKET:
                if (_cart.isNotEmpty)
                  Navigator.pushNamed(context, CONSTANTS.PageName.BASKET);
                break;
              case BasketBottomBarType.TO_CHECKOUT:
                if (_cart.isNotEmpty)
                  Navigator.pushNamed(context, CONSTANTS.PageName.CHECKOUT);
                break;
            }
          },
          child: Container(
            color: PRESENTATION.PRIMARY_COLOR,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _leftText[_basketBottomBarType],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: BlocBuilder<BlocCart, Cart>(
                      builder: (BuildContext context, Cart cart) {
                        var cartLength = cart.length;
                        var _rightText;
                        switch (_basketBottomBarType) {
                          case BasketBottomBarType.TO_BASKET:
                            _rightText = (cartLength == 1)
                                ? "Contains $cartLength item"
                                : "Contains $cartLength items";
                            break;
                          case BasketBottomBarType.TO_CHECKOUT:
                            _rightText = cart.total.toString();
                            break;
                        }

                        return Text(
                          _rightText,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: Icon(
                      PRESENTATION.Font_awesome_icons.right_open,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
