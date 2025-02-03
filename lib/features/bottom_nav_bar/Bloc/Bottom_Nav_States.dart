abstract class BottomNavState {
  final int selectedIndex;
  const BottomNavState(this.selectedIndex);
}

class BottomNavInitial extends BottomNavState {
  const BottomNavInitial() : super(0);
}

class BottomNavUpdated extends BottomNavState {
  const BottomNavUpdated(int selectedIndex) : super(selectedIndex);
}
