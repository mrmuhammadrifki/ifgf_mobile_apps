import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListEventShimmer extends StatelessWidget {
  const ListEventShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 3,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _buildEventItem();
      },
    );
  }

  Widget _buildEventItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildShimmerBox(height: 180),
        SizedBox(height: 8),
        _buildShimmerBox(height: 21, width: 50),
        SizedBox(height: 8),
        _buildShimmerBox(height: 17, width: 119),
        SizedBox(height: 4),
        _buildShimmerBox(height: 17, width: 181),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildShimmerBox(height: 44)),
            SizedBox(width: 4),
            Expanded(child: _buildShimmerBox(height: 44)),
            SizedBox(width: 4),
            Expanded(child: _buildShimmerBox(height: 44)),
          ],
        ),
        SizedBox(height: 16),
      ],
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
