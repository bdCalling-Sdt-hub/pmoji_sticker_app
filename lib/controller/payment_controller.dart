import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../views/payment_constants.dart';

//
//
// class PaymentController {
//   Map<String, dynamic>? paymentIntentData;
//
//   PaymentController() {
//     Stripe.publishableKey = PaymentConstants.publishAbleKey;
//   }
//
//   Future<PaymentIntent> stripeCheckPaymentIntentTransaction(String piId) async {
//     try {
//       final paymentIntent = await Stripe.instance.retrievePaymentIntent(piId);
//       if (kDebugMode) {
//         print("Payment Intent: $paymentIntent");
//       }
//       return paymentIntent;
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error fetching payment intent: $e');
//       }
//       throw e;
//     }
//   }
//
//   Future<void> makePayment() async {
//     try {
//       paymentIntentData = await createPaymentIntent("6", "USD");
//       if (paymentIntentData != null) {
//         String clientSecret = paymentIntentData!['client_secret'];
//
//         if (kDebugMode) {
//           print("Client Secret: $clientSecret");
//         }
//
//         await Stripe.instance.initPaymentSheet(
//           paymentSheetParameters: SetupPaymentSheetParameters(
//             billingDetails: const BillingDetails(
//                 name: '',
//                 email: 'mailto:sagor@email.com',
//                 address: Address(
//                     city: 'Dhaka',
//                     country: 'Bangladesh',
//                     line1: 'Dhaka',
//                     line2: 'Dhaka',
//                     postalCode: '21214',
//                     state: 'Dhaka')),
//             googlePay: const PaymentSheetGooglePay(merchantCountryCode: 'US'),
//             merchantDisplayName: 'Sagor Ahamed',
//             paymentIntentClientSecret: clientSecret,
//             style: ThemeMode.dark,
//           ),
//         );
//
//         displayPaymentSheet();
//       }
//     } catch (e, s) {
//       if (kDebugMode) {
//         print('Exception: $e\nStack trace: $s');
//       }
//     }
//   }
//
//   Future<Map<String, dynamic>?> createPaymentIntent(String amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount': calculateAmount(amount),
//         'currency': currency,
//       };
//
//       var response = await http.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         body: body,
//         headers: {
//           'Authorization': 'Bearer ${PaymentConstants.secretKey}', // Use sk_test_... key here
//           'Content-Type': 'application/x-www-form-urlencoded'
//         },
//       );
//
//       if (kDebugMode) {
//         print("Payment Intent Response: ${response.body}");
//       }
//
//       return jsonDecode(response.body);
//     } catch (e) {
//       if (kDebugMode) {
//         print("Error creating payment intent: $e");
//       }
//       return null;
//     }
//   }
//
//   String calculateAmount(String amount) {
//     final a = (int.parse(amount)) * 100;
//     return a.toString();
//   }
//
//   Future<void> displayPaymentSheet() async {
//     try {
//       await Stripe.instance.presentPaymentSheet();
//       retrieveTxnId(paymentIntent: paymentIntentData!['id']);
//       if (kDebugMode) {
//         print('Payment intent: $paymentIntentData');
//       }
//       ScaffoldMessenger.of(Get.context!)
//           .showSnackBar(const SnackBar(content: Text("Paid successfully")));
//       paymentIntentData = null;
//     } catch (e) {
//       if (kDebugMode) {
//         print("Error displaying payment sheet: $e");
//       }
//     }
//   }
//
//   Future<void> retrieveTxnId({required String paymentIntent}) async {
//     try {
//       final response = await http.get(
//         Uri.parse('https://api.stripe.com/v1/charges?payment_intent=$paymentIntent'),
//         headers: {
//           "Authorization": "Bearer ${PaymentConstants.secretKey}", // Use sk_test_... key here
//           "Content-Type": "application/x-www-form-urlencoded"
//         },
//       );
//
//       if (response.statusCode == 200) {
//         var data = json.decode(response.body);
//         if (kDebugMode) {
//           print("Transaction Id: ${data['data'][0]['balance_transaction']}");
//         }
//       }
//     } catch (e) {
//       throw Exception("Error retrieving transaction ID: $e");
//     }
//   }
// }