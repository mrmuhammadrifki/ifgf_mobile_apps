import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListUserShimmer extends StatelessWidget {
  const ListUserShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 3,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: _buildEventItem(),
        );
      },
    );
  }

  Widget _buildEventItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              ClipOval(
                child: _buildShimmerBox(height: 40, width: 40),
              ),
              SizedBox(width: 12),
              _buildShimmerBox(height: 17, width: 140),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildShimmerBox(height: 24, width: 24),
            SizedBox(width: 4),
            _buildShimmerBox(height: 24, width: 24),
          ],
        ),
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
