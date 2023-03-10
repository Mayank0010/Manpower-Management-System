import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentHistory {
  final String transactionId;
  final String customerName;
  final String customerMobileNumber;
  final double orderPrice;
  final DateTime transactionDate;

  PaymentHistory({
    required this.transactionId,
    required this.customerName,
    required this.customerMobileNumber,
    required this.orderPrice,
    required this.transactionDate,
  });
}

class PaymentHistoryList extends StatelessWidget {
  final List<PaymentHistory> payments = [
    PaymentHistory(
      transactionId: '123456',
      customerName: 'Alice',
      customerMobileNumber: '1234567890',
      orderPrice: 42.0,
      transactionDate: DateTime.now(),
    ),
    PaymentHistory(
      transactionId: '789012',
      customerName: 'Bob',
      customerMobileNumber: '0987654321',
      orderPrice: 29.99,
      transactionDate: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment History'),
      ),
      body: ListView.builder(
        itemCount: payments.length,
        itemBuilder: (BuildContext context, int index) {
          final payment = payments[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Transaction ID: ${payment.transactionId}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Customer Name: ${payment.customerName}',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Mobile Number: ${payment.customerMobileNumber}',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Order Price: ${payment.orderPrice.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Transaction Date: ${DateFormat.yMd().add_jm().format(payment.transactionDate)}',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
