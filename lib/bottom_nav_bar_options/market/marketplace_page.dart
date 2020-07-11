import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animations/loading_animations.dart';

import './../../bloc/_bloc.dart';
import './../../const/_const.dart' as CONSTANTS;
import './../../model/_model.dart';
import './../../presentation/_presentation.dart' as PRESENTATION;
import './custom_widgets/_custom_widgets.dart';

class MarketPlacePage extends StatefulWidget {
  @override
  _MarketPlacePageState createState() => _MarketPlacePageState();
}

class _MarketPlacePageState extends State<MarketPlacePage> {
  BlocCart _cartBloc;
  BlocCategories _categoryBloc;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _cartBloc = BlocProvider.of<BlocCart>(context);
    _categoryBloc = BlocProvider.of<BlocCategories>(context);
    _cartBloc.add(BlocCartEvent());
    _categoryBloc.add(BlocEventCategoriesFetch(location: ''));

    /// TODO: get location

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _CustomAppBar(),
            Expanded(
              child: BlocBuilder<BlocCategories, BlocStateCategories>(
                bloc: _categoryBloc,
                builder: (BuildContext context,
                    BlocStateCategories categoriesState) {
                  Widget returnWidget;
                  if (categoriesState is BlocStateCategoriesUninitialized ||
                      categoriesState is BlocStateCategoriesFetching) {
                    returnWidget = Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          LoadingBouncingGrid.circle(
                            inverted: true,
                            borderColor: PRESENTATION.PRIMARY_COLOR,
                            backgroundColor: Colors.transparent,
                          ),
                          Text(
                            "Loading...",
                            style: PRESENTATION.PRODUCT_HEADING_TEXT_STYLE,
                          ),
                        ],
                      ),
                    );
                  } else if (categoriesState
                      is BlocStateCategoriesFetchingFailure) {
                    returnWidget = Center(
                      child: Text(
                        "Error",
                        style: PRESENTATION.PRODUCT_HEADING_TEXT_STYLE,
                      ),
                    );
                  } else if (categoriesState
                      is BlocStateCategoriesFetchingSuccess) {
                    List<ProductCategory> categories =
                        categoriesState.categories;
                    returnWidget = ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        if (index == 0)
                          return Column(
                            children: <Widget>[
                              SizedBox(
                                height: 12,
                              ),
                              _CategoryCard(
                                category: categories[index],
                                categories: categories,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                            ],
                          );
                        else
                          return Column(
                            children: <Widget>[
                              _CategoryCard(
                                category: categories[index],
                                categories: categories,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                            ],
                          );
                      },
                    );
                  }
                  return returnWidget;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 18,
        bottom: 4,
      ),
      decoration: BoxDecoration(
        boxShadow: kElevationToShadow[4],
        color: PRESENTATION.BACKGROUND_COLOR,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: CONSTANTS.SPLASH_LEFT_TEXT,
                    style: PRESENTATION.APPBAR_TEXT_LEFT_STYLE,
                    children: [
                      TextSpan(
                        text: CONSTANTS.SPLASH_CENTER_TEXT,
                        style: PRESENTATION.APPBAR_TEXT_RIGHT_STYLE,
                        children: [
                          TextSpan(
                            text: CONSTANTS.SPLASH_RIGHT_TEXT,
                            style: PRESENTATION.APPBAR_TEXT_LEFT_STYLE,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _InstitutionDropdownButton(),
              ],
            ),
          ),
          BasketWidget(),
        ],
      ),
    );
  }
}

class _InstitutionDropdownButton extends StatefulWidget {
  @override
  __InstitutionDropdownButtonState createState() =>
      __InstitutionDropdownButtonState();
}

class __InstitutionDropdownButtonState
    extends State<_InstitutionDropdownButton> {
  University selectedUniversity;
  BlocUniversity _universityBloc;
  bool firstLoad = true;

  /// TODO: set selectedUniversity to university set by user at sign up
  @override
  void initState() {
    _universityBloc = BlocProvider.of<BlocUniversity>(context);
    _universityBloc.add(FetchUniversities());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocUniversity, UniversityState>(
      bloc: _universityBloc,
      builder: (BuildContext context, UniversityState state) {
        if (state is InitialUniversityState || state is FetchUniversities) {
        } else if (state is FetchingUniversitiesFailure) {
        } else if (state is FetchingUniversitiesSuccess) {
          List<University> _uniList = state.universities;
          if (_uniList.isNotEmpty) {
            return DropdownButton<University>(
              isExpanded: true,
              elevation: 16,
              icon: Icon(Icons.arrow_drop_down),
              underline: Container(
                height: 1,
                color: PRESENTATION.PRIMARY_COLOR,
              ),
              items:
                  _uniList.map<DropdownMenuItem<University>>((University uni) {
                return DropdownMenuItem<University>(
                  value: uni,
                  child: Text(
                    uni.name,
                  ),
                );
              }).toList(),
              value: selectedUniversity,
              onChanged: (value) {
                setState(() {
                  selectedUniversity = value;
                });
              },
            );
          }
          return Container();
        }
        return Container();
      },
    );
  }
}

class _CategoryCard extends StatefulWidget {
  final ProductCategory category;
  final List<ProductCategory> categories;

  _CategoryCard({key, @required this.category, @required this.categories})
      : super(key: key);

  @override
  __CategoryCardState createState() => __CategoryCardState();
}

class __CategoryCardState extends State<_CategoryCard> {
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Container(
      color: PRESENTATION.BACKGROUND_COLOR,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Text(
                  widget.category.name,
                  style: PRESENTATION.CATEGORY_NAME_TEXT_STYLE,
                ),
              ),
              viewAllWidget()
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
            width: double.infinity,
            height: 168.0,
            child: ListView.builder(
              itemCount: widget.category.productTypeList.length,
              itemBuilder: (context, index) {
                return ProductTypeCard(
                  category: widget.category,
                  productType: widget.category.productTypeList[index],
                );
              },
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }

  Widget viewAllWidget() {
    return Padding(
      padding: EdgeInsets.only(right: 12.0),
      child: InkWell(
        onTap: () {
          Map<String, dynamic> arguments = {
            CONSTANTS.SELECTED_CATEGORY: widget.category.id,
            CONSTANTS.CATEGORIES: widget.categories,
          };
          // TODO: add a way to pass in data to view all page
          Navigator.pushNamed(
            context,
            CONSTANTS.PageName.CATEGORY_VIEW_ALL,
            arguments: arguments,
          );
        },
        child: Chip(
          label: Text(
            CONSTANTS.VIEW_ALL,
            style: PRESENTATION.GETTING_STARTED_BUTTON_TEXT_STYLE,
          ),
          backgroundColor: PRESENTATION.PRIMARY_COLOR,
          padding: EdgeInsets.symmetric(horizontal: 12.0),
        ),
      ),
    );
  }
}
