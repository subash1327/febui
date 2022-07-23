import 'package:flutter/material.dart';


class MDropDown<T> extends StatefulWidget {
  final TextEditingController? controller;
  final Widget? suffixIcon, prefixIcon;
  final Function(T?)? onChanged;
  final String? label, hint;
  final List<T> items;
  final T? value;
  final bool required;
  const MDropDown({this.controller,this.label, required this.items, this.value, this.hint, Key? key, this.onChanged, this.suffixIcon, this.prefixIcon, this.required = true}) : super(key: key);

  @override
  State<MDropDown<T>> createState() => _MDropDownState<T>();
}

class _MDropDownState<T> extends State<MDropDown<T>> {
  var value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      elevation: 1,
      borderRadius: BorderRadius.circular(5),
      value: value,

      onChanged: (d){
        setState((){
          value = d;
        });
        widget.onChanged?.call(value);
      },
      validator: (s){
        if(widget.required && s != null) return '${widget.label} is required.';
        return null;
      },
      items: widget.items.map((e) => DropdownMenuItem(child: Text('$e'), value: e,)).toList(),
      decoration: InputDecoration(
          suffixIcon: widget.suffixIcon,
          prefixIcon: widget.prefixIcon,
          label: Text(widget.label ?? ''),
          hintText: widget.hint,
          counter: const SizedBox(height: 0,)
      ),
    );
  }
}