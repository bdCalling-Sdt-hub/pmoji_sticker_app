import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:stripe_payments/constant.dart';
import 'package:stripe_payments/service/service.dart';

import 'helpers/helpers.dart';
import 'utils/app_constant.dart';

class PaymentController {
  Map<String, dynamic>? paymentIntentData;

  PaymentController() {
    Stripe.publishableKey = Constants.publishAbleKey;
  }

  Future<PaymentIntent> stripeCheckPaymentIntentTransaction(String piId) async {
    try {
      final paymentIntent = await Stripe.instance.retrievePaymentIntent(piId);
      if (kDebugMode) {
        print("Payment Intent: $paymentIntent");
      }
      return paymentIntent;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching payment intent: $e');
      }
      throw e;
    }
  }

  Future<void> makePayment({required String totalAmount, required List<String> stickers}) async {
    try {
      paymentIntentData = await createPaymentIntent("$totalAmount", "USD");
      if (paymentIntentData != null) {
        String clientSecret = paymentIntentData?['client_secret'] ?? "";

        if (kDebugMode) {
          print("Client Secret: ------------------- ${clientSecret.runtimeType}");
        }

        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            billingDetails: const BillingDetails(
                name: '',
                email: 'nur@email.com',
                address: Address(
                    city: 'Dhaka',
                    country: 'Bangladesh',
                    line1: 'Dhaka',
                    line2: 'Dhaka',
                    postalCode: '21214',
                    state: 'Dhaka')),
            googlePay: const PaymentSheetGooglePay(merchantCountryCode: 'US'),
            merchantDisplayName: 'Sagor Ahamed',
            paymentIntentClientSecret: clientSecret,
            style: ThemeMode.dark,
          ),
        );
        print("stickersssssssssssssssssss------------> $stickers");
        displayPaymentSheet(stickers: stickers, amount: totalAmount);
      }
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e\nStack trace: $s');
      }
    }
  }

  Future<Map<String, dynamic>?> createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount("$amount"),
        'currency': currency,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization': 'Bearer ${Constants.secretKey}', // Use sk_test_... key here
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      );

      if (kDebugMode) {
        print("Payment Intent Response: ${response.body}");
      }

      return jsonDecode(response.body);
    } catch (e) {
      if (kDebugMode) {
        print("Error creating payment intent: $e");
      }
      return null;
    }
  }

  String calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }

  Future<void> displayPaymentSheet({ required List<String> stickers,required String amount}) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      retrieveTxnId(paymentIntent: paymentIntentData!['id'], stickers: stickers, amount: amount);

      print("stickersssssssssssssssssss  $stickers");

      if (kDebugMode) {
        print('Payment intent: $paymentIntentData');
      }
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(const SnackBar(content: Text("Paid successfully")));
      paymentIntentData = null;
    } catch (e) {
      if (kDebugMode) {
        print("Error displaying payment sheet: $e");
      }
    }
  }

  Future<void> retrieveTxnId({required String paymentIntent,  required List<String> stickers, required String amount}) async {
    try {
      final response = await http.get(
        Uri.parse('https://api.stripe.com/v1/charges?payment_intent=$paymentIntent'),
        headers: {
          "Authorization": "Bearer ${Constants.secretKey}", // Use sk_test_... key here
          "Content-Type": "application/x-www-form-urlencoded"
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
       String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
        var dd = {
          "stickerIds": stickers,
          "transactionId": data['data'][0]['balance_transaction'],
          "amount": amount.toString()
        };
        print("=======================payment data = ${data["data"]}");
        print("======================= body : $dd");
        print(amount.toString());


        final postResponse = await http.post(
          Uri.parse('${ApiConstants.baseUrl}/transaction/purchase'),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $bearerToken'
          },
          body: json.encode(dd),
        );
        if (postResponse.statusCode == 200) {
          print('Data submitted successfully: ${postResponse.body}');
        } else {
          print('Failed to submit data: ${postResponse.statusCode}');
        }

        if (kDebugMode) {
          ///Need API hit
          print("Transaction Id: ${data['data'][0]['balance_transaction']}");

        }
      }
    } catch (e) {
      throw Exception("Error retrieving transaction ID: $e");
    }
  }
}
