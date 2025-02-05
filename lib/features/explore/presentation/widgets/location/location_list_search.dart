import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:trend/features/explore/data/models/local/location_details.dart';
import 'package:trend/features/explore/presentation/manager/location/location_state.dart';

import '../../../../../shared/const/colors.dart';
import '../../../../../shared/core/enum.dart';
import '../../manager/location/location_bloc.dart';
import 'location_search_container.dart';

class LocationListSearch extends StatelessWidget {
  const LocationListSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationSearchesBloc, LocationSearchState>(
      builder: (context, state) {
        print("State Request Status: ${state.requestStatus}");

        switch (state.requestStatus) {
          case RequestStates.loading:
            return _buildLoadingList();
          case RequestStates.loaded:
            return _buildLocationList(state);
          case RequestStates.error:
            return _buildErrorMessage(state.searchMessage);
          case RequestStates.empty:
            return const SliverToBoxAdapter(child: SizedBox.shrink());
        }
      },
    );
  }

  Widget _buildLoadingList() {
    return SliverList.builder(
      itemCount: 9, // Skeleton placeholders
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Skeletonizer.zone(
            effect: ShimmerEffect(
              duration: const Duration(milliseconds: 1500),
              baseColor: Color(AppColors.greyLight),
              highlightColor: Color(AppColors.white),
            ),
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 0,
              color: Color(AppColors.white),
              child: const ListTile(
                leading: Icon(
                  Icons.location_on,
                  color: Color(AppColors.greyDark),
                ),
                title: Bone.text(words: 2),
                subtitle: Bone.text(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLocationList(LocationSearchState state) {
    final locations = state.searchResult.results?.locations ?? [];

    return SliverList.builder(
      itemCount: locations.length,
      itemBuilder: (context, index) {
        final location = locations[index];

        return LocationSearchContainer(
          model: LocationDetails(
            id: "${location.id}",
            location_name: location.locationName ?? "Unknown",
            slug: location.slug ?? "N/A",
            city: location.city ?? "Unknown",
            latitude: location.latitude ?? "0.0",
            longitude: location.longitude ?? "0.0",
            description: location.description ?? "No Description",
            posts_count: location.postsCount?.toString() ?? "0",
            last_activity: location.lastActivity ?? "No Activity",
          ),
        );
      },
    );
  }

  Widget _buildErrorMessage(String message) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        child: Center(child: Text(message)),
      ),
    );
  }
}
