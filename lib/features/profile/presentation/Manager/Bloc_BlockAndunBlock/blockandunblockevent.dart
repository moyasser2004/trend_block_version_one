abstract class BlockEvent {}

class unBlock extends BlockEvent {
  final int id;
  unBlock({required this.id});
}
