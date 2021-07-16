import 'dart:async';
import 'package:new_ecom_project/core/modules/createTripFileHelp.dart';
import 'package:new_ecom_project/core/services/repository.dart';

class UploadTripBloc {
  final _repository = Repository();
  final _uploadProgressController = StreamController<double>();
  Stream<double> get uploadProgressStream => _uploadProgressController.stream;
  final _uploadStepController = StreamController<int>();
  Stream<int> get uploadStepStream => _uploadStepController.stream;

  percentUpdate(double percent) async {
    _uploadProgressController.sink.add(percent);
  }

  nextStep(int step) {
    _uploadStepController.sink.add(step);
  }

  createTripAPICall() async {
    await _repository.createTrip(tripController).then((value) {
      _uploadStepController.sink.add(4);
    }).catchError((error) {
      print(error);
      _uploadStepController.sink.add(9);
    });
  }

  void dispose() {
    _uploadProgressController.close();
    _uploadStepController.close();
  }
}
