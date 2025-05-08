import 'package:flutter/material.dart';
import 'package:ifgf_apps/core/utils/helper.dart';
import 'package:shimmer/shimmer.dart';

class DetailEventShimmer extends StatelessWidget {
  const DetailEventShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Helper.widthScreen(context),
      height: Helper.heightScreen(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildShimmerBox(height: 200),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildShimmerBox(height: 29, width: 146),
                SizedBox(height: 8),
                _buildShimmerBox(height: 17, width: 119),
                SizedBox(height: 4),
                _buildShimmerBox(height: 17, width: 181),
                SizedBox(height: 24),
                _buildShimmerBox(height: 22, width: 78),
                SizedBox(height: 8),
                _buildShimmerBox(height: 17, width: 257),
                SizedBox(height: 8),
                _buildShimmerBox(height: 17, width: 257),
                SizedBox(height: 16),
                _buildShimmerBox(height: 22, width: 78),
                SizedBox(height: 8),
                _buildShimmerBox(height: 17, width: 257),
                SizedBox(height: 8),
                _buildShimmerBox(height: 17, width: 257),
                SizedBox(height: 8),
                _buildShimmerBox(height: 17, width: 257),
                SizedBox(height: 8),
                _buildShimmerBox(height: 17, width: 257),
                SizedBox(height: 16),
                _buildShimmerBox(height: 22, width: 78),
                SizedBox(height: 8),
                _buildShimmerBox(height: 17, width: 257),
                SizedBox(height: 8),
                _buildShimmerBox(height: 17, width: 257),
                SizedBox(height: 8),
                _buildShimmerBox(height: 17, width: 257),
                SizedBox(height: 8),
                _buildShimmerBox(height: 17, width: 257),
                SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildShimmerBox({
  required double height,
  double width = double.infinity,
}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade400,
    highlightColor: Colors.grey.shade100,
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}
