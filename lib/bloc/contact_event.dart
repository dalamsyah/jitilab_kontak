import 'package:equatable/equatable.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

class GetContactList extends ContactEvent {
  final String genderFilter;
  final String nameFilter;

  GetContactList(this.genderFilter, this.nameFilter);

}