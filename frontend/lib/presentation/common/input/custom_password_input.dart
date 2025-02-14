import 'package:testflow/presentation/common/input/custom_text_input.dart';

class CustomPasswordInput extends CustomTextInput {
  const CustomPasswordInput({
    required super.hint,
    required super.controller,
    super.keyboardType,
    super.textInputAction,
    super.capitalization,
    super.enabled,
    super.autofocus,
    super.readOnly,
    super.filled,
    super.autofillHints,
    super.prefixIcon,
    super.maxLength,
    super.onChange,
  }) : super(obscureText: true, maxLines: 1);
}
