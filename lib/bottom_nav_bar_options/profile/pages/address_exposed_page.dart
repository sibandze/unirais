import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unirais/bloc/_bloc.dart';
import 'package:unirais/model/_model.dart';
import 'package:unirais/presentation/_presentation.dart' as PRESENTATION;

const _PAGE_TITLE = "Saved address";

class AddressExposedPage extends StatefulWidget {
  final Address address;

  const AddressExposedPage({Key key, this.address}) : super(key: key);

  @override
  _AddressExposedPageState createState() => _AddressExposedPageState();
}

class _AddressExposedPageState extends State<AddressExposedPage> {
  bool firstLoad = true;

  Address get _address => widget.address;
  BlocAddress _addressBloc;
  BlocUniversity _universityBloc;
  TextEditingController _savedAsTextController;
  TextEditingController _roomNumberController;
  String _location;
  double _mapHeight = 0, _scrollOffset = 0;
  University selectedUniversity;
  Residence selectedResidence;

  //ScrollController _scrollController;
  @override
  void initState() {
    _addressBloc = BlocProvider.of<BlocAddress>(context);
    _universityBloc = BlocProvider.of<BlocUniversity>(context);
    _universityBloc.add(BlocUniversityEventFetch());
    //_scrollController = ScrollController();
    _roomNumberController = (_address != null)
        ? TextEditingController(text: _address.roomNumber)
        : TextEditingController();
    _savedAsTextController = (_address != null)
        ? TextEditingController(text: _address.savedAs)
        : TextEditingController();
    super.initState();
  }

  Future deleteAddress() async {
    _addressBloc.add(BlocEventAddressCUDDelete(_address));
  }

  Future submitChanges() async {
    if (_savedAsTextController.text.trim().isNotEmpty &&
        selectedUniversity != null &&
        selectedResidence != null) {
      Address address = (_address == null)
          ? Address(
              residence: selectedResidence.id,
              university: selectedUniversity.id,
              roomNumber: _roomNumberController.text,
              long: selectedResidence.long,
              lat: selectedResidence.lat,
              savedAs: _savedAsTextController.text,
              address: (_roomNumberController.text.trim().isNotEmpty
                      ? ("${_roomNumberController.text}, ")
                      : "") +
                  "${selectedResidence.name}, ${selectedUniversity.name}")
          : Address(
              residence: selectedResidence.id,
              university: selectedUniversity.id,
              roomNumber: _roomNumberController.text,
              id: _address.id,
              long: selectedResidence.long,
              lat: selectedResidence.lat,
              savedAs: _savedAsTextController.text,
              address: (_roomNumberController.text.trim().isNotEmpty
                      ? ("${_roomNumberController.text}, ")
                      : "") +
                  "${selectedResidence.name}, ${selectedUniversity.name}",
            );
      BlocEventAddressCUD event = (_address == null)
          ? BlocEventAddressCUDCreate(address)
          : BlocEventAddressCUDUpdate(address);
      _addressBloc.add(event);
    }
  }

  @override
  Widget build(BuildContext context) {
    _mapHeight = 0.33 * (MediaQuery.of(context)).size.height + 24;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _PAGE_TITLE,
          style: TextStyle(/*color: PRESENTATION.BACKGROUND_COLOR*/),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.gps_fixed, /*color: PRESENTATION.BACKGROUND_COLOR*/
            ),
            onPressed: () {},
          ),
          if (_address != null)
            IconButton(
              icon: Icon(
                Icons.delete, /*color: PRESENTATION.BACKGROUND_COLOR*/
              ),
              onPressed: () async {
                await deleteAddress();
              },
            ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            /// TODO: add map
            height: _mapHeight - _scrollOffset,
            //color: PRESENTATION.PRIMARY_COLOR,
            child: Center(
                //child: Text('Map goes here'),
                ),
          ),
          Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  /// TODO: add scroll listener and update map center
                  children: <Widget>[
                    SizedBox(
                      height: (_mapHeight - 24),
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 12.0,
                                bottom: 10,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 2,
                                    width: 48,
                                    color: PRESENTATION.PRIMARY_COLOR,
                                  )
                                ],
                              ),
                            ),
                            Text(
                              'Select location',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: PRESENTATION.BACKGROUND_COLOR,
                              ),
                            ),
                            Container(
                              width: 48,
                              height: 1,
                              color: PRESENTATION.BACKGROUND_COLOR,
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            MultiBlocListener(
                              listeners: [
                                BlocListener<BlocAddress, BlocStateAddress>(
                                  listener: (BuildContext context,
                                      BlocStateAddress state) {
                                    if (state is BlocStateAddressCUDSuccess) {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                                BlocListener<BlocUniversity,
                                    BlocUniversityState>(
                                  bloc: _universityBloc,
                                  listener: (BuildContext context,
                                      BlocUniversityState state) async {
                                    if (_address != null &&
                                        firstLoad &&
                                        state
                                            is BlocUniversityStateFetchingSuccess) {
                                      List<University> _uniList =
                                          state.universities;
                                      for (University uni in _uniList) {
                                        if (uni.id == _address.university) {
                                          selectedUniversity = uni;
                                          break;
                                        }
                                      }
                                      for (Residence res
                                          in selectedUniversity.residences) {
                                        if (res.id == _address.residence) {
                                          selectedResidence = res;
                                          break;
                                        }
                                      }
                                      setState(() {});
                                    }
                                  },
                                ),
                              ],
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'University',
                                        style: TextStyle(
                                          color: PRESENTATION.BACKGROUND_COLOR,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      BlocBuilder<BlocUniversity,
                                          BlocUniversityState>(
                                        bloc: _universityBloc,
                                        builder: (BuildContext context,
                                            BlocUniversityState state) {
                                          if (state is BlocUniversityStateInitial ||
                                              state is BlocUniversityStateFetching) {
                                          } else if (state
                                          is BlocUniversityStateFetchingFailure) {
                                          } else if (state
                                          is BlocUniversityStateFetchingSuccess) {
                                            List<University> _uniList =
                                                state.universities;
                                            if (_uniList.isNotEmpty) {
                                              return Expanded(
                                                child:
                                                    DropdownButton<University>(
                                                  isExpanded: true,
                                                  dropdownColor: PRESENTATION
                                                      .PRIMARY_COLOR,
                                                  elevation: 16,
                                                  icon: Icon(
                                                      Icons.arrow_drop_down),
                                                  underline: Container(
                                                    height: 1,
                                                    color: PRESENTATION
                                                        .PRIMARY_COLOR,
                                                  ),
                                                  items: _uniList.map<
                                                          DropdownMenuItem<
                                                              University>>(
                                                      (University uni) {
                                                    return DropdownMenuItem<
                                                        University>(
                                                      value: uni,
                                                      child: Text(
                                                        uni.name,
                                                        style: TextStyle(
                                                          color: PRESENTATION
                                                              .BACKGROUND_COLOR,
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  value: selectedUniversity,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectedUniversity =
                                                          value;
                                                      selectedResidence =
                                                          selectedUniversity
                                                              .residences[0];
                                                    });
                                                  },
                                                ),
                                              );
                                            }
                                            return Container();
                                          }
                                          return Container();
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Residence',
                                        style: TextStyle(
                                          color: PRESENTATION.BACKGROUND_COLOR,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      if (selectedUniversity != null)
                                        Expanded(
                                          child: DropdownButton<Residence>(
                                            isExpanded: true,
                                            dropdownColor:
                                                PRESENTATION.PRIMARY_COLOR,
                                            elevation: 16,
                                            icon: Icon(Icons.arrow_drop_down),
                                            underline: Container(
                                              height: 1,
                                              color: PRESENTATION.PRIMARY_COLOR,
                                            ),
                                            items: ((selectedUniversity != null)
                                                    ? selectedUniversity
                                                        .residences
                                                    : <Residence>[])
                                                .map<
                                                        DropdownMenuItem<
                                                            Residence>>(
                                                    (Residence res) {
                                              return DropdownMenuItem<
                                                  Residence>(
                                                value: res,
                                                child: Text(
                                                  res.name,
                                                  style: TextStyle(
                                                    color: PRESENTATION
                                                        .BACKGROUND_COLOR,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            value: selectedResidence,
                                            onChanged: (value) {
                                              setState(() {
                                                selectedResidence = value;
                                              });
                                            },
                                          ),
                                        )
                                      else
                                        Expanded(
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            dropdownColor:
                                                PRESENTATION.PRIMARY_COLOR,
                                            elevation: 16,
                                            icon: Icon(Icons.arrow_drop_down),
                                            underline: Container(
                                              height: 1,
                                              color: PRESENTATION.PRIMARY_COLOR,
                                            ),
                                            items: [
                                              'Please select university..'
                                            ].map<DropdownMenuItem<String>>(
                                                (String res) {
                                              return DropdownMenuItem<String>(
                                                value: res,
                                                child: Text(
                                                  res,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: PRESENTATION
                                                        .TEXT_LIGHT_COLOR,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            value: 'Please select university..',
                                            onChanged: (value) {},
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(
                                      Icons.info,
                                      color: PRESENTATION.BACKGROUND_COLOR,
                                    ),
                                    onPressed: () {}),
                                Text(
                                  'Room number',
                                  style: TextStyle(
                                    color: PRESENTATION.BACKGROUND_COLOR,
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    style: TextStyle(
                                      color: PRESENTATION.BACKGROUND_COLOR,
                                    ),
                                    controller: _roomNumberController,
                                    decoration: InputDecoration(
                                      contentPadding: new EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                      ),
                                      hintText: 'Room number',
                                      hintStyle: TextStyle(
                                        color: PRESENTATION.TEXT_LIGHT_COLOR,
                                        fontSize: 13,
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: PRESENTATION.PRIMARY_COLOR,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Text(
                              'Save this address as'.toUpperCase(),
                              style: TextStyle(
                                color: Color(0xFF6b718c),
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: TextFormField(
                                    style: TextStyle(
                                      color: PRESENTATION.BACKGROUND_COLOR,
                                    ),
                                    controller: _savedAsTextController,
                                    decoration: InputDecoration(
                                      contentPadding: new EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                      ),
                                      hintText: 'Save as',
                                      hintStyle: TextStyle(
                                        fontSize: 13,
                                        color: PRESENTATION.TEXT_LIGHT_COLOR,
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: PRESENTATION.PRIMARY_COLOR,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 24,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Color(0xff1d2340),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: PRESENTATION.BACKGROUND_COLOR,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  padding: EdgeInsets.all(24.0),
                  child: RaisedButton(
                    onPressed: () async {
                      await submitChanges();
                    },
                    child: Text(
                      (_address == null) ? 'Add address' : 'Update address',
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
                    color: PRESENTATION.PRIMARY_COLOR,
                    textColor: Colors.white,
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