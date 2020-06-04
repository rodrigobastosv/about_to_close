library abouttoclose;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum DialogType { material, cupertino }

class AboutToClose extends StatefulWidget {
  AboutToClose({
    @required this.child,
    @required this.dialogTitle,
    this.noOption = 'No',
    this.yesOption = 'Yes',
    this.noOptionTextStyle,
    this.yesOptionTextStyle,
    this.withAnimation = false,
    this.animationDurationInMs = 100,
    this.dialogType = DialogType.cupertino,
  });

  final Widget child;
  final String dialogTitle;
  final String noOption;
  final String yesOption;
  final TextStyle noOptionTextStyle;
  final TextStyle yesOptionTextStyle;
  final bool withAnimation;
  final int animationDurationInMs;
  final DialogType dialogType;

  @override
  _AboutToCloseState createState() => _AboutToCloseState();
}

class _AboutToCloseState extends State<AboutToClose>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.animationDurationInMs),
    );
    _controller.addListener(() => setState(() {}));
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.withAnimation) {
          await _controller.forward();
        }
        return widget.dialogType == DialogType.cupertino
            ? await _showCupertinoDialog()
            : await _showMaterialDialog();
      },
      child: Padding(
        padding: EdgeInsets.all(0 + 20 * _controller.value),
        child: Container(
          child: widget.child,
        ),
      ),
    );
  }

  Future<bool> _showCupertinoDialog() {
    return showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(widget.dialogTitle),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              widget.noOption,
              style: widget.noOptionTextStyle,
            ),
          ),
          FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              widget.yesOption,
              style: widget.yesOptionTextStyle,
            ),
          )
        ],
      ),
    );
  }

  Future<bool> _showMaterialDialog() {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(widget.dialogTitle),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              widget.noOption,
              style: widget.noOptionTextStyle,
            ),
          ),
          FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              widget.yesOption,
              style: widget.yesOptionTextStyle,
            ),
          )
        ],
      ),
    );
  }
}
