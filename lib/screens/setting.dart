import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:soom_net/screens/my%20profile/My%20Account.dart';

class Setting extends StatefulWidget {
  static const routeName = '/setting';
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Setting"),
      body: Column(
        children: [
          Card(
            color: Colors.black12,
            elevation: 2,
            child: ListTile(
              title: Text("Subscribe Notification"),
              trailing: Switch(
                value: false,
                onChanged: (newValue) => {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
