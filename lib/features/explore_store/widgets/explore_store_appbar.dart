import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../searhing_store/searching_store_screen.dart';

class ExploreStoreAppbar extends StatelessWidget {
  const ExploreStoreAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: kPrimaryPurple,
      primary: true,
      expandedHeight: 160,
      toolbarHeight: 0,
      automaticallyImplyLeading: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
          background: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Khám phá',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: kFillColorForth),
            ),
            SizedBox(height: 82)
          ],
        ),
      )),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(76),
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: 56,
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    offset: const Offset(1.1, 1.1),
                    blurRadius: 5.0),
              ],
            ),
            child: InkWell(
                onTap: () => Navigator.of(context)
                    .pushNamed(SearchingStoreScreen.routeName),
                child: const SearchNavigateBar())),
      ),
    );
  }
}

class SearchNavigateBar extends StatelessWidget {
  const SearchNavigateBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text('Cửa hàng trên Meca',
              style: TextStyle(
                color: kTextColorAccent,
                fontSize: 14.0,
                fontFamily: 'Brutal',
              )),
          Icon(Icons.search, size: 18, color: kTextColorAccent)
        ],
      ),
    );
  }
}
