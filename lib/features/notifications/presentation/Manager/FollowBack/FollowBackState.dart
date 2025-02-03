abstract class FollowingbackState {}

class FollowingBackInitialState extends FollowingbackState {}

class FollowingBackSuccess extends FollowingbackState {
  final int index;
  FollowingBackSuccess({required this.index});
}

class FollowingBackLoadding extends FollowingbackState {
  final int index;
  FollowingBackLoadding({required this.index});
}

class FollowingBackFailuer extends FollowingbackState {}

class UnFollowingBackSuccess extends FollowingbackState {}

class UnFollowingBackFailuer extends FollowingbackState {}

class UnFollowingBackLoadding extends FollowingbackState {}
