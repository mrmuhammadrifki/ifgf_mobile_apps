import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListNatsShimmer extends StatelessWidget {
  const ListNatsShimmer({super.key});

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
        _buildShimmerBox(height: 21, width: 80),
        SizedBox(height: 8),
        _buildShimmerBox(height: 21, width: double.infinity),
        SizedBox(height: 8),
        _buildShimmerBox(height: 21, width: 100),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildShimmerBox(height: 24, width: 24),
            SizedBox(width: 8),
            _buildShimmerBox(height: 24, width: 24),
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
