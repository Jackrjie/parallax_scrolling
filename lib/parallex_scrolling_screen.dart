import 'package:flutter/material.dart';
import 'package:parallax_scrolling/item_widget.dart';

class ParallaxScrollingScreen extends StatelessWidget {

  const ParallaxScrollingScreen({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Parallax Scrolling Screen'
        ),
        centerTitle: true
      ),
      body: ListView.builder(
        itemCount: 30,
        itemBuilder: (context, index) => ItemWidget(index: index)
      )
    );
  }

}
