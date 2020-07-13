import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animations/loading_animations.dart';

import './../../../bloc/_bloc.dart';
import './../../../const/_const.dart' as CONSTANTS;
import './../../../model/_model.dart';
import './../../../model/shop/_shop.dart';
import './../../../presentation/_presentation.dart' as PRESENTATION;
import './../../../util/_util.dart';
import './../custom_widgets/_custom_widgets.dart';
import '../../../main.dart' show UniRaisAppHome;

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  BlocCart _cartBloc;
  BlocOrder _orderBloc;
  String orderNote;
  Address selectedLocation;

  @override
  void dispose() {
    super.dispose();
  }

  void placeOrder(Cart cart) {
    _orderBloc.add(
      BlocOrderEventCreate(
        order: Order.newOrder(
          cart: cart,
          deliveryAddress: "Address",
          deliveryNote: 'Note',
        ),
      ),
    );
  }

  @override
  void initState() {
    _cartBloc = BlocProvider.of<BlocCart>(context);
    _cartBloc.add(BlocCartEvent());

    _orderBloc = BlocProvider.of<BlocOrder>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlocOrder, BlocOrderState>(
      listener: (BuildContext context, BlocOrderState state) async {
        if (state is BlocOrderStateCUDSuccess) {
          _cartBloc.add(BlocCartEvent.deleteAll());
          await Future.delayed(Duration(
            milliseconds: CONSTANTS.LOADING_DELAY_TIME_SHORT,
          ));
          pushAndRemoveUntil(
            context,
            UniRaisAppHome(
              selectedNavBarOption: 2,
            ),
            false,
          );
        }
        else if (state is BlocOrderStateCUDFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('Your order was not successful!'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(CONSTANTS.CHECKOUT_TITLE),
        ),
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      SizedBox(
                        height: 12,
                      ),
                      _DeliveryAddressWidget(),
                      SizedBox(
                        height: 12,
                      ),

                      ///ApplyPromoCodeWidget(),
                      ///WalletWidget(),
                    ],
                  ), // TODO
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
                        ? InkWell(
                      onTap: () {
                        if (cart.isNotEmpty) placeOrder(cart);
                      },
                      child: Container(
                        color: PRESENTATION.PRIMARY_COLOR,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Place order',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                        : Container();
                  },
                ),
              ],
            ),
            BlocBuilder<BlocOrder, BlocOrderState>(
              bloc: _orderBloc,
              builder: (BuildContext context, BlocOrderState state) {
                if (state is BlocOrderStateCUDProcessing)
                  return Container(
                    color: PRESENTATION.BACKGROUND_COLOR.withOpacity(0.75),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          LoadingBouncingGrid.circle(
                            inverted: true,
                            borderColor: Colors.white,
                            backgroundColor: Colors.transparent,
                          ),
                          Text(
                            "Placing your order...",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: PRESENTATION.PRIMARY_COLOR,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                else if (state is BlocOrderStateCUDSuccess)
                  return Container(
                    color: PRESENTATION.BACKGROUND_COLOR,
                    padding: EdgeInsets.all(48),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Your order was successfully placed. Please wait...",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: PRESENTATION.PRIMARY_COLOR,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );

                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DeliveryAddressWidget extends StatefulWidget {
  @override
  __DeliveryAddressWidgetState createState() => __DeliveryAddressWidgetState();
}

class __DeliveryAddressWidgetState extends State<_DeliveryAddressWidget> {
  BlocAddress _blocAddress;
  BlocDeliveryTime _blocDeliveryTime;
  List<Address> _addresses;
  List<DeliveryTime> _deliveryTimes;
  bool _addressFirstLoad = true;
  Address selectedAddress;

  DeliveryTime selectDeliveryTime;

  @override
  void initState() {
    _blocAddress = BlocProvider.of<BlocAddress>(context);
    _blocDeliveryTime = BlocProvider.of<BlocDeliveryTime>(context);
    _blocAddress.add(BlocEventAddressFetch());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<BlocDeliveryTime, BlocDeliveryTimeState>(
          listener: (BuildContext context, BlocDeliveryTimeState state) {
            if (state is BlocDeliveryTimeStateFetchingSuccess) {
              setState(() {
                if (state.deliveryTimes != null) {
                  _deliveryTimes = state.deliveryTimes;
                  if (_deliveryTimes.isNotEmpty) {
                    selectDeliveryTime = _deliveryTimes[0];
                  }
                } else {
                  _deliveryTimes = [];
                }
              });
            }
          },
        ),
        BlocListener<BlocAddress, BlocStateAddress>(
          listener: (BuildContext context, BlocStateAddress state) {
            if (state is BlocStateAddressFetchingSuccess) {
              setState(() {
                if (state.addresses != null) {
                  _deliveryTimes = null;
                  _addresses = state.addresses;
                  if (_addresses.isNotEmpty) {
                    selectedAddress = _addresses[0];
                    _blocDeliveryTime.add(
                        BlocDeliveryTimeEventFetch(address: selectedAddress));
                  }
                } else {
                  _addresses = [];
                }
              });
            }
          },
        ),
      ],
      child: Column(
        children: <Widget>[
          Container(
            color: PRESENTATION.BACKGROUND_COLOR,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Deliver to",
                  style: TextStyle(
                    fontSize: 16,
                    color: PRESENTATION.TEXT_LIGHT_COLOR,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                BlocBuilder<BlocAddress, BlocStateAddress>(
                  bloc: _blocAddress,
                  builder: (BuildContext context, BlocStateAddress state) {
                    if (_addresses != null && _addresses.isNotEmpty) {
                      return DropdownButton<Address>(
                        isExpanded: true,
                        elevation: 16,
                        itemHeight: 80,
                        icon: Icon(Icons.arrow_drop_down),
                        underline: Container(
                          height: 0,
                        ),
                        selectedItemBuilder: (BuildContext context) =>
                            _addresses
                                .map<Widget>((Address address) =>
                                ListTile(
                                  leading: Icon(Icons.place),
                                  title: Text(
                                    address.savedAs,
                                  ),
                                  subtitle: Text(
                                    address.address,
                                  ),
                                ))
                                .toList(),
                        items: _addresses
                            .map<DropdownMenuItem<Address>>((Address address) {
                          return DropdownMenuItem<Address>(
                            value: address,
                            child: ListTile(
                              title: Text(
                                address.savedAs,
                              ),
                              subtitle: Text(
                                address.address,
                              ),
                            ),
                          );
                        }).toList(),
                        value: selectedAddress,
                        onChanged: (value) {
                          setState(() {
                            selectedAddress = value;
                          });
                        },
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          BlocBuilder<BlocDeliveryTime, BlocDeliveryTimeState>(
            builder: (BuildContext context, BlocDeliveryTimeState state) {
              if (_deliveryTimes != null &&
                  _deliveryTimes.isNotEmpty) {
                return Container(
                  color: PRESENTATION.BACKGROUND_COLOR,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Deliver time",
                        style: TextStyle(
                          fontSize: 16,
                          color: PRESENTATION.TEXT_LIGHT_COLOR,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      DropdownButton<DeliveryTime>(
                        isExpanded: true,
                        elevation: 16,
                        icon: Icon(Icons.arrow_drop_down),
                        underline: Container(
                          height: 0,
                        ),
                        selectedItemBuilder: (BuildContext context) =>
                            _deliveryTimes
                                .map<Widget>(
                                    (DeliveryTime deliveryTime) =>
                                    ListTile(
                                      leading: Icon(Icons.access_time),
                                      title: Text(
                                        formatDateTime(
                                            deliveryTime.deliveryTime),
                                      ),
                                    ))
                                .toList(),
                        items: _deliveryTimes
                            .map<DropdownMenuItem<DeliveryTime>>(
                                (DeliveryTime deliveryTime) {
                              return DropdownMenuItem<DeliveryTime>(
                                value: deliveryTime,
                                child: Text(
                                  formatDateTime(deliveryTime.deliveryTime),
                                ),
                              );
                            }).toList(),
                        value: selectDeliveryTime,
                        onChanged: (value) {
                          setState(() {
                            selectDeliveryTime = value;
                          });
                        },
                      ),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}

class ApplyPromoCodeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 12,
        right: 8,
        top: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                right: 8,
              ),
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                textInputAction: TextInputAction.next,
                style: TextStyle(
                  fontSize: 18.0,
                ),
                keyboardType: TextInputType.emailAddress,
                cursorColor: PRESENTATION.PRIMARY_COLOR,
                decoration: InputDecoration(
                  contentPadding: new EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  fillColor: Colors.white,
                  hintText: 'Enter PROMO Code',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.0),
                    borderSide: BorderSide(
                      color: PRESENTATION.PRIMARY_COLOR,
                      width: 2.0,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                ),
              ),
            ),
          ),
          RaisedButton(
            onPressed: () {},
            child: Text(
              'APPLY',
              style: PRESENTATION.GETTING_STARTED_BUTTON_TEXT_STYLE,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 10,
            ),
            color: PRESENTATION.PRIMARY_COLOR,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}

class WalletWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 12,
        right: 8,
        top: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                right: 8,
              ),
              child: Text(
                "You have R22 points available",
                style: PRESENTATION.GETTING_STARTED_BUTTON_TEXT_STYLE,
              ),
            ),
          ),
          RaisedButton(
            onPressed: () {},
            child: Text(
              'USE',
              style: PRESENTATION.GETTING_STARTED_BUTTON_TEXT_STYLE,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 10,
            ),
            color: PRESENTATION.PRIMARY_COLOR,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
