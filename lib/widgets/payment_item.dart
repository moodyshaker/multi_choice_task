import 'package:flutter/material.dart';
import 'package:multi_choice_task/models/dataset.dart';

class PaymentItem extends StatefulWidget {
  final DateSet data;

  const PaymentItem({@required this.data});

  @override
  State<PaymentItem> createState() => _PaymentItemState();
}

class _PaymentItemState extends State<PaymentItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data.fullNameAR,
                        style: const TextStyle(
                          color: Colors.purple,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        widget.data.mobileNumber,
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '${widget.data.amount}',
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text('ريال سعودي'),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Text(''),
                  Text(''),
                ],
              ),
              Row(
                children: [
                  Text('رقم التحويل: '),
                  Text(widget.data.trxDetails.appliedCharge),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
