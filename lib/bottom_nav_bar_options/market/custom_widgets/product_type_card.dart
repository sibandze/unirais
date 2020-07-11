import 'package:flutter/material.dart';

import './../../../const/_const.dart' as CONSTANTS;
import './../../../model/shop/_shop.dart';
import './../../../presentation/_presentation.dart' as PRESENTATION;

class ProductTypeCard extends StatelessWidget {
  final ProductType productType;
  final ProductCategory category;
  final bool showPrice;

  const ProductTypeCard(
      {Key key, @required this.productType, @required this.category, showPrice})
      : this.showPrice = (showPrice == null) ? false : showPrice,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    /**/
    var minPrice = productType.minPrice;
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: InkWell(
            onTap: () {
              Map<String, dynamic> arguments = {
                CONSTANTS.SELECTED_PRODUCT_TYPE: productType.id,
                CONSTANTS.SELECTED_CATEGORY: category,
              };
              Navigator.pushNamed(
                context,
                CONSTANTS.PageName.PRODUCT_TYPE_EACH,
                arguments: arguments,
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                //color: Color(0xAABCE2B9),
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 8.0,
                ),
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        color: Colors.white,
                        child: Image.network(
                          productType.appUrlQualifiedImgUrl,
                          fit: BoxFit.fitWidth,
                          height: 100.0,
                          width: 100.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      productType.name,
                      style: PRESENTATION.PRODUCT_HEADING_TEXT_STYLE,
                    ),
                    if (showPrice)
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: 1.0,
                          ),
                          Text(
                            'From $minPrice',
                            style: PRESENTATION.PRODUCT_MIN_PRICE_TEXT_STYLE,
                          )
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
