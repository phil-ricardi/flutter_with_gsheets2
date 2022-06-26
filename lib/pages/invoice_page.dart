import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

import '../utils/utils.dart';

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
  bool _statusHasError = true;
  bool _jobTypeHasError = true;
  bool _serviceTypeHasError = true;
  bool autoValidate = true;
  bool showSegmentedControl = true;
  bool readOnly = false;

  final jobStatus = ['Completed', 'In Progress', 'Waiting', 'On Hold'];
  final user = <String, dynamic>{"employee": ""};
  static DateTime dt = DateTime.now();

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
        title: const Text('Invoice Form'),
        centerTitle: true,
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
                    //! DATE
                    FormBuilderDateTimePicker(
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
                    //! JOB TYPE.
                    FormBuilderRadioGroup<String>(
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
                        'Air Conditioning',
                        'Other',
                      ]
                          .map(
                            (lang) => FormBuilderFieldOption(
                              value: lang,
                              child: Text(lang),
                            ),
                          )
                          .toList(growable: false),
                      controlAffinity: ControlAffinity.trailing,
                      valueTransformer: (val) => val?.toString(),
                    ),
                    //! START TIME.
                    FormBuilderDateTimePicker(
                      name: 'start time',
                      controller: _startTimeController,
                      timePickerInitialEntryMode: TimePickerEntryMode.dial,
                      initialValue:
                          DateTime.now().subtract(const Duration(hours: 1)),
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
                    //! END TIME.
                    FormBuilderDateTimePicker(
                      name: 'end time',
                      controller: _endTimeController,
                      timePickerInitialEntryMode: TimePickerEntryMode.dial,
                      initialValue: DateTime.now(),
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
                    //! SLIDER.
                    FormBuilderSlider(
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
                    //! RANGE SLIDER.
                    FormBuilderRangeSlider(
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
                    //! JOB STATUS.
                    FormBuilderDropdown<String>(
                      name: 'status',
                      decoration: InputDecoration(
                        labelText: 'Status',
                        suffix: _statusHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                      ),
                      initialValue: null,
                      //- allowClear: true,
                      hint: const Text('Select Job Status'),
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required()]),
                      items: jobStatus
                          .map((status) => DropdownMenuItem(
                                alignment: AlignmentDirectional.center,
                                value: status,
                                child: Text(status),
                              ))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _statusHasError = !(_formKey
                                  .currentState?.fields['status']
                                  ?.validate() ??
                              false);
                        });
                      },
                      valueTransformer: (val) => val?.toString(),
                    ),
                    //! SERVICE TYPE.
                    FormBuilderRadioGroup<String>(
                      name: 'service type',
                      decoration: InputDecoration(
                        labelText: 'Service Type',
                        suffix: _serviceTypeHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                      ),
                      initialValue: null,
                      onChanged: (val) {
                        setState(() {
                          _serviceTypeHasError = !(_formKey
                                  .currentState?.fields['service type']
                                  ?.validate() ??
                              false);
                        });
                      },
                      validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()],
                      ),
                      options: ['Scheduled', 'Emergency', 'Weekend', 'Other']
                          .map(
                            (lang) => FormBuilderFieldOption(
                              value: lang,
                              child: Text(lang),
                            ),
                          )
                          .toList(growable: false),
                      controlAffinity: ControlAffinity.trailing,
                      valueTransformer: (val) => val?.toString(),
                    ),
                    //! JOB DESCRIPTION
                    FormBuilderTextField(
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
                    //! CHECKBOX
                    FormBuilderCheckbox(
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
                  //! SUBMIT BUTTON
                  Expanded(
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
                              // 'status': _statusController.text,
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
                  //! RESET BUTTON
                  Expanded(
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
