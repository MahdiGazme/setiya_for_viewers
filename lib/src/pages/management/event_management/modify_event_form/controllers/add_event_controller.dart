import 'package:get/get.dart';

import '../models/dto/add_new_event_dto.dart';

import '../repositories/add_event_repository.dart';
import 'base_event_controller.dart';

class AddEventController extends BaseEventController {
  final _repository = AddEventRepository();

  @override
  void onReleaseButtonTap() async {
    if (formKey.currentState!.validate()) {
      final dto = _createDto();
      await postNewEvent(dto);
    }
  }

  Future<void> postNewEvent(final AddNewEventDto dto) async {
    isLoading.value = true;
    final resultOrException = await _repository.postNewEvent(dto);

    resultOrException.fold(
      (final exception) => isLoading.value = false,
      (final result) => Get.back(
        result: true,
      ),
    );
  }

  AddNewEventDto _createDto() => AddNewEventDto(
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
            : dateRange.value!.end.add(
                hours: 23,
                minutes: 59,
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

  @override
  void onRetryButtonTap() {
    UnimplementedError();
  }
}
