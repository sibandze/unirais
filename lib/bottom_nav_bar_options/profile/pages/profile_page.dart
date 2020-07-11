import 'package:flutter/material.dart';

import './../../../const/_const.dart' as CONSTANTS;
import './../../../presentation/_presentation.dart' as PRESENTATION;
import './../custom_widgets/_custom_widgets.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _CustomAppBar(),
        Expanded(
          child: ListView(
            children: <Widget>[
              UserDetailsWidget(),
              SizedBox(
                height: 24,
              ),
              AccountDetailsWidget(),
              SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
        Row(),
      ],
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: kElevationToShadow[4],
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            PRESENTATION.PRIMARY_COLOR.withOpacity(0.9),
            PRESENTATION.PRIMARY_COLOR,
          ],
        ),
      ),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
            left: 24,
            top: 8,
            bottom: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InkWell(
                child: Icon(
                  PRESENTATION.Font_awesome_icons.menu,
                  color: PRESENTATION.BACKGROUND_COLOR,
                ),
                onTap: () async {
                  Scaffold.of(context).openDrawer();
                },
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      CONSTANTS.DevConstants.USER_NAME,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: PRESENTATION.BACKGROUND_COLOR,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton(
                color: PRESENTATION.BACKGROUND_COLOR,
                onSelected: (result) {
                  print(result);
                },
                icon: Icon(
                  Icons.more_vert,
                  color: PRESENTATION.BACKGROUND_COLOR,
                ),
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  const PopupMenuItem(
                    value: 'Notifications',
                    child: ListTile(
                      leading: Icon(Icons.notifications),
                      title: Text('Notifications'),
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'Other',
                    child: Text('Other'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*
SizedBox(
  height: 20,
),
Padding(
  padding: const EdgeInsets.symmetric(
    horizontal: 24.0,
  ),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'GOLD',
              style: TextStyle(
                  fontSize: 20,
                  color: PRESENTATION.BACKGROUND_COLOR,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              'Member level',
              style: TextStyle(
                fontSize: 13,
                color: PRESENTATION.BACKGROUND_COLOR,
              ),
            ),
          ],
        ),
        flex: 1,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
        ),
        child: Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            color: PRESENTATION.BACKGROUND_COLOR,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/images/logo.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '196',
              style: TextStyle(
                  fontSize: 20,
                  color: PRESENTATION.BACKGROUND_COLOR,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              'Member points',
              style: TextStyle(
                fontSize: 13,
                color: PRESENTATION.BACKGROUND_COLOR,
              ),
            ),
          ],
        ),
        flex: 1,
      ),
    ],
  ),
),
SizedBox(
  height: 36,
),
Padding(
  padding: EdgeInsets.symmetric(
    horizontal: 24,
  ),
  child: LinearProgressIndicator(
    value: 17.0 / 24.0,
  ),
),
Padding(
  padding: EdgeInsets.symmetric(
    horizontal: 24,
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Text(
        'Progress to next level',
        style: TextStyle(
          color: PRESENTATION.BACKGROUND_COLOR,
          fontSize: 16,
        ),
      ),
      Text(
        '17/24',
        style: TextStyle(
          color: PRESENTATION.BACKGROUND_COLOR,
          fontSize: 16,
        ),
      ),
    ],
  ),
)
*/
