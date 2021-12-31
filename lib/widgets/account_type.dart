import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountTypeBottomSheet extends StatelessWidget {
  final Function onItemClick;
  final int selectedItem;
  final List<String> types;

  AccountTypeBottomSheet({
    @required this.onItemClick,
    @required this.selectedItem,
    @required this.types,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: types
          .map(
            (item) => Column(
              children: [
                ListTile(
                  onTap: () => onItemClick(
                    item,
                    types.indexOf(item),
                  ),
                  title: Text(
                    item,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: selectedItem == types.indexOf(item)
                      ? const Icon(
                          Icons.done,
                          color: Colors.black,
                        )
                      : const SizedBox(
                          height: 24.0,
                          width: 24.0,
                        ),
                ),
              ],
            ),
          )
          .toList(),
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }
}
