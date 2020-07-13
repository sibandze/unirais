import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unirais/model/_model.dart';
import './../../../bloc/_bloc.dart';
import './../../../presentation/presentation_constants.dart' as PRESENTATION;
import './../../../util/_util.dart';

class OrderDetailsPage extends StatefulWidget {
  final String orderNumber;

  const OrderDetailsPage({Key key, @required this.orderNumber})
      : super(key: key);

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  String get _orderNumber => widget.orderNumber;
  BlocOrder _blocOrder;

  //BlocUniversity _blocUniversity;
  //BlocResidence _blocResidence;
  Order _order;

  @override
  void initState() {
    _blocOrder = BlocProvider.of<BlocOrder>(context);
    _blocOrder.add(BlocOrderEventFetchOrder(orderNumber: _orderNumber));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order #$_orderNumber Details',
          maxLines: 1,
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<BlocOrder, BlocOrderState>(
            listener: (BuildContext context, BlocOrderState state) async {
              if (state is BlocOrderStateFetchingOrderSuccess) {
                setState(() {
                  _order = state.order;
                });
              }
            },
          ),
        ],
        child: (_order != null)
            ? Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            boxShadow: kElevationToShadow[8],
                            color: PRESENTATION.BACKGROUND_COLOR,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Order number',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  Text(
                                    'Order status',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '#$_orderNumber',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Chip(
                                    backgroundColor: _itemColor,
                                    label: Text(
                                      _order.orderState.state.toUpperCase(),
                                      style: TextStyle(
                                        color: PRESENTATION.BACKGROUND_COLOR,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                      ),
                                    ),
                                    padding: EdgeInsets.all(4),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            boxShadow: kElevationToShadow[8],
                            color: PRESENTATION.BACKGROUND_COLOR,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Delivery details',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              SizedBox(height: 12),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      "Deliver address",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: PRESENTATION.TEXT_LIGHT_COLOR,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "322",
                                        ),
                                        Text(
                                          "Uni 1 Res 2",
                                        ),
                                        Text(
                                          "University 1",
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      "Delivery time",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: PRESENTATION.TEXT_LIGHT_COLOR,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(formatDateTime(DateTime.now())),

                                    /// TODO: get delivery time
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      "Delivery note",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: PRESENTATION.TEXT_LIGHT_COLOR,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text('My delivery note'),

                                    /// TODO: get delivery note
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            boxShadow: kElevationToShadow[8],
                            color: PRESENTATION.BACKGROUND_COLOR,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: Text(
                                  'Order items',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children:
                                      _order.orderItems.map((OrderItem e) {
                                    return ListTile(
                                      leading: Container(
                                        child: Row(
                                          children: <Widget>[
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                e.product.appUrlQualifiedImgUrl,
                                                fit: BoxFit.contain,
                                                //height: 80.0,
                                                //width: 80.0,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text("${e.quantity} x"),
                                          ],
                                        ),
                                        width: 92,
                                      ),
                                      title: Text(
                                        e.product.name,
                                        style: TextStyle(
                                          fontSize: 16,
                                          //   fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      trailing: Text(
                                        e.product.price.toString(),
                                        style: TextStyle(
                                          color: PRESENTATION.PRIMARY_COLOR,
                                          fontSize: 16,
                                          //   fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xff1d2340),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    padding: EdgeInsets.all(24.0),
                    child: RaisedButton(
                      onPressed: () async {
                        //await submitChanges(); TODO: cancel order
                      },
                      child: Text(
                        'Cancel Order',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: PRESENTATION.BACKGROUND_COLOR,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(16),
                      color: Colors.red,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        PRESENTATION.PRIMARY_COLOR,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Color get _itemColor {
    Color value = Colors.white;

    if (_order.orderState is PendingOrder) {
      value = Colors.grey;
    } else if (_order.orderState is ConfirmedOrder) {
      value = Colors.blue;
    } else if (_order.orderState is CancelledOrder) {
      value = Colors.red;
    } else if (_order.orderState is DeliveredOrder) {
      value = Colors.green;
    }
    return value;
  }
}
