import 'package:anam/core/constants/extensions.dart';
import 'package:flutter/material.dart';

import '../../../widgets/shared_widget/search_bar_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Material(
              type: MaterialType.transparency,
              child: Hero(
                tag: "searchField",
                child: Material(
                  color: Colors.transparent,
                  child: SearchBarWidget(
                    onSearchClicked: () {},
                    autofocus: true,
                    enabled: true,
                  ),
                ),
              ),
            ),
          ],
        ).symmetricPadding(
          horizontal: 16,
          vertical: 24,
        ),
      ),
    );
  }
}
