import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class StoreScreenAppBar extends StatefulWidget {
  const StoreScreenAppBar({
    super.key,
    required bool isSliverAppBarExpanded,
    required this.title,
    required this.imgUrls,
  }) : _isSliverAppBarExpanded = isSliverAppBarExpanded;

  final bool _isSliverAppBarExpanded;
  final String title;
  final List<String> imgUrls;

  @override
  State<StoreScreenAppBar> createState() => _StoreScreenAppBarState();
}

class _StoreScreenAppBarState extends State<StoreScreenAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      snap: false,
      floating: false,
      expandedHeight: MediaQuery.of(context).size.height * 0.36,
      title: widget._isSliverAppBarExpanded
          ? Text(widget.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
          : null,
      backgroundColor: kPrimaryPurple,
      flexibleSpace: FlexibleSpaceBar(
        background: Swiper(
            itemCount: widget.imgUrls.length,
            autoplay: true,
            itemBuilder: (context, index) => Image.network(
                  widget.imgUrls[index],
                  loadingBuilder: (context, widget, loadingProgress) {
                    if (loadingProgress == null) {
                      return widget;
                    }
                    return Container(color: kTextColorThird);
                  },
                  fit: BoxFit.fill,
                )),
      ),
    );
  }
}