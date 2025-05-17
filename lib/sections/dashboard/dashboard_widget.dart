import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  final Widget icon;
  final VoidCallback openFunction;
  final Widget child;
  const HomeWidget(
      {super.key,
      required this.icon,
      required this.openFunction,
      required this.child});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: widget.openFunction,
        child: Container(
          padding: const EdgeInsets.all(5),
          width: double.maxFinite,
          height: 150,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Row(
                children: [widget.icon],
              ),
              widget.child,
            ],
          ),
        ),
      ),
    );
  }
}
