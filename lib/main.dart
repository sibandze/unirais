import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './bloc/_bloc.dart';
import './bottom_nav_bar_options/_bottom_nav_bar_options.dart';
import './const/_const.dart' as CONSTANTS;
import './getting_started/getting_started_screen.dart';
import './home_nav_bar.dart';
import './presentation/_presentation.dart' as PRESENTATION;
import './splashscreen/_splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(UniRaisApp());
}

/// This Widget is the main application widget.
class UniRaisApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BlocCategories>(
          create: (BuildContext context) => BlocCategories(),
        ),
        BlocProvider<BlocCart>(
          create: (BuildContext context) => BlocCart(),
        ),
        BlocProvider<BlocAuthentication>(
          create: (BuildContext context) => BlocAuthentication(),
        ),
        BlocProvider<BlocProducts>(
          create: (BuildContext context) => BlocProducts(),
        ),
        BlocProvider<BlocOrder>(
          create: (BuildContext context) => BlocOrder(),
        ),
        BlocProvider<BlocAddress>(
          create: (BuildContext context) => BlocAddress(),
        ),
        BlocProvider<BlocUniversity>(
          create: (BuildContext context) => BlocUniversity(),
        ),
      ],
      child: MaterialApp(
        //debugShowCheckedModeBanner: false,

        title: CONSTANTS.APP_NAME,
        home: UniRaisAppHome(),
        theme: ThemeData(
          //scaffoldBackgroundColor: PRESENTATION.BACKGROUND_COLOR,
          appBarTheme: AppBarTheme(
            color: PRESENTATION.BACKGROUND_COLOR,
          ),
          primaryColor: Colors.white,
          fontFamily: 'Poppins',
          textTheme: TextTheme(
            bodyText2: TextStyle(
              color: PRESENTATION.BODY_TEXT_COLOR,
            ),
          ),
        ),
        routes: {
          CONSTANTS.PageName.COMING_SOON: (context) => ComingSoonPage(),
          CONSTANTS.PageName.PRODUCT_TYPE_EACH: (context) =>
              ProductTypeEachPage(),
          CONSTANTS.PageName.CATEGORY_VIEW_ALL: (context) =>
              CategoryViewAllPage(),
          CONSTANTS.PageName.BASKET: (context) => BasketPage(),
          CONSTANTS.PageName.CHECKOUT: (context) => CheckoutPage(),
        },
      ),
    );
  }
}

class UniRaisAppHome extends StatefulWidget {
  final int selectedNavBarOption;

  UniRaisAppHome({Key key, this.selectedNavBarOption}) : super(key: key);

  @override
  _UniRaisAppHomeState createState() => _UniRaisAppHomeState();
}

class _UniRaisAppHomeState extends State<UniRaisAppHome> {
  BlocAuthentication _authenticationBloc;

  int get _selectedNavBarOption => widget.selectedNavBarOption;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<BlocAuthentication>(context);
    _authenticationBloc.add(BlocEventAuthenticationAppStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocAuthentication, BlocStateAuthentication>(
      bloc: _authenticationBloc,
      builder:
          (BuildContext context, BlocStateAuthentication authenticationState) {
        if (authenticationState is BlocStateAuthenticationUninitialized ||
            authenticationState is BlocStateAuthenticationLoading)
          return SplashScreen();
        else if (authenticationState is BlocStateAuthenticationAuthenticated)
          return (_selectedNavBarOption == null)
              ? NavBarHome()
              : NavBarHome(
                  selectedIndex: _selectedNavBarOption,
                );
        else if (authenticationState is BlocStateAuthenticationUnauthenticated)
          return GettingStartScreen();
        return Container();
      },
    );
  }
}
