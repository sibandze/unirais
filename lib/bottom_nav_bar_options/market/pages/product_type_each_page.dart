import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animations/loading_animations.dart';

import './../../../bloc/_bloc.dart';
import './../../../const/_const.dart' as CONSTANTS;
import './../../../model/_model.dart';
import './../../../presentation/_presentation.dart' as PRESENTATION;
import './../custom_widgets/_custom_widgets.dart';

class ProductTypeEachPage extends StatefulWidget {
  @override
  _ProductTypeEachPageState createState() => _ProductTypeEachPageState();
}

class _ProductTypeEachPageState extends State<ProductTypeEachPage> {
  ProductCategory cProductCategory;
  BlocCart _cartBloc;

  int selectedProductType;

  int findCategoryIndex(int productTypeId) {
    for (int i = 0; i < cProductCategory.productTypeList.length; i++) {
      if (cProductCategory.productTypeList[i].id == productTypeId) {
        return i;
      }
    }
    return -1;
  }

  @override
  void reassemble() {
    super.reassemble();
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
    cProductCategory = args[CONSTANTS.SELECTED_CATEGORY];
    selectedProductType =
        findCategoryIndex(args[CONSTANTS.SELECTED_PRODUCT_TYPE]);
    return DefaultTabController(
      initialIndex: selectedProductType,
      length: cProductCategory.productTypeList.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(cProductCategory.name),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(
                PRESENTATION.Font_awesome_icons.search,
              ),
            ),
            BasketWidget(),
          ],
          bottom: TabBar(
            isScrollable: true,
            tabs: cProductCategory.productTypeList
                .map<Widget>((ProductType productType) {
              return Tab(
                text: productType.name,
              );
            }).toList(),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: TabBarView(
                children: cProductCategory.productTypeList
                    .map<Widget>((ProductType productType) {
                  return ProductListWidget(productType: productType);
                }).toList(),
              ),
            ),
            BlocBuilder<BlocCart, Cart>(
                builder: (BuildContext context, Cart cart) {
              if (cart.isNotEmpty)
                return BasketBottomBar(BasketBottomBarType.TO_BASKET);
              else
                return Container();
            }),
          ],
        ),
      ),
    );
  }
}

class ProductListWidget extends StatefulWidget {
  ProductListWidget({Key key, this.productType}) : super(key: key);
  final ProductType productType;

  @override
  _ProductListWidgetState createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
  BlocProducts productsBloc;

  @override
  void initState() {
    productsBloc = BlocProducts();
    productsBloc.add(BlocEventProductsFetch(productType: widget.productType));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: BlocBuilder<BlocProducts, BlocStateProducts>(
        bloc: productsBloc,
        builder: (BuildContext context, BlocStateProducts productsState) {
          Widget returnWidget;
          if (productsState is BlocStateProductsUninitialized ||
              productsState is BlocStateProductsFetching) {
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
          } else if (productsState is BlocStateProductsFetchingFailure) {
            returnWidget = Center(
              child: Text(
                "Error",
                style: PRESENTATION.PRODUCT_HEADING_TEXT_STYLE,
              ),
            );
          } else if (productsState is BlocStateProductsFetchingSuccess) {
            List<Product> _list = productsState.products;
            returnWidget = ListView.builder(
              itemCount: _list.length,
              itemBuilder: (context, index) {
                return ProductEachCard(product: _list[index]);
              },
              scrollDirection: Axis.vertical,
            );
          }
          return returnWidget;
        },
      ),
    );
  }
}

class ProductEachCard extends StatelessWidget {
  final Product product;

  const ProductEachCard({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var price = product.price;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              color: Colors.white,
              child: Image.network(
                product.appUrlQualifiedImgUrl,
                fit: BoxFit.fitWidth,
                height: 120.0,
                width: 120.0,
              ),
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
                  product.name,
                  style: PRESENTATION.PRODUCT_HEADING_TEXT_STYLE,
                ),
                SizedBox(
                  height: 2.0,
                ),
                Text(
                  product.packaging,
                  style: PRESENTATION.SUB_TEXT_STYLE,
                ),
                SizedBox(
                  height: 2.0,
                ),
                Text(
                  price.toString(),
                  style: PRESENTATION.PRODUCT_PRICE_TEXT_STYLE,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 12.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<BlocCart, Cart>(
                builder: (BuildContext context, Cart cart) {
              if (cart.contains(product))
                return PlusMinusInputTextWidget(
                  cartItem: cart.getCartItem(product),
                );
              else
                return AddToCartButton(
                  product: product,
                );
            }),
          ),
        ],
      ),
    );
  }
}

class AddToCartButton extends StatefulWidget {
  final Product product;

  AddToCartButton({this.product});

  @override
  _AddToCartButtonState createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  BlocCart _cartBloc;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _cartBloc = BlocProvider.of<BlocCart>(context);
    return FlatButton(
      onPressed: () {
        _cartBloc.add(BlocCartEvent.create(widget.product));
      },
      color: PRESENTATION.PRIMARY_COLOR,
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Row(
          children: <Widget>[
            Text(
              "Add",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
