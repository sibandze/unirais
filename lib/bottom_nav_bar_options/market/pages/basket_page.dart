import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './../../../bloc/_bloc.dart';
import './../../../const/_const.dart' as CONSTANTS;
import './../../../model/_model.dart';
import './../../../presentation/_presentation.dart' as PRESENTATION;
import './../custom_widgets/_custom_widgets.dart';

class BasketPage extends StatefulWidget {
  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  BlocCart _cartBloc;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _cartBloc = BlocProvider.of<BlocCart>(context);
    _cartBloc.add(BlocCartEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CONSTANTS.BASKET_TITLE),
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: BlocBuilder<BlocCart, Cart>(
              builder: (BuildContext context, Cart cart) {
                return (cart.isNotEmpty)
                    ? ListView(
                        children: <Widget>[
                          SizedBox(
                            height: 12.0,
                          ),
                          Card(
                            color: PRESENTATION.PRIMARY_COLOR,
                            shadowColor: PRESENTATION.PRIMARY_COLOR,
                            elevation: 4,
                            child: _CartItemListWidget(),
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                        ],
                      )
                    : Container();
              },
            ),
          ),
          Card(
            color: PRESENTATION.PRIMARY_COLOR,
            shadowColor: PRESENTATION.PRIMARY_COLOR,
            elevation: 4,
            child: PaymentSummaryWidget(),
          ),
          SizedBox(
            height: 12.0,
          ),
          BlocBuilder<BlocCart, Cart>(
            bloc: _cartBloc,
            builder: (BuildContext context, Cart cart) {
              return (cart.isNotEmpty)
                  ? BasketBottomBar(BasketBottomBarType.TO_CHECKOUT)
                  : Container();
            },
          ),
        ],
      ),
    );
  }
}

class _CartItemListWidget extends StatefulWidget {
  @override
  __CartItemListWidgetState createState() => __CartItemListWidgetState();
}

class __CartItemListWidgetState extends State<_CartItemListWidget> {
  //BlocCart _cartBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          // TODO: add search field
          BlocBuilder<BlocCart, Cart>(
            //        bloc: _cartBloc,
            builder: (BuildContext context, Cart cart) {
              return Column(
                children: cart.cartItems
                    .map<Widget>(
                      (cartItem) => _CartItemWidget(
                        cartItem: cartItem,
                      ),
                    )
                    .toList(),
              );
            },
          ),
          SizedBox(
            height: 12.0,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    //_cartBloc = BlocProvider.of<BlocCart>(context);
    super.initState();
  }
}

class _CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const _CartItemWidget({Key key, this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 12,
        right: 8,
        top: 8,
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                cartItem.product.appUrlQualifiedImgUrl,
                fit: BoxFit.fitWidth,
                //height: 80.0,
                //width: 80.0,
              ),
            ),
            title: Text(
              cartItem.product.name,
              style: TextStyle(
                //   color: Colors.black87,
                fontSize: 18,
                //   fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              cartItem.product.price.toString(),
              style: TextStyle(
                color: PRESENTATION.PRIMARY_COLOR,
                fontSize: 16,
                //   fontWeight: FontWeight.w600,
              ),
            ),
            trailing: PlusMinusInputTextWidget(
              cartItem: cartItem,
            ),
          ),
          /*Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  cartItem.product.appUrlQualifiedImgUrl,
                  fit: BoxFit.fitWidth,
                  height: 80.0,
                  width: 80.0,
                ),
              ),
              SizedBox(
                width: 12.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      cartItem.product.name,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    Text(
                      cartItem.product.price.toString(),
                      style: TextStyle(
                        color: PRESENTATION.PRIMARY_COLOR,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PlusMinusInputTextWidget(
                  cartItem: cartItem,
                ),
              ),
            ],
          ),*/
        ],
      ),
    );
  }
}
