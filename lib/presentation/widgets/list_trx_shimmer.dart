import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListTrxShimmer extends StatelessWidget {
  const ListTrxShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 3,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _buildTrxItem();
      },
    );
  }

  Widget _buildTrxItem() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28, left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildShimmerBox(height: 19, width: 120),
              SizedBox(height: 4),
              _buildShimmerBox(height: 17, width: 155),
            ],
          ),
          _buildShimmerBox(height: 19, width: 100),
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
