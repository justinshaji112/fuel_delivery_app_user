part of 'time_slot_cubit.dart';

sealed class TimeSlotState extends Equatable {
  const TimeSlotState();

  @override
  List<Object> get props => [];
}

final class TimeSlotInitial extends TimeSlotState {}



final class TimeSlotSuccess extends TimeSlotState {
  List<TimeSlotModel> slots;
  TimeSlotSuccess({required this.slots});

}

final class TimeSlotError extends TimeSlotState {
  String error;
  TimeSlotError({required this.error});
}

final class TimeSlotLoading extends TimeSlotState {}
