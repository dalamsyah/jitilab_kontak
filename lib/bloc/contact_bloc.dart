
import 'package:bloc/bloc.dart';
import 'package:kontak_jitilab_dimasalamsyah_test/bloc/contact_event.dart';
import 'package:kontak_jitilab_dimasalamsyah_test/bloc/contact_state.dart';
import 'package:kontak_jitilab_dimasalamsyah_test/resources/api_repository.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc() : super(ContactInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetContactList>((event, emit) async {
      try {
        emit(ContactLoading());
        final mList = await _apiRepository.fetchList(event.genderFilter, event.nameFilter);
        emit(ContactLoaded(mList));
        // if (mList.error != null) {
        //   emit(ContactError(mList.error));
        // }
      } on NetworkError {
        // emit(ContactError("Failed to fetch data. is your device online?"));
      }
    });


  }
}