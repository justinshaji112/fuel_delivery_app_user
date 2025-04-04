import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuel_delivery_app_user/models/slot_model.dart';
import 'package:fuel_delivery_app_user/repository/time_slot_repo.dart';

part 'time_slot_state.dart';

class TimeSlotCubit extends Cubit<TimeSlotState> {
  TimeSlotRepo timeSlotRepo;
  TimeSlotCubit({required this.timeSlotRepo}) : super(TimeSlotInitial());

  getTimeSlots({required serviceId, required DateTime date}) async {
    emit(TimeSlotLoading());
    try {
      List<TimeSlotModel> slots = await timeSlotRepo.getAvailableSlots(
          serviceId: serviceId, date: date);
      emit(TimeSlotSuccess(slots: slots));
    } catch (e) {
      emit(TimeSlotError(error: e.toString()));
    }
  }
}
