import 'package:flutter/material.dart';

class FillRemainWidget extends StatelessWidget {
  const FillRemainWidget({
    super.key,
    required this.topChildren,
    required this.bottomChild,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  final List<Widget> topChildren;
  final CrossAxisAlignment crossAxisAlignment;
  final Widget bottomChild;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: crossAxisAlignment,
              children: topChildren,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: SafeArea(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: bottomChild,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
