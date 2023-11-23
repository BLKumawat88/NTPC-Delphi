import 'package:flutter/material.dart';
import 'package:ntpcsecond/controllers/allinprovider.dart';
import 'package:provider/provider.dart';

class CommonHeaderClass {
  static AppBar commonAppBarHeader(String title, context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back_ios),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }
}

class OpenSearchHeader {
  static AppBar commonAppBarHeader(String title, context) {
    AllInProvider provider = Provider.of(context, listen: false);
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back_ios),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      actions: [
        InkWell(
          onTap: () {
            provider.isFunctionalExp = false;
            Navigator.pushNamed(context, "/open_search_filter");
          },
          child: const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.filter_alt_outlined,
            ),
          ),
        ),
      ],
    );
  }
}

class ManasReportHeader {
  static AppBar commonAppBarHeader(String title, context) {
    // AllInProvider provider = Provider.of(context, listen: false);
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back_ios),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      actions: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, "/manas_filter");
          },
          child: const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.filter_alt_outlined,
            ),
          ),
        ),
      ],
    );
  }
}
