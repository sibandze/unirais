import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './../../../bloc/_bloc.dart';
import './../../../model/shop/_shop.dart';
import './../../../presentation/_presentation.dart' as PRESENTATION;

class PlusMinusInputTextWidget extends StatefulWidget {
  final CartItem cartItem;

  PlusMinusInputTextWidget({@required this.cartItem});

  @override
  _PlusMinusInputTextWidgetState createState() =>
      _PlusMinusInputTextWidgetState();
}

class _PlusMinusInputTextWidgetState extends State<PlusMinusInputTextWidget> {
  BlocCart _cartBloc;
  TextEditingController _inputTextBoxController;

  CartItem get _cartItem => widget.cartItem;

  @override
  void initState() {
    _cartBloc = BlocProvider.of<BlocCart>(context);
    _inputTextBoxController = (_cartItem != null)
        ? TextEditingController(text: _cartItem.quantity.toString())
        : TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _inputTextBoxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 132,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          minusButton(),
          inputTextBox(),
          plusButton(),
        ],
      ),
    );
  }

  Widget minusButton() {
    return IconButton(
      icon: Icon(
        PRESENTATION.Font_awesome_icons.minus_circled,
        color: PRESENTATION.PRIMARY_COLOR,
        size: 14,
      ),
      onPressed: () async {
        if (_cartItem.quantity > 0) {
          _cartItem.decrease();
          _inputTextBoxController.text = (_cartItem.quantity).toString();
          _cartBloc.add(BlocCartEvent.update(_cartItem));
        }
      },
    );
  }

  Widget plusButton() {
    return IconButton(
      icon: Icon(
        PRESENTATION.Font_awesome_icons.plus_circled,
        color: PRESENTATION.PRIMARY_COLOR,
        size: 14,
      ),
      onPressed: () async {
        var val = int.parse(_inputTextBoxController.text) + 1;
        if (val < 100) {
          _inputTextBoxController.text = (val.toString());
          _cartItem.increment();
          _cartBloc.add(BlocCartEvent.update(_cartItem));
        }
      },
    );
  }

  Widget inputTextBox() {
    return Container(
      width: 24,
      child: BlocListener<BlocCart, Cart>(
        bloc: _cartBloc,
        listener: (BuildContext context, Cart state) async {
          var _item = state.getCartItem(_cartItem.product);
          if (_item != null) {
            var _quantity = state.getCartItem(_cartItem.product).quantity;
            _inputTextBoxController.text = _quantity.toString();
            _cartItem.quantity = _quantity;
          }
        },
        child: TextFormField(
          controller: _inputTextBoxController,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          cursorColor: PRESENTATION.PRIMARY_COLOR,
          onChanged: (String value) async {
            String validator = "0123456789";
            bool valid = true;
            String cValue = "";
            for (var a in value.split('')) {
              if (validator.contains(a)) {
                cValue += a;
              } else
                valid = false;
            }
            if (!valid) {
              _inputTextBoxController.text = cValue;
            }
            if (_inputTextBoxController.text.length > 0) {
              if (int.parse(_inputTextBoxController.text) > 99) {
                _inputTextBoxController.text = '99';
              }
              _cartItem.quantity = int.parse(_inputTextBoxController.text);
              _cartBloc.add(BlocCartEvent.update(_cartItem));
            }
          },
        ),
      ),
    );
  }
}
