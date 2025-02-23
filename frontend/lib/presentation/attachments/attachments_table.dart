import 'package:dafluta/dafluta.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/attachment.dart';
import 'package:testflow/domain/types/attachment_type.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_multiple.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/common/sheet/attachment_sheet.dart';
import 'package:testflow/presentation/common/table/custom_table.dart';
import 'package:testflow/utils/custom_snackbar.dart';
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
            child: CustomTable<Attachment>(
              columns: Attachment.columns,
              rows: state.attachments,
              onSelected:
                  (attachment) => state.onAttachmentSelected(
                    context: context,
                    attachment: attachment,
                  ),
              onResetFilters: state.hasFilters ? state.onResetFilters : null,
              onCreateItem: () => state.onUploadAttachment(context),
              createButtonText: 'Upload',
              createButtonIcon: Icons.file_upload_outlined,
              filters: [
                CustomTextInput(
                  width: 300,
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
      CustomSnackbar.show(
        context: context,
        message:
            'Uploading ${result.files.length} file${result.files.length > 1 ? 's' : ''}…',
      );
    }
  }

  void onAttachmentSelected({
    required BuildContext context,
    required Attachment attachment,
  }) => AttachmentSheet.show(
    context: context,
    onOpen: () => _openAttachment(attachment),
    onDownload: () => _downloadAttachment(attachment),
    onDelete: () => _deleteAttachment(attachment),
  );

  void _openAttachment(Attachment attachment) => window.open(attachment.url);

  void _downloadAttachment(Attachment attachment) {}

  void _deleteAttachment(Attachment attachment) {}
}
