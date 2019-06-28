import 'package:flutter/material.dart';
import 'package:flutter_app/pages/ContactPage.dart';
import 'package:flutter_app/pages/InfoPage.dart';


class _AppbarMenuItem {
  final String name;
  final Widget page;

  _AppbarMenuItem(this.name, this.page);
}

class AppbarMenuItems {
  static final Map<int, _AppbarMenuItem> _menuMap = {
    1: _AppbarMenuItem('О приложении', InfoPage()),
    2: _AppbarMenuItem('Связаться с нами', ContactPage()),
  };
  final List<PopupMenuEntry<dynamic>> menuList = [];

  AppbarMenuItems(){

    _menuMap.forEach((int index, _AppbarMenuItem item) {

      menuList.add(PopupMenuItem(
        child: Text(
          item.name,
          style: TextStyle(color: Colors.white),
        ),
        value: index,
      ));

    });

  }

  static Widget getPage(int index){
    return _menuMap[index].page;
  }

}
