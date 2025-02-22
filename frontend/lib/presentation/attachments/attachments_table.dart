import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/attachment.dart';
import 'package:testflow/domain/types/attachment_type.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_multiple.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'dart:html' as html;
import 'package:testflow/presentation/common/table/custom_table.dart';

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
              onSelected: state.onAttachmentSelected,
              onResetFilters: state.hasFilters ? state.onResetFilters : null,
              onCreateItem: state.onUploadAttachment,
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
  final List<Attachment> _allAttachments = [];
  final CustomTextInputController queryFilterController =
      CustomTextInputController();
  final CustomDropdownMultipleController<AttachmentType> typeFilterController =
      CustomDropdownMultipleController();

  List<Attachment> get attachments =>
      _allAttachments
          .where(
            (attachment) => attachment.matches(
              queryFilter: queryFilterController.text,
              typeFilter: typeFilterController.selected,
            ),
          )
          .toList();

  @override
  void onLoad() {
    _allAttachments.addAll(Data.attachments());
    notify();
  }

  bool get hasFilters =>
      queryFilterController.isNotEmpty || typeFilterController.isNotEmpty;

  void onResetFilters() {
    queryFilterController.clear();
    typeFilterController.clear();
    notify();
  }

  void onUploadAttachment() {}

  void onAttachmentSelected(Attachment attachment) =>
      html.window.open(attachment.url, attachment.name);
}
