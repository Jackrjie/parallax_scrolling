import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final int index;
  final keyImage = GlobalKey();

  ItemWidget({required this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16
      ),
      height: 220,
      child: Flow(
        delegate: ParallaxFlowDelegate(
          scrollable: Scrollable.of(context)!,
          itemContext: context,
          keyImage: keyImage
        ),
        children: [
          Image.network(
            'https://source.unsplash.com/random/300*800?sig=$index',
            fit: BoxFit.cover,
            key: keyImage
          ),
        ],
      )
    );
  }
}

class ParallaxFlowDelegate extends FlowDelegate {
  final ScrollableState scrollable;
  final BuildContext itemContext;
  final GlobalKey keyImage;

  ParallaxFlowDelegate({
    required this.scrollable,
    required this.itemContext,
    required this.keyImage
  }) : super(repaint: scrollable.position);

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final itemBox = itemContext.findRenderObject() as RenderBox;
    final itemOffset = itemBox.localToGlobal(
      itemBox.size.centerLeft(Offset.zero),
      ancestor: scrollableBox
    );
    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction = (itemOffset.dy / viewportDimension).clamp(0, 1);

    final verticalAlignment = Alignment(0, scrollFraction * 2 - 1);
    final imageBox = keyImage.currentContext?.findRenderObject() as RenderBox?;
    if (imageBox != null) {
      final childRect = verticalAlignment.inscribe(
        imageBox.size,
        Offset.zero & context.size
      );

      context.paintChild(
        0,
        transform: Transform.translate(
          offset: Offset(0, childRect.top),
        ).transform
      );
    }
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return
      scrollable != oldDelegate.scrollable ||
      itemContext != oldDelegate.itemContext ||
      keyImage != oldDelegate.keyImage;
  }

}
