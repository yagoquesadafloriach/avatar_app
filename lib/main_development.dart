import 'package:avatars_app/app/app.dart';
import 'package:avatars_app/bootstrap.dart';

void main() {
  bootstrap(
    builder: (replicateApiRepository) => App(
      replicateApiRepository: replicateApiRepository,
    ),
  );
}
