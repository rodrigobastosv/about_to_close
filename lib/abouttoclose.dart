library abouttoclose;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///Define the type of dialog that shows up to the user
enum DialogType { material, cupertino }

///Widget to control the flow of the app when the user is about to leave the
///app. The default operation is to ask the user if he really wants to leave
///the app.
class AboutToClose extends StatefulWidget {
  AboutToClose({
    required this.child,
    required this.dialogTitle,
    this.noOption = 'No',
    this.yesOption = 'Yes',
    this.noOptionTextStyle,
    this.yesOptionTextStyle,
    this.withAnimation = false,
    this.animationDurationInMs = 100,
    this.dialogType = DialogType.cupertino,
  });

  ///Child that will be rendered
  final Widget child;

  ///Title of the dialog
  final String dialogTitle;

  ///Text to the no option
  final String noOption;

  ///Text to the yes option
  final String yesOption;

  ///Style of the no option
  final TextStyle? noOptionTextStyle;

  ///Style of the yes option
  final TextStyle? yesOptionTextStyle;

  ///Define wether animation is wanted or not
  final bool withAnimation;

  ///Define animation duration
  final int animationDurationInMs;

  ///Define the dialog type
  final DialogType dialogType;

  @override
  _AboutToCloseState createState() => _AboutToCloseState();
}

class _AboutToCloseState extends State<AboutToClose>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

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

  Future<bool> _showCupertinoDialog() async {
    return await showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(widget.dialogTitle),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              widget.noOption,
              style: widget.noOptionTextStyle,
            ),
          ),
          TextButton(
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

  Future<bool> _showMaterialDialog() async {
    return await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(widget.dialogTitle),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              widget.noOption,
              style: widget.noOptionTextStyle,
            ),
          ),
          TextButton(
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
