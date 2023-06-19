part of 'gettodo_bloc.dart';
// ---------------------------------------------------------------------------------------
// GetState
@immutable
abstract class GettodoState extends Equatable {}

class GettodoInitial extends GettodoState {
  @override
  List<Object?> get props => [];
}

class GettodoLoading extends GettodoState {
  @override
  List<Object?> get props => [];
}

class Gettodosuccess extends GettodoState {
  final List<GettodoModel> todo;
  Gettodosuccess(this.todo);

  @override
  List<Object?> get props => [todo];
}

class GettodoError extends GettodoState {
  String? error;
  GettodoError({required this.error});
  @override
  List<Object?> get props => [error];
}
// ---------------------------------------------------------------------------------------
// PostState
@immutable
abstract class PosttodoState {}

class PosttodoInitial extends PosttodoState {
  @override
  List<Object?> get props => [];
}

class PosttodoLoading extends PosttodoState {
  @override
  List<Object?> get props => [];
}

class Posttodosuccess extends PosttodoState {
  final PosttodoModel? task;
  Posttodosuccess(this.task);
}

class PosttodoError extends PosttodoState {
  String? error;
  PosttodoError({required this.error});
  @override
  List<Object?> get props => [error];
}

// ---------------------------------------------------------------------------------------
// UpdateState
@immutable
abstract class UpdatetodoState {}

class UpdatetodoInitial extends UpdatetodoState {
  @override
  List<Object?> get props => [];
}

class UpdatetodoLoading extends UpdatetodoState {
  @override
  List<Object?> get props => [];
}

class Updatetodosuccess extends UpdatetodoState {
  final PosttodoModel? task;
  // final PosttodoModel? id;
  Updatetodosuccess(this.task);
}

class UpdatetodoError extends UpdatetodoState {
  String? error;
  UpdatetodoError({required this.error});
  @override
  List<Object?> get props => [error];
}

// ---------------------------------------------------------------------------------------
// DeleteState
@immutable
abstract class DeletetodoState {}

class DeletetodoInitial extends DeletetodoState {
  @override
  List<Object?> get props => [];
}

class DeletetodoLoading extends DeletetodoState {
  @override
  List<Object?> get props => [];
}

class Deletetodosuccess extends DeletetodoState {
  final PosttodoModel? id;
  Deletetodosuccess(this.id);
}

class DeletetodoError extends DeletetodoState {
  String? error;
  DeletetodoError({required this.error});
  @override
  List<Object?> get props => [error];
}
