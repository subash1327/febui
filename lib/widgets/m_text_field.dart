import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum FInputType{
  text, numeric, decimal, email, phone, password
}

extension FInputTypeExtension on FInputType {
  TextInputType keyboardType(){
    switch(this){
      case FInputType.text: return TextInputType.name;
      case FInputType.numeric: return TextInputType.number;
      case FInputType.decimal: return const TextInputType.numberWithOptions(decimal: true);
      case FInputType.email: return TextInputType.emailAddress;
      case FInputType.phone: return TextInputType.phone;
      case FInputType.password: return TextInputType.visiblePassword;
    }
  }
}

class FTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? suffixIcon, prefixIcon;
  final Function(String)? onChanged;
  final FInputType type;
  final String? label, hint, value;
  final bool required;
  const FTextField({this.controller,this.label, this.value, this.hint, this.type = FInputType.text, Key? key, this.onChanged, this.suffixIcon, this.prefixIcon, this.required = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: value,
      onChanged: onChanged,
      keyboardType: type.keyboardType(),
      validator: (s){
        if(required && s!.isEmpty) return '$label is required.';
        if(type == FInputType.phone && s!.length != 10) return 'Invalid $label';
        if(type == FInputType.email){
          bool valid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(s!);
          if(!valid) return 'Invalid $label';
        }
        return null;
      },
      maxLength: type == FInputType.phone ? 10 : null,
      inputFormatters: [
        if(type == FInputType.numeric || type == FInputType.phone)FilteringTextInputFormatter.digitsOnly,
        if(type == FInputType.decimal)FilteringTextInputFormatter.allow(RegExp('[[0-9]|\\.|[0-9]]'))
      ],
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        label: Text(label ?? ''),
        hintText: hint,
        counter: const SizedBox(height: 0,)
      ),
    );
  }
}
