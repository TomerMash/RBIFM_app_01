import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reut_buy_it_for_me/models/currencies_model.dart';
import 'package:reut_buy_it_for_me/providers/currencies_provider.dart';
import 'package:reut_buy_it_for_me/utils/AppColors.dart';

class CalculatorFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<CurrenciesProvider>(context);
    Currencies currencies = data.getResponseJson();
    if (currencies == null) {
      data.fetchData();
    }
    print(currencies.base);
    return data.isFetching
        ? new Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : new GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                    child: Text('המרת שערי מטבע',
                        textAlign: TextAlign.right,
                        style: new TextStyle(
                          fontSize: 20.0,
                          color: AppColors.pink,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                    child: Text('בחר מטבע אותו תרצה להמיר',
                        textAlign: TextAlign.right,
                        style: new TextStyle(
                          fontSize: 16.0,
                          color: AppColors.menuText,
                        )),
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      child: OutlineButton(
                        child: Text("₪ ILS",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle
                                .copyWith(color: AppColors.menuText)),
                        borderSide: BorderSide(
                          color: currencies.base == 'ILS'
                              ? AppColors.pink
                              : AppColors.menuText, //Color of the border
                          style: BorderStyle.solid, //Style of the border
                          width: 1, //width of the border
                        ),
                        onPressed: () {
                          data.fetchData(base: 'ILS', force: true);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: OutlineButton(
                        child: Text("€ EUR",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle
                                .copyWith(color: AppColors.menuText)),
                        borderSide: BorderSide(
                          color: currencies.base == 'EUR'
                              ? AppColors.pink
                              : AppColors.menuText, //Color of the border
                          style: BorderStyle.solid, //Style of the border
                          width: 1, //width of the border
                        ),
                        onPressed: () {
                          data.fetchData(base: 'EUR', force: true);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: OutlineButton(
                        child: Text("\$ USD",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle
                                .copyWith(color: AppColors.menuText)),
                        borderSide: BorderSide(
                          color: currencies.base == 'USD'
                              ? AppColors.pink
                              : AppColors.menuText, //Color of the border
                          style: BorderStyle.solid, //Style of the border
                          width: 1, //width of the border
                        ),
                        onPressed: () {
                          data.fetchData(base: 'USD', force: true);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: OutlineButton(
                        child: Text("£ GBP",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle
                                .copyWith(color: AppColors.menuText)),
                        borderSide: BorderSide(
                          color: currencies.base == 'GBP'
                              ? AppColors.pink
                              : AppColors.menuText, //Color of the border
                          style: BorderStyle.solid, //Style of the border
                          width: 1, //width of the border
                        ),
                        onPressed: () {
                          data.fetchData(base: 'GBP', force: true);
                        },
                      ),
                    ),
                  ]),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                    child: Text('למטבע',
                        textAlign: TextAlign.right,
                        style: new TextStyle(
                          fontSize: 16.0,
                          color: AppColors.menuText,
                        )),
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      child: OutlineButton(
                        child: Text("₪ ILS",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle
                                .copyWith(color: AppColors.menuText)),
                        borderSide: BorderSide(
                          color: data.getTarget == 'ILS'
                              ? AppColors.pink
                              : AppColors.menuText, //Color of the border
                          style: BorderStyle.solid, //Style of the border
                          width: 1, //width of the border
                        ),
                        onPressed: () {
                          data.setTarget('ILS');
                        },
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: OutlineButton(
                        child: Text("€ EUR",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle
                                .copyWith(color: AppColors.menuText)),
                        borderSide: BorderSide(
                          color: data.getTarget == 'EUR'
                              ? AppColors.pink
                              : AppColors.menuText, //Color of the border
                          style: BorderStyle.solid, //Style of the border
                          width: 1, //width of the border
                        ),
                        onPressed: () {
                          data.setTarget('EUR');
                        },
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: OutlineButton(
                        child: Text("\$ USD",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle
                                .copyWith(color: AppColors.menuText)),
                        borderSide: BorderSide(
                          color: data.getTarget == 'USD'
                              ? AppColors.pink
                              : AppColors.menuText, //Color of the border
                          style: BorderStyle.solid, //Style of the border
                          width: 1, //width of the border
                        ),
                        onPressed: () {
                          data.setTarget('USD');
                        },
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: OutlineButton(
                        child: Text("£ GBP",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle
                                .copyWith(color: AppColors.menuText)),
                        borderSide: BorderSide(
                          color: data.getTarget == 'GBP'
                              ? AppColors.pink
                              : AppColors.menuText, //Color of the border
                          style: BorderStyle.solid, //Style of the border
                          width: 1, //width of the border
                        ),
                        onPressed: () {
                          data.setTarget('GBP');
                        },
                      ),
                    ),
                  ]),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                    child: Text('הכנס סכום',
                        textAlign: TextAlign.right,
                        style: new TextStyle(
                          fontSize: 16.0,
                          color: AppColors.menuText,
                        )),
                  ),
                  Row(children: <Widget>[
                    Expanded(
                        child: TextField(
                            controller: data.getTargetTextFieldController,
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            enabled: false,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: data.getTarget,
                            ),
                            style: new TextStyle(
                                fontSize: 18.0,
                                height: 0.5,
                                color: AppColors.menuText))),
                    SizedBox(
                      child: Padding(
                        child: Text('=',
                            style: Theme.of(context)
                                .textTheme
                                .title
                                .copyWith(color: AppColors.menuText)),
                        padding: const EdgeInsets.all(8.0),
                      ),
                    ),
                    Expanded(
                        child: TextField(
                            // onChanged: (text) {
                            //   print("First text field: $text");
                            //   data.setBaseTextFieldControllerText(text);
                            // },
                            controller: data.getBaseTextFieldController,
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            keyboardType: TextInputType.number,
                            autofocus: true,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: currencies.base,
                            ),
                            style: new TextStyle(
                                fontSize: 18.0,
                                height: 0.5,
                                color: AppColors.menuText))),
                  ])
                ],
              ),
            ),
          );
  }
}
