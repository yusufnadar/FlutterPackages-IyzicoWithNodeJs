import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:http/http.dart' as http;

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  var cardNumber = '';
  var expiryDate = '';
  var cardHolderName = '';
  var cvvCode = '';
  var isCvvFocused = false;

  var liste = [
    {
      "id": 'BI101',
      "name": 'Binocular',
      "category1": 'Collectibles',
      "category2": 'Accessories',
      "itemType": "Iyzipay.BASKET_ITEM_TYPE.PHYSICAL",
      "price": '100'
    },
    {
      "id": 'BI102',
      "name": 'Game code',
      "category1": 'Game',
      "category2": 'Online Game Items',
      "itemType": "Iyzipay.BASKET_ITEM_TYPE.VIRTUAL",
      "price": '50'
    },
    {
      "id": 'BI103',
      "name": 'Usb',
      "category1": 'Electronics',
      "category2": 'Usb / Cable',
      "itemType": "Iyzipay.BASKET_ITEM_TYPE.PHYSICAL",
      "price": '150'
    }
  ];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('İyzico Ödeme'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [widgetPart(), formPart(), buttonPart(context)],
        ),
      ),
    );
  }

  GestureDetector buttonPart(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        print(cardNumber.replaceAll(' ', ''));
        print(cardHolderName);
        print(cvvCode);
        var month = expiryDate.split('/')[0];
        var year = expiryDate.split('/')[1];
        print('20${year}');

        var msg = {
          "basketItems": liste,
          'cardNumber': cardNumber.replaceAll(' ', ''),
          'cardHolderName':cardHolderName,
          'cvvCode':cvvCode,
          'month':month,
          'year':'20$year'
        };
        var response = await http.post(Uri.parse('http://10.0.2.2:3000/'),
            body: json.encode(msg),
            headers: {'Content-Type': 'application/json'});
        print(response.statusCode);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(8)),
        alignment: Alignment.center,
        child: const Text(
          'Ödeme Yap',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  CreditCardForm formPart() {
    return CreditCardForm(

      cardNumber: cardNumber,
      expiryDate: expiryDate,
      cardHolderName: cardHolderName,

      cvvCode: cvvCode,
      formKey: formKey,
      // Required
      onCreditCardModelChange: (CreditCardModel data) {
        setState(() {
          cardNumber = data.cardNumber;
          expiryDate = data.expiryDate;
          cardHolderName = data.cardHolderName;
          if (data.cvvCode.length < 4) {
            cvvCode = data.cvvCode;
          }
          isCvvFocused = data.isCvvFocused;
        });
      },
      // Required
      themeColor: Colors.red,
      obscureCvv: false,
      obscureNumber: false,
      isHolderNameVisible: true,
      isCardNumberVisible: true,
      isExpiryDateVisible: true,
      cardNumberDecoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Number',
        hintText: 'XXXX XXXX XXXX XXXX',
      ),
      expiryDateDecoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Expired Date',
        hintText: 'XX/XX',
      ),
      cvvCodeDecoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'CVV',
        hintText: 'XXX',
      ),
      cardHolderDecoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Card Holder',
      ),
    );
  }

  CreditCardWidget widgetPart() {
    return CreditCardWidget(
      cardNumber: cardNumber,
      expiryDate: expiryDate,
      cardHolderName: cardHolderName,
      cvvCode: cvvCode,
      obscureCardNumber: false,
      obscureCardCvv: false,
      showBackView: isCvvFocused,
      onCreditCardWidgetChange:
          (CreditCardBrand) {}, //true when you want to show cvv(back) view
    );
  }
}
