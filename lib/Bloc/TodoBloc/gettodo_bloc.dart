import 'package:bloc/bloc.dart';
import 'package:client/model/todomodel.dart';
import 'package:client/repository/deletetodorepo.dart';
import 'package:client/repository/gettodorepo.dart';
import 'package:client/repository/positodorepo.dart';
import 'package:client/repository/updatetodorepo.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'gettodo_event.dart';
part 'gettodo_state.dart';

// ---------------------------------------------------------------------------------------
// GetBloc
class GettodoBloc extends Bloc<GettodoEvent, GettodoState> {
  
  GettodoBloc(GettodoRepo gettodoRepo) : super(GettodoInitial()) {
    on<GettodoEvent>((event, emit) async {
      emit(GettodoLoading());
      try {
        final todo = await gettodoRepo.Gettodos();
        emit(Gettodosuccess(todo));
      } catch (e) {
        print(e);
        emit(GettodoError(error: e.toString()));
      }
    });
  }
}
// ---------------------------------------------------------------------------------------
// PostBloc
class PosttodoBloc extends Bloc<PosttodoEvent, PosttodoState> {
  PosttodoBloc(PosttodoRepo posttodoRepo) : super(PosttodoInitial()) {
    on<PostEvent>((event, emit) async {
      emit(PosttodoLoading());

      try {
        final task = await posttodoRepo.Posttodos(task: event.task);
        emit(Posttodosuccess(task));
      } catch (e) {
        print(e);
        emit(PosttodoError(error: e.toString()));
      }
    });
  }
}
// ---------------------------------------------------------------------------------------
// UpdateBloc
class UpdatetodoBloc extends Bloc<UpdatetodoEvent, UpdatetodoState> {
  UpdatetodoBloc(UpdatetodoRepo updatetodoRepo) : super(UpdatetodoInitial()) {
    on<UpdateEvent>((event, emit) async {
      emit(UpdatetodoLoading());

      try {
        // final task = await updatetodoRepo.Updatetodos(task: event.task);
        final id = await updatetodoRepo.Updatetodos(task: event.task, id: event.id);
        emit(Updatetodosuccess(id));
      } catch (e) {
        print(e);
        emit(UpdatetodoError(error: e.toString()));
      }
    });
  }
}
// ---------------------------------------------------------------------------------------
// DeleteBloc
class DeletetodoBloc extends Bloc<DeletetodoEvent, DeletetodoState> {
  DeletetodoBloc(DeletetodoRepo deletetodoRepo) : super(DeletetodoInitial()) {
    on<DeleteEvent>((event, emit) async {
      emit(DeletetodoLoading());

      try {
        final id = await deletetodoRepo.Deletetodos(id: event.id);
        emit(Deletetodosuccess(id));
      } catch (e) {
        print(e);
        emit(DeletetodoError(error: e.toString()));
      }
    });
  }
}
