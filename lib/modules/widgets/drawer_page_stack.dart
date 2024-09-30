import 'package:flutter/material.dart';

class DrawPageStack extends StatefulWidget {
  final Widget? body;
  final Widget? video;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final String? backgroundAssets;
  final Key? scaffoldKey;

  DrawPageStack({
    this.body,
    this.bottomNavigationBar,
    this.drawer,
    this.appBar,
    this.floatingActionButton,
    this.backgroundAssets,
    this.video,
    this.scaffoldKey,
  });

  @override
  _DrawPageStackState createState() => _DrawPageStackState();
}

class _DrawPageStackState extends State<DrawPageStack> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        (widget.backgroundAssets == null)
            ? widget.video!
            : Container(
                decoration: BoxDecoration(color: Colors.white
                    // image: DecorationImage(
                    //     image: ExactAssetImage(widget.backgroundAssets!),
                    //     fit: BoxFit.cover),
                    ),
              ),
        Scaffold(
          floatingActionButton: widget.floatingActionButton,
          key: widget.scaffoldKey,
          endDrawer: widget.drawer,
          appBar: widget.appBar,
          backgroundColor: Colors.white,
          bottomNavigationBar: widget.bottomNavigationBar,
          body: widget.body,
        ),
      ],
    );
  }
}
