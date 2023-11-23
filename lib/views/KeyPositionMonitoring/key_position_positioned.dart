import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/allinprovider.dart';
import '../../theme/common_them.dart';
import '../commoncard/common_card.dart';
import '../commonheader/common_header.dart';

class KeyPostionOccupiedEmp extends StatefulWidget {
  KeyPostionOccupiedEmp({super.key});
  @override
  State<KeyPostionOccupiedEmp> createState() => _KeyPostionOccupiedEmpState();
}

class _KeyPostionOccupiedEmpState extends State<KeyPostionOccupiedEmp> {
  List compareList = [];

  @override
  Widget build(BuildContext context) {
    AllInProvider provider = Provider.of(context, listen: false);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CommonHeaderClass.commonAppBarHeader("Employee List", context),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(CommonAppTheme.backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(CommonAppTheme.screenPadding),
          child: SafeArea(
            child: ListView(
              children: [
                ...provider.keyPostionPositionedEmpData
                    .map(
                      (e) => CommonCardScreen(e: e),
                    )
                    .toList()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
