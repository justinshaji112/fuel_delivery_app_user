// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'service_cubit.dart';

sealed class ServiceState extends Equatable {
  const ServiceState();

  @override
  List<Object> get props => [];
}

final class ServiceInitial extends ServiceState {}

class ServiceError extends ServiceState {
  String error;
  ServiceError({
    required this.error,
  });
}

class ServiceSuccess extends ServiceState {
  List<ServiceModel> services;
  ServiceSuccess({required this.services});
}

class ServiceLoading extends ServiceState {}
