// import 'package:dio/dio.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:trend/features/posts/bloc/comment/states.dart';
// import 'package:trend/features/posts/data/models/post_model.dart';

// class CommentCubit extends Cubit<CommentState> {
//   Dio dio = Dio();
//   CommentCubit() : super(CommentInitial());

//   Future<void> fetchComments(int ID) async {
//     emit(CommentLoading());
//     try {
//       final response = await dio.get(
//         'http://167.71.92.176/posts/$ID/comments/',
//         options: Options(
//           headers: {
//             'Authorization':
//                 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzM3MjY3MTk3LCJpYXQiOjE3MzQ2NzUxOTcsImp0aSI6IjU4MzA3MTc4M2NlODQyMTZhY2IyZWYyMDIxNzQwMTBiIiwidXNlcl9pZCI6Mn0.2lZzGT5QI07y7aeUPya7fm-Pm3zH_sFPvNSA2QznmS8',
//           },
//         ),
//       );

//       if (response.statusCode == 200) {
//         final data = response.data["results"] as List<dynamic>;
//         emit(
//             CommentLoaded(data.map((json) => Comment.fromJson(json)).toList()));
//       } else {
//         throw Exception('Failed to fetch comments');
//       }
//     } catch (e) {
//       throw Exception('Error fetching comments: $e');
//     }
//   }
// }
