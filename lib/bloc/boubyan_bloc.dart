
import 'package:bloc/bloc.dart';
import 'package:boubyan_steps/repository/modelclass/registerModel.dart';
import 'package:meta/meta.dart';

import '../repository/api/boubyan_api.dart';

part 'boubyan_event.dart';
part 'boubyan_state.dart';

class BoubyanBloc extends Bloc<BoubyanEvent, BoubyanState> {
  late RegisterModel _registerModel ;
  BoubyanApi boubyanApi=BoubyanApi();
  BoubyanBloc() : super(BoubyanInitial()) {
    on<FetchBoubyan>((event, emit)async{
      emit(BoubyanBlocLoading());
      try{

        _registerModel = await boubyanApi.getRegister(event.name,event.dob,
            event.mobile,event.gender,event.isSelectedClient,event.isSelectedNotClient);
        emit(BoubyanBlocLoaded());
      } catch(e){
        print(e);
        emit(BoubyanBlocError());}
    });
  }
}
