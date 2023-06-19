part of 'gettodo_bloc.dart';
// ---------------------------------------------------------------------------------------
// GetEvent
@immutable
abstract class GettodoEvent extends Equatable {
  const GettodoEvent();
}

class GetTodoEvent extends GettodoEvent {
  @override
  List<Object?> get props => [];
}

// ---------------------------------------------------------------------------------------
// PostEvent
@immutable
abstract class PosttodoEvent {}

class PostEvent extends PosttodoEvent {
  final String task;

  PostEvent({required this.task});
}

// ---------------------------------------------------------------------------------------
// UpdateEvent
@immutable
abstract class UpdatetodoEvent {}

class UpdateEvent extends UpdatetodoEvent {
  final String task;
  final String id;

  UpdateEvent({required this.task,required this.id});
}

// ---------------------------------------------------------------------------------------
// DeleteEvent
@immutable
abstract class DeletetodoEvent {}

class DeleteEvent extends DeletetodoEvent {
  final String id;

  DeleteEvent({required this.id});
}
