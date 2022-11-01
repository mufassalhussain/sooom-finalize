import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants.dart';

class HeroesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: Consumer<List<String>>(
        builder: (context, List<String> heroes, child) {
          if (heroes == '')
            // replace the return with your shimmer widget
            return Card(child: spinkit);

          return ListView.builder(
            itemCount: heroes.length,
            itemBuilder: (context, index) {
              return Card(
                child: Text('My hero is hero ${heroes[index]}'),
              );
            },
          );
        },
      ),
    ));
  }
}
