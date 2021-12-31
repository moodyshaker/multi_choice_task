import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_choice_task/dialog/action_dialog.dart';
import 'package:multi_choice_task/provider/main_provider.dart';
import 'package:multi_choice_task/screens/auth.dart';
import 'package:multi_choice_task/utilits/network_state_enum.dart';
import 'package:multi_choice_task/widgets/payment_item.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static const String id = 'HOME';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  MainProvider _mainProvider;

  @override
  void initState() {
    super.initState();
    _mainProvider = Provider.of<MainProvider>(context, listen: false);
    // _mainProvider.getHalaPayment();
    _mainProvider.getPayment();
  }

  @override
  Widget build(BuildContext context) {
    print(_mainProvider.token);
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) => ActionDialog(
            title: 'الخروج من التطبيق',
            content: 'هل تود الخروج من التطبيق',
            approveAction: 'نعم',
            cancelAction: 'لا',
            onApproveClick: () {
              Navigator.pop(context);
              SystemNavigator.pop();
            },
            onCancelClick: () {
              Navigator.pop(context);
            },
          ),
        );
        return false;
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            toolbarHeight: 70,
            backgroundColor: Colors.white,
            title: const Text(
              'مدفوعات هلا',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              ),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  items: [
                    DropdownMenuItem(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'خروج',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w600),
                          ),
                          Icon(
                            Icons.exit_to_app,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      value: 'logout',
                    )
                  ],
                  onChanged: (String v) {
                    if (v == 'logout') {
                      _mainProvider.logout();
                      Navigator.pushNamedAndRemoveUntil(
                          context, Auth.id, (route) => false);
                    }
                  },
                  underline: Container(),
                  icon: const Icon(
                    Icons.more_vert_rounded,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
          body: Consumer<MainProvider>(
            builder: (c, data, ch) => data.state == NetworkState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Card(
                              color: Colors.yellow,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'إجمالي المدفوعات',
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.green),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '${data.total}',
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.green,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 2.0,
                                        ),
                                        const Text(
                                          'ريال سعودي',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                // show filter dialog;
                              },
                              child: const Card(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 16.0, horizontal: 24.0),
                                  child: Icon(
                                    Icons.filter_list_alt,
                                    color: Colors.purple,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: data.dataSet.length,
                            itemBuilder: (BuildContext c, int i) => PaymentItem(
                                  data: data.dataSet[i],
                                )),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
