// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'allservices_bloc.dart';

sealed class AllservicesEvent extends Equatable {
  const AllservicesEvent();

  @override
  List<Object> get props => [];
}

class GetServicesEvnt extends AllservicesEvent {
  
  GetServicesEvnt();
}
