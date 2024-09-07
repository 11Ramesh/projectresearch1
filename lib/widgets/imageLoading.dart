import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:projectresearch/consts/size/screenSize.dart';
import 'package:projectresearch/widgets/height.dart';
import 'package:projectresearch/widgets/text.dart';
import 'package:shimmer/shimmer.dart';

class ImageLoading extends StatelessWidget {
  const ImageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: ScreenUtil.screenWidth * 0.6, // Set your desired width
        height: ScreenUtil.screenWidth * 0.6, // Set your desired height
        decoration: BoxDecoration(
          color: Colors.grey[300], // Base color for the skeleton
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.image, // Or any icon representing an image
          color: Colors.grey[400], // Slightly darker grey for the icon
          size: 50,
        ),
      ),
    );
  }
}
