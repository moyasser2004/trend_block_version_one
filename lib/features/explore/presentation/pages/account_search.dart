import 'package:flutter/material.dart';
import '../widgets/accounts/account_list_search.dart';


class SearchAccounts extends StatelessWidget {
  const SearchAccounts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        AccountListSearch(),
      ],
    );
  }
}
