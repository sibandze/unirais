import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unirais/bloc/_bloc.dart';
import 'package:unirais/bottom_nav_bar_options/profile/pages/address_exposed_page.dart';
import 'package:unirais/model/app/_app.dart';
import 'package:unirais/util/_util.dart';

import './../../../presentation/_presentation.dart' as PRESENTATION;

const _PAGE_TITLE = "Saved delivery addresses";

class DeliveryAddressPage extends StatefulWidget {
  @override
  _DeliveryAddressPageState createState() => _DeliveryAddressPageState();
}

class _CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 24,
        top: 12,
        bottom: 12,
      ),
      decoration: BoxDecoration(
        boxShadow: kElevationToShadow[4],
        color: PRESENTATION.BACKGROUND_COLOR,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            child: Icon(
              PRESENTATION.Font_awesome_icons.menu,
            ),
            onTap: () async {
              Scaffold.of(context).openDrawer();
            },
          ),
          SizedBox(
            width: 24,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _PAGE_TITLE,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DeliveryAddressPageState extends State<DeliveryAddressPage> {
  BlocAddress _addressBloc;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _CustomAppBar(),
          Expanded(
            child: BlocBuilder<BlocAddress, BlocStateAddress>(
              bloc: _addressBloc,
              builder: (BuildContext context, BlocStateAddress state) {
                if (state is BlocStateAddressInitial ||
                    state is BlocStateAddressFetching) {
                  return Center(
                    child: Text('Loading..'),
                  );
                } else if (state is BlocStateAddressFetchingFailure) {
                  return Center(
                    child: Text('Failed to get your addresses..'),
                  );
                } else if (state is BlocStateAddressFetchingSuccess) {
                  List<Address> _addresses = state.addresses;
                  if (_addresses.isEmpty) {
                    return Center(
                      child: Text('Empty..'),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                    itemCount: _addresses.length,
                    itemBuilder: (BuildContext context, int index) {
                      Address _address = _addresses[index];
                      return (index == 0)
                          ? Column(
                              children: <Widget>[
                                SizedBox(height: 18),
                                AddressWidget(
                                  address: _address,
                                ),
                              ],
                            )
                          : AddressWidget(
                              address: _address,
                            );
                    },
                  );
                } else {
                  return Container();
                }
              },
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
              onPressed: () {
                push(context, AddressExposedPage());
              },
              child: Text(
                'Add new address',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(16),
              color: PRESENTATION.PRIMARY_COLOR,
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _addressBloc = BlocProvider.of<BlocAddress>(context);
    _addressBloc.add(BlocEventAddressFetch());
    super.initState();
  }
}

class AddressWidget extends StatelessWidget {
  final Address address;

  AddressWidget({Key key, this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        push(
            context,
            AddressExposedPage(
              address: address,
            ));
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 24,
        ),
        decoration: BoxDecoration(
          boxShadow: kElevationToShadow[4],
          color: PRESENTATION.BACKGROUND_COLOR,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ListTile(
          trailing: Icon(
            Icons.arrow_forward_ios,
          ),
          leading: Icon(Icons.place),
          title: Text(address.savedAs),
          subtitle: Text(
            address.address,
            maxLines: 2,
            softWrap: true,
          ),
        ),
      ),
    );
  }
}
