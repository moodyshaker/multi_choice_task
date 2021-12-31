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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
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
            ),
            _isExpanded
                ? Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(12.0),
                          bottomLeft: Radius.circular(12.0),
                        )),
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              'رقم التحويل:  ',
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.grey),
                            ),
                            Text(
                              widget.data.trxRef,
                              style: const TextStyle(fontSize: 15.0),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Row(
                          children: [
                            const Text(
                              'تاريخ التحويل:  ',
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.grey),
                            ),
                            Text(
                              widget.data.trxDate,
                              style: const TextStyle(fontSize: 15.0),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Row(
                          children: [
                            const Text('أسم المنشأة:  ',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.grey,
                                )),
                            Text(widget.data.corporateFullNameAR,
                                style: const TextStyle(
                                    fontSize: 15.0, color: Colors.purple)),
                          ],
                        ),
                      ],
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
