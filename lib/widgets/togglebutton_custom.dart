import 'package:flutter/material.dart';

class PremisesRentalsToggle extends StatelessWidget {
  final bool isRentals;
  final ValueChanged<bool> onToggle;
  final String firstText;
  final String secondText;

  const PremisesRentalsToggle({
    super.key,
    required this.isRentals,
    required this.onToggle,
    required this.firstText,
    required this.secondText,
  });

  @override
  Widget build(BuildContext context) {
    const borderRadius = Radius.circular(10);
    const olive = Color(0xFF8A734F);

    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // Left: Your premises
          Expanded(
            child: GestureDetector(
              onTap: () => onToggle(false),
              child: Container(
                decoration: BoxDecoration(
                  color: isRentals ? Colors.transparent : olive,
                  borderRadius: const BorderRadius.only(
                      topLeft: borderRadius, bottomLeft: borderRadius),
                ),
                alignment: Alignment.center,
                child: Text(
                  firstText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isRentals ? Colors.black87 : Colors.white,
                  ),
                ),
              ),
            ),
          ),

          // Right: Your rentals
          Expanded(
            child: GestureDetector(
              onTap: () => onToggle(true),
              child: Container(
                decoration: BoxDecoration(
                  color: isRentals ? olive : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                      topRight: borderRadius, bottomRight: borderRadius),
                ),
                alignment: Alignment.center,
                child: Text(
                  secondText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isRentals ? Colors.white : Colors.black87,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
