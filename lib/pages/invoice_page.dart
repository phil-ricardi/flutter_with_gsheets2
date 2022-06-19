import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

import '../Utils/utils.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({Key? key}) : super(key: key);

  @override
  InvoicePageState createState() {
    return InvoicePageState();
  }
}

class InvoicePageState extends State<InvoicePage> {
  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _jobDescriptionController =
      TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final String _user = 'philR';

  bool _jobDescriptionHasError = true;
  bool _statisHasError = false;
  bool _jobTypeHasError = true;
  bool autoValidate = true;
  bool showSegmentedControl = true;
  bool readOnly = false;

  final jobStatis = ['Completed', 'In Progress', 'Waiting', 'On Hold'];
  final user = <String, dynamic>{"employee": ""};
  static DateTime dt = DateTime.now();
  final roundup15Min = alignDateTime(dt, const Duration(minutes: 15));

  void _onChanged(dynamic val) => debugPrint(val.toString());

  @override
  void dispose() {
    _dateController.dispose();
    _jobDescriptionController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Builder Example Of Invoice'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FormBuilder(
                key: _formKey,
                // enabled: false,
                onChanged: () {
                  _formKey.currentState!.save();
                  debugPrint(_formKey.currentState!.value.toString());
                },
                autovalidateMode: AutovalidateMode.disabled,

                skipDisabled: true,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 15),
                    FormBuilderDateTimePicker(
                      //! DATE
                      name: 'date',
                      controller: _dateController,
                      initialEntryMode: DatePickerEntryMode.calendar,
                      initialValue: DateTime.now(),
                      inputType: InputType.date,
                      decoration: InputDecoration(
                        labelText: 'Date of Work',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _formKey.currentState!.fields['date']
                                ?.didChange(null);
                          },
                        ),
                      ),
                    ),
                    FormBuilderDateTimePicker(
                      //! START TIME
                      name: 'start time',
                      controller: _startTimeController,
                      timePickerInitialEntryMode: TimePickerEntryMode.dial,
                      initialValue:
                          roundup15Min.subtract(const Duration(hours: 1)),
                      //DateTime.now().subtract(const Duration(hours: 1)),
                      format: DateFormat('hh:mm a'),
                      inputType: InputType.time,
                      decoration: InputDecoration(
                        labelText: 'Start Time',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _formKey.currentState!.fields['time']
                                ?.didChange(null);
                          },
                        ),
                      ),
                    ),
                    FormBuilderDateTimePicker(
                      //! END TIME
                      name: 'end time',
                      controller: _endTimeController,

                      timePickerInitialEntryMode: TimePickerEntryMode.dial,
                      initialValue: roundup15Min,
                      format: DateFormat('hh:mm a'),
                      inputType: InputType.time,
                      decoration: InputDecoration(
                        labelText: 'End Time',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _formKey.currentState!.fields['time']
                                ?.didChange(null);
                          },
                        ),
                      ),
                    ),
                    FormBuilderSlider(
                      //! SLIDER
                      name: 'slider',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.min(6),
                      ]),
                      onChanged: _onChanged,
                      min: 0.0,
                      max: 10.0,
                      initialValue: 7.0,
                      divisions: 20,
                      activeColor: Colors.red,
                      inactiveColor: Colors.pink[100],
                      decoration: const InputDecoration(
                        labelText: 'Number of things',
                      ),
                    ),
                    FormBuilderRangeSlider(
                      //! RANGE SLIDER
                      name: 'range_slider',
                      // validator: FormBuilderValidators.compose([FormBuilderValidators.min(context, 6)]),
                      onChanged: _onChanged,
                      min: 0.0,
                      max: 100.0,
                      initialValue: const RangeValues(4, 7),
                      divisions: 20,
                      activeColor: Colors.red,
                      inactiveColor: Colors.pink[100],
                      decoration:
                          const InputDecoration(labelText: 'Price Range'),
                    ),
                    FormBuilderDropdown<String>(
                      //! JOB STATIS
                      // autovalidate: true,
                      name: 'status',

                      decoration: InputDecoration(
                        labelText: 'Statis',
                        suffix: _statisHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                      ),
                      // initialValue: 'In Progress',
                      allowClear: true,
                      hint: const Text('Select Job Statis'),
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required()]),
                      items: jobStatis
                          .map((statis) => DropdownMenuItem(
                                alignment: AlignmentDirectional.center,
                                value: statis,
                                child: Text(statis),
                              ))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _statisHasError = !(_formKey
                                  .currentState?.fields['statis']
                                  ?.validate() ??
                              false);
                        });
                      },
                      valueTransformer: (val) => val?.toString(),
                    ),
                    FormBuilderRadioGroup<String>(
                      //! JOB TYPE
                      name: 'job type',
                      decoration: InputDecoration(
                        labelText: 'Job Type',
                        suffix: _jobTypeHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                      ),
                      initialValue: null,

                      onChanged: (val) {
                        setState(() {
                          _jobTypeHasError = !(_formKey
                                  .currentState?.fields['job type']
                                  ?.validate() ??
                              false);
                        });
                      },
                      validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()],
                      ),
                      options: [
                        'Plumbing',
                        'Heating',
                        'Emergency',
                        'Weekend',
                        'Other'
                      ]
                          .map((lang) => FormBuilderFieldOption(
                                value: lang,
                                child: Text(lang),
                              ))
                          .toList(growable: false),
                      controlAffinity: ControlAffinity.trailing,
                      valueTransformer: (val) => val?.toString(),
                    ),
                    FormBuilderTextField(
                      //! JOB DESCRIPTION
                      name: 'job description',
                      controller: _jobDescriptionController,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        labelText: 'Job Description',
                        suffix: _jobDescriptionHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _jobDescriptionHasError = !(_formKey
                                  .currentState?.fields['job description']
                                  ?.validate() ??
                              false);
                        });
                      },
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(15),
                        (String? text) {
                          if (text == null || text.isEmpty) {
                            return 'Please enter a job description';
                          } else if (text == 'Enter Job Description') {
                            return 'Please enter a job description';
                          }
                          return null;
                        },
                      ]),
                    ),
                    FormBuilderCheckbox(
                      //! CHECKBOX
                      name: 'accept_terms',
                      initialValue: false,
                      onChanged: _onChanged,
                      title: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'I have read and agree to the ',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: 'Terms and Conditions',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                              ),
                              // Flutter doesn't allow a button inside a button
                              // https://github.com/flutter/flutter/issues/31437#issuecomment-492411086
                              /*
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print('launch url');
                                },
                              */
                            ),
                          ],
                        ),
                      ),
                      validator: FormBuilderValidators.equal(
                        true,
                        errorText:
                            'You must accept terms and conditions to continue',
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    //! SUBMIT
                    child: ElevatedButton(
                      onPressed: () async {
                        // only if form is valid
                        if (_formKey.currentState!.validate()) {
                          try {
                            // Get a reference to the `invoice` collection
                            final invoiceCollection = FirebaseFirestore.instance
                                .collection('invoice');

                            final data = {
                              'employee': _user,
                              'date of job': _dateController.text,
                              'time start': _startTimeController.text,
                              'time end': _endTimeController.text,
                              'job description': _jobDescriptionController.text,
                              //'status': _statusController.text,
                              'timestamp': FieldValue.serverTimestamp(),
                            };

                            await invoiceCollection.doc().set(data);
                            Utils.showSnackBar('Sent successfully to server');
                          } catch (e) {
                            Utils.showSnackBar('Something fucked up!!!!');
                          }
                        }
                      },
                      child: const Text(
                        'Submit to Office',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    //! RESET
                    child: OutlinedButton(
                      onPressed: () {
                        _formKey.currentState?.reset();
                      },
                      child: Text(
                        'Reset Form',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
