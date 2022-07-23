import 'package:flutter/material.dart';


enum MRadioChipType {
  icon, radio
}

class MRadioChip<T> extends StatelessWidget {
  final List<MRadioItem<T>> items;
  final Function(T)? onChanged;
  final String? label;
  final MRadioChipType type;
  final T? value;
  const MRadioChip({Key? key, required this.items, this.type = MRadioChipType.icon, this.onChanged, this.value, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(label != null)...[
          Text(label!, style: Theme.of(context).textTheme.caption,),
          const SizedBox(height: 8,)
        ],
        Row(
          children: List.generate(items.length, (i){
            final item = items[i];
            final isSel = item.value == value;

            return Expanded(
              child: Material(
                  color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: EdgeInsets.only(right: i != (items.length - 1) ? 16 : 0),
                  child: InkWell(
                    onTap: onChanged != null ? (){
                      onChanged?.call(item.value);
                    }: null,
                    borderRadius: BorderRadius.circular(8),
                    child: type == MRadioChipType.icon ? Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: isSel ? Theme.of(context).accentColor : Colors.grey),


                      ),
                      child: Column(
                        children: [
                          Icon(item.icon, color: Theme.of(context).iconTheme.color, size: 28,),
                          if(item.label != null)...[
                            const SizedBox(height: 8,),
                            Text(item.label!, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.grey.shade800),)]
                        ],
                      ),
                    ) : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio<T>(value: item.value, groupValue: value, onChanged: (d){
                          onChanged?.call(d!);
                        }),
                        if(item.label != null)...[
                          const SizedBox(width: 8,),
                          Text(item.label!, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.grey.shade800),)]
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class MRadioItem<T>{
  final IconData? icon;
  final String? label;
  final T value;
  const MRadioItem({this.label, required this.value, this.icon});
}