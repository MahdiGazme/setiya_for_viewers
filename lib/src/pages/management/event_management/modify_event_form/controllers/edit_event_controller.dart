import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../shared/models/enums/page_state_enum.dart';
import '../models/dto/edit_event_dto.dart';
import '../models/management_event_to_edit_view_model.dart';
import '../repositories/edit_event_repository.dart';
import 'base_event_controller.dart';

class EditEventController extends BaseEventController {
  final _repository = EditEventRepository();

  late String eventId;

  @override
  void onInit() {
    eventId = Get.parameters['eventId'] as String;
    getEvent();
    super.onInit();
  }

  Future<void> getEvent() async {
    state.value = PageStateEnum.loading;
    final resultOrException = await _repository.getEventDetails(
      eventId,
    );

    resultOrException.fold(
      (final exception) => state.value = PageStateEnum.retry,
      (final result) {
        _initializeDate(result);
        state.value = PageStateEnum.success;
      },
    );
  }

  void _initializeDate(final ManagementEventToEditViewModel data) {
    title.text = data.title;
    description.text = data.description;
    address.text = data.address;
    minimumRate.text = data.minimumRate.toString();
    maxCapacity.text = data.maxCapacity?.toString() ?? '';
    giftRate.text = data.giftRate.toString();
    if (data.imageId != null) {
      imageIds.add(data.imageId!);
    }
    contactType.value = data.contactType;
    needAcceptMember.value = data.needAcceptMember;
    dateRange.value = JalaliRange(
      start: data.startDate,
      end: data.endDate,
    );
    startTime = initialEventTime(data.startDate, isStartTime: true);
    endTime = initialEventTime(data.endDate, isStartTime: false);
  }

  @override
  void onReleaseButtonTap() async {
    if (formKey.currentState!.validate()) {
      final dto = _createDto();
      await editNewEvent(dto);
    }
  }

  Future<void> editNewEvent(final EditNewEventDto dto) async {
    isLoading.value = true;
    final resultOrException = await _repository.patchNewEvent(
      eventId,
      dto,
    );

    resultOrException.fold(
      (final exception) => isLoading.value = false,
      (final result) => Get.back(
        result: true,
      ),
    );
  }

  EditNewEventDto _createDto() => EditNewEventDto(
        title: title.text,
        description: description.text,
        minimumRate: minimumRate.text.isEmpty
            ? 0
            : int.parse(
                minimumRate.text,
              ),
        giftRate: giftRate.text.isEmpty
            ? 0
            : int.parse(
                giftRate.text,
              ),
        startDate: startTime != null
            ? dateRange.value!.start.copy(
                hour: startTime!.hour,
                minute: startTime!.minute,
              )
            : dateRange.value!.start,
        endDate: endTime != null
            ? dateRange.value!.end.copy(
                hour: endTime!.hour,
                minute: endTime!.minute,
              )
            : dateRange.value!.end.copy(
                hour: 23,
                minute: 59,
              ),
        address: address.text,
        contactType: contactType.value,
        needAcceptMember: needAcceptMember.value,
        imageId: imageIds.isEmpty ? null : imageIds.first,
        maxCapacity: maxCapacity.text.isEmpty
            ? null
            : int.parse(
                maxCapacity.text,
              ),
        price: price.text.isEmpty
            ? null
            : int.parse(
                price.text,
              ),
      );

  TimeOfDay? initialEventTime(final Jalali dateTime,
      {required final bool isStartTime}) {
    final time = TimeOfDay(
      hour: dateTime.hour,
      minute: dateTime.minute,
    );
    if (isStartTime) {
      return timeOfDayToDouble(time) == 0.0 ? null : time;
    } else {
      return timeOfDayToDouble(time) == 23.983333333333334 ? null : time;
    }
  }

  @override
  void onRetryButtonTap() async => await getEvent();
}
