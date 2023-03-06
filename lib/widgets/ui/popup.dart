import 'package:flutter/material.dart';

class Popup extends StatefulWidget {
  const Popup({Key? key, required this.child, this.onClosePressed})
      : super(key: key);

  final Widget child;
  final VoidCallback? onClosePressed;

  @override
  State<Popup> createState() => _PopupState();
}

class _PopupState extends State<Popup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 28, 16, 16),
            child: widget.child,
          ),
          Positioned(
            top: 4,
            right: -8,
            child: TextButton(
              onPressed: () {
                if (widget.onClosePressed != null) {
                  widget.onClosePressed!();
                }
              },
              style: TextButton.styleFrom(
                shape: const CircleBorder(),
              ),
              child: const Icon(
                Icons.close,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
