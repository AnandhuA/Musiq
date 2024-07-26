import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SuggetionShimmerWidget extends StatelessWidget {
  final String title;
  const SuggetionShimmerWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "   $title Songs",
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10, // Number of shimmer items
              itemBuilder: (context, index) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[200]!,
                  ),
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 180,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
