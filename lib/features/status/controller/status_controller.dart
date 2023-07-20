import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watsapp/features/auth/controller/auth_controller.dart';
import 'package:watsapp/features/status/repository/status_repository.dart';

import '../../../common/models/status_model.dart';

final statusControllerProvider = Provider((ref) {
  final statusRepository = ref.read(statusRepositoryProvider);
  return SatatusController(
    statusRepository: statusRepository,
    ref: ref,
  );
});

class SatatusController {
  final StatusRepository statusRepository;
  final ProviderRef ref;

  SatatusController({
    required this.statusRepository,
    required this.ref,
  });

  void addStatus(File file, BuildContext context) {
    ref.watch(userDataAuthProvider).whenData((value) {
      statusRepository.uploadStatus(
        username: value!.profilePic,
        profilePic: value.profilePic,
        phoneNumber: value.phoneNumber,
        statusImage: file,
        context: context,
      );
    });
  }

  Future<List<Status>> getStatus(BuildContext context) async{
    List<Status> statuses = await statusRepository.getStatus(context);
    return statuses;
  }
}
