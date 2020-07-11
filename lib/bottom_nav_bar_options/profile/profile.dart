import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './../../bloc/_bloc.dart';
import './../../const/_const.dart' as CONSTANTS;
import './../../main.dart';
import './../../presentation/_presentation.dart' as PRESENTATION;
import './../../util/_util.dart';
import './custom_widgets/_custom_widgets.dart';
import './pages/_pages.dart';

int _selectedOption = 0;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Widget> _drawerOption = [
    Profile(),
    WalletPage(),
    NotificationsPage(),
    DeliveryAddressPage(),
    InviteAndEarnPage(),
    SecurityAndPrivacyPage(),
    HelpPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _Drawer(
        page: this,
      ),
      body: _drawerOption[_selectedOption],
    );
  }

  void changeSelectedPage(int i) async {
    setState(() {
      _selectedOption = i;
    });
  }
}

class _Drawer extends StatelessWidget {
  final _ProfilePageState _page;

  const _Drawer({Key key, page})
      : this._page = page,
        super(key: key);

  void onClick(int i, BuildContext _context) async {
    _page.changeSelectedPage(i);
    Navigator.pop(_context);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    BlocAuthentication _authBloc = BlocProvider.of<BlocAuthentication>(context);

    return Drawer(
      //style:,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  PRESENTATION.PRIMARY_COLOR.withOpacity(0.8),
                  PRESENTATION.PRIMARY_COLOR,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: PRESENTATION.BACKGROUND_COLOR,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  CONSTANTS.DevConstants.USER_NAME,
                  style: TextStyle(
                    fontSize: 16,
                    color: PRESENTATION.BACKGROUND_COLOR,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      CONSTANTS.DevConstants.USER_LEVEL,
                      style: TextStyle(
                        fontSize: 16,
                        color: PRESENTATION.BACKGROUND_COLOR,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          ListTile(
            leading: (_selectedOption == 0)
                ? Icon(
                    PRESENTATION.Font_awesome_icons.user,
                    color: PRESENTATION.PRIMARY_COLOR,
                  )
                : Icon(
                    PRESENTATION.Font_awesome_icons.user,
                  ),
            title: (_selectedOption == 0)
                ? Text(
                    'My account',
                    style: TextStyle(
                      color: PRESENTATION.PRIMARY_COLOR,
                    ),
                  )
                : Text(
                    'My account',
                  ),
            onTap: () async {
              onClick(0, context);
            },
          ),
          ListTile(
            leading: (_selectedOption == 1)
                ? Icon(
                    PRESENTATION.Font_awesome_icons.gwallet,
                    color: PRESENTATION.PRIMARY_COLOR,
                  )
                : Icon(PRESENTATION.Font_awesome_icons.gwallet),
            title: (_selectedOption == 1)
                ? Text(
                    'Wallet',
                    style: TextStyle(
                      color: PRESENTATION.PRIMARY_COLOR,
                    ),
                  )
                : Text(
                    'Wallet',
                  ),
            onTap: () async {
              onClick(1, context);
            },
          ),
          ListTile(
            leading: (_selectedOption == 2)
                ? Icon(
                    Icons.notifications,
                    color: PRESENTATION.PRIMARY_COLOR,
                  )
                : Icon(Icons.notifications),
            title: (_selectedOption == 2)
                ? Text(
                    'Notifications',
                    style: TextStyle(
                      color: PRESENTATION.PRIMARY_COLOR,
                    ),
                  )
                : Text(
                    'Notifications',
                  ),
            onTap: () async {
              onClick(2, context);
            },
          ),
          ListTile(
            leading: (_selectedOption == 3)
                ? Icon(
                    Icons.home,
                    color: PRESENTATION.PRIMARY_COLOR,
                  )
                : Icon(
                    Icons.home,
                  ),
            title: (_selectedOption == 3)
                ? Text(
                    'Delivery address',
                    style: TextStyle(
                      color: PRESENTATION.PRIMARY_COLOR,
                    ),
                  )
                : Text('Delivery address'),
            onTap: () async {
              onClick(3, context);
            },
          ),
          ListTile(
            leading: (_selectedOption == 4)
                ? Icon(
                    PRESENTATION.Font_awesome_icons.plus_circled,
                    color: PRESENTATION.PRIMARY_COLOR,
                  )
                : Icon(PRESENTATION.Font_awesome_icons.plus_circled),
            title: (_selectedOption == 4)
                ? Text(
                    'Invite and earn',
                    style: TextStyle(
                      color: PRESENTATION.PRIMARY_COLOR,
                    ),
                  )
                : Text('Invite and earn'),
            onTap: () async {
              onClick(4, context);
            },
          ),
          ListTile(
            leading: (_selectedOption == 5)
                ? Icon(
                    Icons.security,
                    color: PRESENTATION.PRIMARY_COLOR,
                  )
                : Icon(Icons.security),
            title: (_selectedOption == 5)
                ? Text(
                    'Security and privacy',
                    style: TextStyle(
                      color: PRESENTATION.PRIMARY_COLOR,
                    ),
                  )
                : Text('Security and privacy'),
            onTap: () async {
              onClick(5, context);
            },
          ),
          ListTile(
            leading: (_selectedOption == 6)
                ? Icon(
                    PRESENTATION.Font_awesome_icons.help,
                    color: PRESENTATION.PRIMARY_COLOR,
                  )
                : Icon(PRESENTATION.Font_awesome_icons.help),
            title: (_selectedOption == 6)
                ? Text(
                    'Help',
                    style: TextStyle(
                      color: PRESENTATION.PRIMARY_COLOR,
                    ),
                  )
                : Text('Help'),
            onTap: () async {
              onClick(6, context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: PRESENTATION.TITLE_TEXT_COLOR,
            ),
            title: Text(
              'Logout',
              style: TextStyle(
                color: PRESENTATION.TITLE_TEXT_COLOR,
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: () {
              _authBloc.add(BlocEventAuthenticationLoggedOut());
              pushAndRemoveUntil(context, UniRaisAppHome(), false);
            },
          ),
          AboutApp(),
        ],
      ),
    );
  }
}
