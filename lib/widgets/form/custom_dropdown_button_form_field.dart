import 'package:flutter/material.dart';

class CustomDropdownButtonFormField<T> extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final List<DropdownMenuItem<T>>? items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? enabled;
  final TextStyle? style;
  final TextStyle? dropdownStyle; // Added for customizing dropdown text style
  final int? elevation;
  final Color? dropdownColor;
  final double? itemHeight;
  final EdgeInsetsGeometry? contentPadding;

  const CustomDropdownButtonFormField({
    super.key,
    this.labelText,
    this.hintText,
    this.errorText,
    this.items,
    this.value,
    this.onChanged,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.style,
    this.dropdownStyle,
    this.elevation = 8,
    this.dropdownColor,
    this.itemHeight,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              labelText!,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                // You can customize the label style here
              ),
            ),
          ),
        DropdownButtonFormField<T>(
          value: value,
          onChanged: enabled == true ? onChanged : null,
          validator: validator,
          items: items,
          decoration: InputDecoration(
            hintText: hintText,
            errorText: errorText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: Colors.grey[400]!,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Colors.red),
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            contentPadding: contentPadding ??
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            hintStyle: TextStyle(color: Colors.grey[400]),
          ),
          style: style,
          dropdownColor: dropdownColor,
          elevation: elevation!,
          itemHeight: itemHeight,
          // You can customize the dropdown text style here
          // dropdownTextStyle: dropdownStyle,
        ),
      ],
    );
  }
}
