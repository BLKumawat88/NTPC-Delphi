import 'package:flutter/material.dart';

class ImagePro extends StatefulWidget {
  const ImagePro({super.key});

  @override
  State<ImagePro> createState() => _ImageProState();
}

class _ImageProState extends State<ImagePro> {
  bool isDrawerOpen = false;

  List data = [1, 2, 3, 4];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.transparent,
      onDrawerChanged: (isOpened) {
        print(isOpened);
        setState(() {
          isDrawerOpen = isOpened;
        });
      },
      // appBar: AppBar(),
      drawer: Container(
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        width: 70,
        // height: MediaQuery.of(context).size.height - 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Icon(
              Icons.home,
              size: 30,
            ),
            SizedBox(
              height: 20,
            ),
            Icon(
              Icons.settings,
              size: 30,
            ),
            SizedBox(
              height: 20,
            ),
            Icon(
              Icons.search,
              size: 30,
            ),
            SizedBox(
              height: 20,
            ),
            Icon(
              Icons.person,
              size: 30,
            ),
            SizedBox(
              height: 20,
            ),
            Icon(
              Icons.delete,
              size: 30,
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 2.5),
                      height: 100,
                      width: 10,
                      color: Colors.grey,
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ...data.map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          height: 150,
                          width: isDrawerOpen
                              ? MediaQuery.of(context).size.width - 70
                              : MediaQuery.of(context).size.width - 10,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("HHHH"),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
