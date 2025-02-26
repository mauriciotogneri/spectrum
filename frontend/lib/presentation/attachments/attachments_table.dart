import 'package:dafluta/dafluta.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/attachment.dart';
import 'package:testflow/domain/types/attachment_type.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_multiple.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/common/table/custom_table.dart';
import 'package:testflow/presentation/dialogs/base_dialog.dart';
import 'package:testflow/presentation/dialogs/confirmation_dialog.dart';
import 'package:testflow/utils/custom_snackbar.dart';
import 'package:testflow/utils/palette.dart';
import 'package:web/web.dart';

class AttachmentsTable extends StatelessWidget {
  final AttachmentsState state;

  const AttachmentsTable._(this.state);

  factory AttachmentsTable.instance() => AttachmentsTable._(AttachmentsState());

  @override
  Widget build(BuildContext context) {
    return StateProvider<AttachmentsState>(
      state: state,
      builder:
          (context, state) => Padding(
            padding: const EdgeInsets.only(top: 16),
            child: CustomTable<Attachment, AttachmentColumn, AttachmentMenu>(
              columns: Attachment.columns,
              rows: state.attachments,
              onSelected: state.onAttachmentSelected,
              onResetFilters: state.hasFilters ? state.onResetFilters : null,
              onCreateItem: () => state.onUploadAttachment(context),
              createButtonText: 'Upload',
              createButtonIcon: Icons.file_upload_outlined,
              onMenuSelected:
                  (item, menu) => state.onTableMenuSelected(
                    context: context,
                    attachment: item,
                    menu: menu,
                  ),
              filters: [
                CustomTextInput(
                  width: 250,
                  hint: 'Filter…',
                  canClear: true,
                  prefixIcon: Icons.search,
                  controller: state.queryFilterController,
                  onChanged: (_) => state.notify(),
                ),
                const HBox(8),
                CustomDropdownMultiple<AttachmentType>(
                  width: 200,
                  values: AttachmentType.items,
                  controller: state.typeFilterController,
                  onSelected: (_) => state.notify(),
                  hint: 'Type',
                ),
              ],
            ),
          ),
    );
  }
}

class AttachmentsState extends BaseState {
  final CustomTextInputController queryFilterController =
      CustomTextInputController();
  final CustomDropdownMultipleController<AttachmentType> typeFilterController =
      CustomDropdownMultipleController();

  List<Attachment> get attachments =>
      Data.attachments()
          .where(
            (attachment) => attachment.matches(
              queryFilter: queryFilterController.text,
              typeFilter: typeFilterController.selected,
            ),
          )
          .toList();

  bool get hasFilters =>
      queryFilterController.isNotEmpty || typeFilterController.isNotEmpty;

  void onResetFilters() {
    queryFilterController.clear();
    typeFilterController.clear();
    notify();
  }

  Future onUploadAttachment(BuildContext context) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: true,
    );

    if ((result != null) && (context.mounted)) {
      // Check if overriding a file -> show confirmation dialog
      CustomSnackbar.show(
        context: context,
        message:
            'Uploading ${result.files.length} file${result.files.length > 1 ? 's' : ''}…',
      );
    }
  }

  void onAttachmentSelected(Attachment attachment) =>
      window.open(attachment.url);

  void _downloadAttachment(Attachment attachment) {}

  void _deleteAttachmentConfirmation({
    required BuildContext context,
    required Attachment attachment,
  }) => BaseDialog.show(
    context: context,
    dialog: ConfirmationDialog(
      message: 'Do you want to delete the attachment?',
      acceptButtonText: 'Delete',
      acceptButtonColor: Palette.borderButtonError,
      onAccept:
          () => _deleteAttachment(context: context, attachment: attachment),
    ),
  );

  void _deleteAttachment({
    required BuildContext context,
    required Attachment attachment,
  }) {
    Data.deleteAttachment(attachment);
    notify();
  }

  void onTableMenuSelected({
    required BuildContext context,
    required Attachment attachment,
    required AttachmentMenu menu,
  }) {
    switch (menu) {
      case AttachmentMenu.download:
        _downloadAttachment(attachment);
        break;
      case AttachmentMenu.delete:
        _deleteAttachmentConfirmation(context: context, attachment: attachment);
        break;
    }
  }
}
