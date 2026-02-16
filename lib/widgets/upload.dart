import 'package:flutter/material.dart';
import 'package:skavl/theme/colors.dart';
import 'package:dotted_border/dotted_border.dart';

class UploadBox extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final double width;

  const UploadBox({super.key, required this.text, required this.onTap, this.width = 400});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(2),
        dashPattern: const [6, 2],
        color: MyColors.secondaryBlack,
        strokeWidth: 2,
        child: Container(
          width: this.width,
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.cloud_upload_outlined, size: 20, color: MyColors.secondaryBlack),
              const SizedBox(height: 12),
              Text(
                text,
                style: TextStyle(fontSize: 16, color: MyColors.secondaryBlack),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

