import 'package:flutter/cupertino.dart';
import '../widgets/location/location_list_search.dart';


class LocationSearch extends StatelessWidget {
  const LocationSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        LocationListSearch(),
      ],
    );
  }
}
