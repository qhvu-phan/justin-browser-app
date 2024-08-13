import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'browser_model.dart';
import 'browser_tab.dart';

class BrowserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BrowserModel>(
        builder: (context, model, child) {
          return Column(
            children: [
              SizedBox(height: 24), // Khoảng cách phía trên để không che biểu tượng của điện thoại
              Expanded(
                child: model.tabKeys.isEmpty
                    ? Center(
                  child: Text(
                    "Welcome to JustinBrowser! Please click the New Tab + button to use this app",
                    textAlign: TextAlign.center,
                  ),
                )
                    : IndexedStack(
                  index: model.currentTabIndex,
                  children: model.tabKeys
                      .map((key) => BrowserTab(key: key))
                      .toList(),
                ),
              ),
              Container(
                color: Colors.grey[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Provider.of<BrowserModel>(context, listen: false)
                            .getCurrentWebViewController()
                            ?.goBack();
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {
                        Provider.of<BrowserModel>(context, listen: false)
                            .getCurrentWebViewController()
                            ?.goForward();
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () {
                        Provider.of<BrowserModel>(context, listen: false)
                            .getCurrentWebViewController()
                            ?.reload();
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        Provider.of<BrowserModel>(context, listen: false).addTab();
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.view_list),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => TabList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class TabList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BrowserModel>(
      builder: (context, model, child) {
        return ListView.builder(
          itemCount: model.tabKeys.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(model.tabNames[index]), // Hiển thị tên tab theo từ khóa tìm kiếm
              onTap: () {
                model.switchTab(index);
                Navigator.pop(context);
              },
              trailing: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  model.closeTab(index);
                  Navigator.pop(context);
                },
              ),
            );
          },
        );
      },
    );
  }
}
