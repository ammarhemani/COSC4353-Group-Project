import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool isLoading;
  final Widget? child;
  const CustomElevatedButton({super.key, this.onPressed, this.isLoading = false, this.child});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2)))),
      child: isLoading ? SizedBox(height: 12, width: 12, child: CircularProgressIndicator(strokeWidth: 2)) : child,
    );
  }
}
