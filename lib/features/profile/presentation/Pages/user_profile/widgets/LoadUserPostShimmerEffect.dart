import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:trend/shared/const/colors.dart';

class PostSkeleton extends StatelessWidget {
  final int itemCount;
  const PostSkeleton({super.key, this.itemCount = 9});

  // 🔹 عنصر التحميل الفردي
  Widget _buildSkeletonItem() {
    return Skeletonizer.zone(
      effect: ShimmerEffect(
        duration: const Duration(milliseconds: 1500),
        baseColor: Color(AppColors.greyLight),
        highlightColor: Color(AppColors.white),
      ),
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(AppColors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 120,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Bone.circle(size: 50), // دائرة كمكان للصورة
            SizedBox(height: 8),
            Bone.text(words: 1, width: 50), // نص قصير كعنوان
            SizedBox(height: 5),
            Bone.text(words: 2, width: 80), // نص أطول للوصف
          ],
        ),
      ),
    );
  }

  // 🔹 الشبكة (GridView) لعناصر التحميل
  Widget _buildGridSkeleton() {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 عناصر في كل صف
          childAspectRatio: 0.7,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: itemCount, // عدد العناصر الوهمية
        itemBuilder: (context, index) => _buildSkeletonItem(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildGridSkeleton();
  }
}
