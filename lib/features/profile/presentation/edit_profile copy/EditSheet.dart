import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trend/features/profile/presentation/edit_profile%20copy/LineLimitInputFormatter.dart';

class EditBottomSheet extends StatefulWidget {
  final String x;
  final int Lenght;
  final int line;
  final VoidCallback onCancel;
  final double heightfactor;
  final void Function(String)? onChanged;
  const EditBottomSheet({
    Key? key,
    required this.x,
    required this.onCancel,
    required this.onChanged,
    required this.Lenght,
    required this.line,
    required this.heightfactor,
  }) : super(key: key);

  @override
  _EditBottomSheetState createState() => _EditBottomSheetState();
}

class _EditBottomSheetState extends State<EditBottomSheet> {
  late TextEditingController _controller;
  String fullName = '';

  @override
  void initState() {
    super.initState();
    fullName = widget.x;
    _controller = TextEditingController(
      text: fullName.isEmpty ? widget.x : fullName,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, cons) {
        final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            color: Colors.white,
          ),
          child: FractionallySizedBox(
            heightFactor: isKeyboardOpen ? 1 : widget.heightfactor,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  height: 5,
                  width: 70,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Done",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        widget.x,
                        style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        fullName = '';
                        widget.onCancel();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    onChanged: widget.onChanged,
                    maxLength: widget.Lenght,
                    controller: _controller,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xffFAFAFA),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffFAFAFA)),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffFAFAFA)),
                      ),
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(widget.Lenght),
                      LineLimitInputFormatter(widget.line),
                    ],
                    maxLines: widget.line,
                  ),
                ),
                Spacer(),
                Container(
                  height: 5,
                  width: 134,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                ),
                SizedBox(
                  height: 5,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
