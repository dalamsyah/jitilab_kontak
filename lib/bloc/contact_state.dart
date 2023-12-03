import 'package:equatable/equatable.dart';
import 'package:kontak_jitilab_dimasalamsyah_test/models/contact.dart';

abstract class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object?> get props => [];
}

class ContactInitial extends ContactState {}

class ContactLoading extends ContactState {}

class ContactLoaded extends ContactState {
  final List<Contact> list;
  const ContactLoaded(this.list);
}

class ContactError extends ContactState {
  final String? message;
  const ContactError(this.message);
}