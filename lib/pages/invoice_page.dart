import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({Key? key}) : super(key: key);

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  bool autoValidate = true,
      readOnly = false,
      showSegmentedControl = true,
      _ageHasError = false,
      _genderHasError = false;
  final _formKey = GlobalKey<FormBuilderState>();
  final user = FirebaseAuth.instance.currentUser!;

  var genderOptions = ['Male', 'Female', 'Other'];

  void _onChanged(dynamic val) => debugPrint(val.toString());

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {},
          ),
          title: Text(
            user.email!,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                FormBuilder(
                    key: _formKey,
                    onChanged: () {
                      _formKey.currentState!.save();
                      debugPrint(_formKey.currentState!.value.toString());
                    },
                    autovalidateMode: AutovalidateMode.disabled,
                    initialValue: const {
                      'movie_ratng': 5,
                      'best_language': 'Dart',
                      'age': '13',
                      'gender': 'Male',
                    },
                    skipDisabled: true,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 15),
                        FormBuilderDateTimePicker(
                          name: 'date',
                          initialEntryMode: DatePickerEntryMode.calendar,
                          initialValue: DateTime.now(),
                          inputType: InputType.both,
                          decoration: InputDecoration(
                            labelText: 'Appointment Time',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                _formKey.currentState!.fields['date']
                                    ?.didChange(null);

                                /// finish up in pub.dev package
                                ///
                              },
                            ),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      );
}
