import 'package:flutter/material.dart';

import '../widgets/hashtags/hashtags_list_search.dart';




class HashtagsSearch extends StatelessWidget {
  const HashtagsSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
       slivers: [
         HashtagsListSearch()
       ],
    );
  }
}
