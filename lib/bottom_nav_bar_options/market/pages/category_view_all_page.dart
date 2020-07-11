import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './../../../bloc/_bloc.dart';
import './../../../const/_const.dart' as CONSTANTS;
import './../../../model/_model.dart';
import './../../../presentation/font_awesome_icons_icons.dart';
import './../custom_widgets/_custom_widgets.dart';

class CategoryViewAllPage extends StatefulWidget {
  @override
  _CategoryViewAllPageState createState() => _CategoryViewAllPageState();
}

class _CategoryViewAllPageState extends State<CategoryViewAllPage> {
  List<ProductCategory> productCategories;

  BlocCart _cartBloc;

  int _selectedCategory;

  int findCategoryIndex(int id) {
    for (int i = 0; i < productCategories.length; i++) {
      if (productCategories[i].id == id) {
        return i;
      }
    }
    return -1;
  }

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
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    productCategories = args[CONSTANTS.CATEGORIES];
    _selectedCategory = findCategoryIndex(args[CONSTANTS.SELECTED_CATEGORY]);

    return DefaultTabController(
      length: productCategories.length,
      initialIndex: _selectedCategory,
      child: Scaffold(
        appBar: AppBar(
          title: Text(CONSTANTS.APP_NAME),
          //elevation: 0.0,
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(
                Font_awesome_icons.search,
              ),
            ),
            BasketWidget(),
          ],
          bottom: TabBar(
            isScrollable: true,
            tabs: productCategories
                .map<Widget>((ProductCategory productCategory) {
              return Tab(
                text: productCategory.name,
              );
            }).toList(),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: TabBarView(
                children: productCategories
                    .map<Widget>((ProductCategory productCategory) {
                  return ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                        child: CategoryViewAllCard(category: productCategory),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
            BlocBuilder<BlocCart, Cart>(
              bloc: _cartBloc,
              builder: (BuildContext context, Cart cart) {
                if (cart.isNotEmpty)
                  return BasketBottomBar(BasketBottomBarType.TO_BASKET);
                else
                  return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryViewAllCard extends StatefulWidget {
  const CategoryViewAllCard({Key key, this.category}) : super(key: key);

  final ProductCategory category;

  @override
  _CategoryViewAllCardState createState() => _CategoryViewAllCardState();
}

class _CategoryViewAllCardState extends State<CategoryViewAllCard> {
  ProductCategory get _category => widget.category;

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.redAccent,
      alignment: Alignment.topCenter,
      child: Wrap(
        direction: Axis.horizontal,
        children:
            _category.productTypeList.map<Widget>((ProductType _productType) {
          //return Container();
          return ProductTypeCard(
            category: _category,
            productType: _productType,
            showPrice: true,
          );
        }).toList(),
      ),
    );
  }
}
