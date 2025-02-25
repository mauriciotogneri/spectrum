import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/presentation/common/button/primary_text_button.dart';
import 'package:testflow/presentation/common/button/secondary_text_button.dart';
import 'package:testflow/presentation/common/form/form_key.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/dialogs/base_dialog.dart';

class CreateTestSessionDialog extends StatelessWidget {
  final CreateTestSessionDialogState state;

  const CreateTestSessionDialog._(this.state);

  factory CreateTestSessionDialog.instance({
    required List<String> platforms,
    required OnCreateTestSession onCreateTestSession,
  }) => CreateTestSessionDialog._(
    CreateTestSessionDialogState(
      platforms: platforms,
      onCreateTestSession: onCreateTestSession,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return StateProvider<CreateTestSessionDialogState>(
      state: state,
      builder:
          (context, state) => BaseDialog(
            title: 'New session',
            width: 350,
            actions: [
              SecondaryTextButton(
                text: 'Cancel',
                onPressed: Navigator.of(context).pop,
              ),
              PrimaryTextButton(
                text: 'Create',
                onPressed: () {
                  if (state.formKey.validate()) {
                    Navigator.of(context).pop();
                    state.onCreate();
                  }
                },
              ),
            ],
            content: FormFields(state),
          ),
    );
  }
}

class FormFields extends StatelessWidget {
  final CreateTestSessionDialogState state;

  const FormFields(this.state);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state.formKey.key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextInput(
            name: 'Name',
            autofocus: true,
            controller: state.nameController,
            errorMessage: 'Name is required',
          ),
          const VBox(16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomDropdownSingle<String>(
                      values: DropdownItem.fromList(state.environments),
                      controller: state.environmentController,
                      name: 'Environment',
                      errorMessage: 'Environment is required',
                    ),
                  ],
                ),
              ),
              const HBox(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomDropdownSingle<String>(
                      values: DropdownItem.fromList(state.platforms),
                      controller: state.platformController,
                      name: 'Platform',
                      errorMessage: 'Platform is required',
                    ),
                  ],
                ),
              ),
            ],
          ),
          const VBox(16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomDropdownSingle<String>(
                      values: DropdownItem.fromList(state.devices),
                      controller: state.deviceController,
                      name: 'Device',
                      errorMessage: 'Device is required',
                    ),
                  ],
                ),
              ),
              const HBox(16),
              Expanded(
                child: CustomTextInput(
                  name: 'Version',
                  controller: state.versionController,
                  errorMessage: 'Version is required',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CreateTestSessionDialogState extends BaseState {
  final List<String> platforms;
  final List<String> environments = [];
  final List<String> devices = [];

  final FormKey formKey = FormKey();
  final OnCreateTestSession onCreateTestSession;
  final CustomTextInputController nameController = CustomTextInputController();
  final CustomDropdownSingleController<String> environmentController =
      CustomDropdownSingleController();
  final CustomDropdownSingleController<String> platformController =
      CustomDropdownSingleController();
  final CustomDropdownSingleController<String> deviceController =
      CustomDropdownSingleController();
  final CustomTextInputController versionController =
      CustomTextInputController();

  CreateTestSessionDialogState({
    required this.platforms,
    required this.onCreateTestSession,
  }) {
    environments.addAll(Data.currentProject.environments);
    devices.addAll(Data.currentProject.devices);

    if (environments.length == 1) {
      environmentController.select(environments.first);
    }

    if (platforms.length == 1) {
      platformController.select(platforms.first);
    }

    if (devices.length == 1) {
      deviceController.select(devices.first);
    }
  }

  void onCreate() => onCreateTestSession(
    name: nameController.text,
    environment: environmentController.selected!,
    platform: platformController.selected!,
    device: deviceController.selected!,
    version: versionController.text,
  );
}

typedef OnCreateTestSession =
    void Function({
      required String name,
      required String environment,
      required String platform,
      required String device,
      required String version,
    });
