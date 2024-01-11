import 'package:flutter/material.dart';

class AsyncButtonState {
  static const int INITED = 0;
  static const int LOADING = 1;
  static const int LOADED = 2;
  static const int FAILED = 3;
  Function stateFunction;
  AsyncButtonState(
      {required state,
      required this.primaryBackground,
      required this.primaryTextColor,
      required this.loadingBackground,
      required this.loadingTextColor,
      required this.failedTextColor,
      required this.failedBackground,
      required this.successBackground,
      required this.successTextColor,
      required this.progressBarColor,
      required this.primaryText,
      required this.loadingText,
      required this.failedText,
      required this.successText,
      required this.stateFunction}) {
    _state = state;
  }
  late int _state;

  final Color primaryBackground;
  final Color primaryTextColor;
  final Color loadingBackground;
  final Color loadingTextColor;
  final Color failedBackground;
  final Color failedTextColor;
  final Color successBackground;
  final Color successTextColor;
  final Color progressBarColor;
  final String primaryText;
  final String loadingText;
  final String failedText;
  final String successText;

  void setState(int state) {
    stateFunction(() {
      _state = state;
    });
  }

  Color getBackgroundColor() {
    switch (_state) {
      case AsyncButtonState.INITED:
        return primaryBackground;
      case AsyncButtonState.LOADING:
        return loadingBackground;
      case AsyncButtonState.LOADED:
        return successBackground;
      case AsyncButtonState.FAILED:
        return failedBackground;
      default:
        return primaryBackground;
    }
  }

  Color getColor() {
    switch (_state) {
      case AsyncButtonState.INITED:
        return primaryTextColor;
      case AsyncButtonState.LOADING:
        return loadingTextColor;
      case AsyncButtonState.LOADED:
        return successTextColor;
      case AsyncButtonState.FAILED:
        return failedTextColor;
      default:
        return primaryTextColor;
    }
  }

  String getText() {
    switch (_state) {
      case AsyncButtonState.INITED:
        return primaryText;
      case AsyncButtonState.LOADING:
        return loadingText;
      case AsyncButtonState.LOADED:
        return successText;
      case AsyncButtonState.FAILED:
        return failedText;
      default:
        return primaryText;
    }
  }

  bool isLoading() {
    return _state == LOADING ? true : false;
  }

  bool get clickable {
    return _state == INITED || _state == FAILED || _state == LOADED
        ? true
        : false;
  }
}

class AsyncButton extends StatefulWidget {
  const AsyncButton(
      {super.key,
      required this.onPressed,
      required this.primaryBackground,
      required this.primaryTextColor,
      required this.loadingBackground,
      required this.loadingTextColor,
      required this.failedTextColor,
      required this.failedBackground,
      required this.successBackground,
      required this.successTextColor,
      required this.progressBarColor,
      required this.primaryText,
      required this.loadingText,
      required this.failedText,
      required this.successText,
      required this.width});

  final Future<bool> Function() onPressed;

  final Color primaryBackground;
  final Color primaryTextColor;
  final Color loadingBackground;
  final Color loadingTextColor;
  final Color failedBackground;
  final Color failedTextColor;
  final Color successBackground;
  final Color successTextColor;
  final Color progressBarColor;
  final String primaryText;
  final String loadingText;
  final String failedText;
  final String successText;
  final double width;
  @override
  State<AsyncButton> createState() => _AsyncButtonState();
}

class _AsyncButtonState extends State<AsyncButton> {
  late AsyncButtonState state;
  @override
  void initState() {
    super.initState();
    state = AsyncButtonState(
        stateFunction: setState,
        state: AsyncButtonState.INITED,
        primaryBackground: widget.primaryBackground,
        primaryTextColor: widget.primaryTextColor,
        loadingBackground: widget.loadingBackground,
        loadingTextColor: widget.loadingTextColor,
        failedTextColor: widget.failedTextColor,
        failedBackground: widget.failedBackground,
        successBackground: widget.successBackground,
        successTextColor: widget.successTextColor,
        progressBarColor: widget.progressBarColor,
        primaryText: widget.primaryText,
        loadingText: widget.loadingText,
        failedText: widget.failedText,
        successText: widget.successText);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (state.clickable) {
          state.setState(AsyncButtonState.LOADING);
          widget.onPressed().then((value) {
            if (value) {
              state.setState(AsyncButtonState.LOADED);
            } else {
              state.setState(AsyncButtonState.FAILED);
            }
          });
        }
      },
      child: Container(
        height: 50,
        width: widget.width,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: state.getBackgroundColor(),
            borderRadius: BorderRadius.circular(30)),
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                    child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 16),
                      Text(
                        state.getText(),
                        style: TextStyle(
                          color: state.getColor(),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.16,
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 12,
                        height: 12,
                        child: state.isLoading()
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              )
                            : const SizedBox(),
                      )
                    ],
                  ),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}

AsyncButton getMinimalAsyncButton(
    context,
    Future<bool> Function() onPressed,
    String primaryText,
    String failedText,
    String loadingText,
    String successText,
    Color background,
    Color textColor,
    double width) {
  return AsyncButton(
      width: width,
      onPressed: onPressed,
      primaryBackground: background,
      primaryTextColor: textColor,
      loadingBackground: background,
      loadingTextColor: textColor,
      failedTextColor: textColor,
      failedBackground: background,
      successBackground: background,
      successTextColor: textColor,
      progressBarColor: textColor,
      primaryText: primaryText,
      loadingText: loadingText,
      failedText: failedText,
      successText: successText);
}

AsyncButton getPrimaryAsyncButton(
    context,
    Future<bool> Function() onPressed,
    String primaryText,
    String loadingText,
    String failedText,
    String successText,
    double width) {
  return getMinimalAsyncButton(context, onPressed, primaryText, failedText,
      loadingText, successText, Colors.blue, Colors.white, width);
}
