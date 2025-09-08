import 'package:flutter/material.dart';
import 'package:musicapp/constants/image_path.dart';
import 'package:musicapp/widgets/text_widget.dart';

class Listview2Widget extends StatefulWidget {
  const Listview2Widget({super.key});

  @override
  State<Listview2Widget> createState() => _Listview2WidgetState();
}

class _Listview2WidgetState extends State<Listview2Widget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(left: 10),
            width: 100,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(africangirl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  TextWidget(title: 'heelo', weight: FontWeight.w700),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
