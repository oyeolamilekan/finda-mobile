import 'launch_url.dart';

void getPushAction(String data) {
  switch (data) {
    case "UPDATE_APP":
      redirectToAppStore();
      break;
    default:
  }
}
