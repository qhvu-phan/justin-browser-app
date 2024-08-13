import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter/material.dart';
import 'browser_tab.dart';

class BrowserModel extends ChangeNotifier {
  List<GlobalKey<BrowserTabState>> tabKeys = [];
  List<String> tabNames = [];
  int currentTabIndex = 0;

  void addTab() {
    tabKeys.add(GlobalKey<BrowserTabState>());
    tabNames.add('New Tab ${tabKeys.length}'); // Tên tab mặc định
    currentTabIndex = tabKeys.length - 1;
    notifyListeners();
  }

  void closeTab(int index) {
    if (index < tabKeys.length) {
      tabKeys.removeAt(index);
      tabNames.removeAt(index);
      currentTabIndex = index == 0 ? 0 : index - 1;
      notifyListeners();
    }
  }

  void switchTab(int index) {
    currentTabIndex = index;
    notifyListeners();
  }

  void updateTabName(String name) {
    tabNames[currentTabIndex] = name;
    notifyListeners();
  }

  InAppWebViewController? getCurrentWebViewController() {
    if (currentTabIndex < tabKeys.length) {
      return tabKeys[currentTabIndex].currentState?.webViewController;
    }
    return null;
  }
}





