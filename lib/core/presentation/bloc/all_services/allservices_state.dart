// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'allservices_bloc.dart';

sealed class AllservicesState extends Equatable {
  const AllservicesState();

  @override
  List<Object> get props => [];
}

final class AllservicesInitial extends AllservicesState {}

class DataProsesingState extends AllservicesState {}

class DataErrorState extends AllservicesState {
  String message;
  DataErrorState({
    required this.message,
  });
}

class ServiceGotState extends AllservicesState {
  Map<String, List<ServiceModel>> services;
  ServiceGotState({
    required this.services,
  });
}
