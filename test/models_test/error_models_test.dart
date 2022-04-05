import 'package:finda/models/error_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Test modesl", () {
    final ErrorModel model = ErrorModel(detail: "test data");
    expect("test data", model.detail);

    final ErrorModel model2 = ErrorModel.fromJson({"detail": "test data"});
    expect("test data", model2.detail);

    final Map decodedData = model2.toJson();
    expect({"detail": "test data"}, decodedData);
  });
}
