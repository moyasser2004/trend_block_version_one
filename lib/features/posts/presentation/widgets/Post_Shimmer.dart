import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Profile Picture
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name
                        Container(
                          width: 150,
                          height: 15,
                          color: Colors.white,
                        ),
                        SizedBox(height: 5),
                        // Time
                        Container(
                          width: 100,
                          height: 12,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 5),
                // Image Placeholder
                Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                // Reactions and Comments
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100,
                      height: 15,
                      color: Colors.white,
                    ),
                    Container(
                      width: 100,
                      height: 15,
                      color: Colors.white,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // Post Text
                Container(
                  width: double.infinity,
                  height: 15,
                  color: Colors.white,
                ),
                SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  height: 15,
                  color: Colors.white,
                ),
                SizedBox(height: 5),
                Container(
                  width: 200,
                  height: 15,
                  color: Colors.white,
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile and Name
                Row(
                  children: [
                    // Profile Picture
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name
                        Container(
                          width: 150,
                          height: 15,
                          color: Colors.white,
                        ),
                        SizedBox(height: 5),
                        // Time
                        Container(
                          width: 100,
                          height: 12,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 5),
                // Image Placeholder
                Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                // Reactions and Comments
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100,
                      height: 15,
                      color: Colors.white,
                    ),
                    Container(
                      width: 100,
                      height: 15,
                      color: Colors.white,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // Post Text
                Container(
                  width: double.infinity,
                  height: 15,
                  color: Colors.white,
                ),
                SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  height: 15,
                  color: Colors.white,
                ),
                SizedBox(height: 5),
                Container(
                  width: 200,
                  height: 15,
                  color: Colors.white,
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
