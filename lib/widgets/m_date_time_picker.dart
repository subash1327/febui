import 'package:flutter/material.dart';


class FDateTimePicker extends StatefulWidget {
  final String? label;

  final DateTime? initial;
  final DateTime start, end;
  final Function(DateTime?)? onChanged;


  const FDateTimePicker(
      {this.label,
      this.onChanged,
      this.initial,
      required this.start,
      required this.end,
      Key? key})
      : super(key: key);

  @override
  _FDateTimePickerState createState() => _FDateTimePickerState();
}

class _FDateTimePickerState extends State<FDateTimePicker> {
  DateTime value = DateTime.now();

  bool neverEnds = true;

  @override
  void initState() {
    super.initState();
    if (widget.initial != null) {
      neverEnds = false;
      value = widget.initial!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).accentColor;

    return Stack(
      children: [
        InputDatePickerFormField(
          key: ValueKey(value),
          lastDate: widget.end,
          firstDate: widget.start,
          initialDate: value,
          fieldLabelText: widget.label,
          onDateSubmitted: (d) {
            setState(() {
              value = d;
            });
            widget.onChanged?.call(d);
          },
          onDateSaved: (d) {
            setState(() {
              value = d;
            });
            widget.onChanged?.call(d);
          },
          selectableDayPredicate: (d) {
            return true;
          },
          keyboardType: TextInputType.datetime,
        ),
        Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          child: Material(
            color: Colors.transparent,
    child: IconButton(
            icon: Icon(
              Icons.calendar_month,
              color:Theme.of(context).accentColor,
            ),
            onPressed: () async {
              final selected = await showDatePicker(
                  context: context,
                  initialDate: value,
                  firstDate: widget.start,
                  lastDate: widget.end);

              if (selected != null) {
                setState(() {
                  value = DateTime(selected.year, selected.month,
                      selected.day, value.hour, value.minute, value.second);
                });

                widget.onChanged!(value);
              }
            },
          )
          ),
        )
      ],
    );

  }
}
