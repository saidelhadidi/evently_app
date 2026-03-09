import 'package:flutter/material.dart';

import '../resources/assets_manager.dart';

class HeaderImage extends StatelessWidget {
  const HeaderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage(AssetsManager.appBarImage),
      color: Theme.of(context).appBarTheme.iconTheme!.color,
      height: 27,
    );
  }
}
