import 'package:flutter/material.dart';
import 'package:talabat/constant/constants.dart';

class UploadTask extends StatefulWidget {
  @override
  _UploadTaskState createState() => _UploadTaskState();
}

class _UploadTaskState extends State<UploadTask> {
  TextEditingController _TaskCategoryController =
      TextEditingController(text: "Choose Category");
  TextEditingController _TaskTitleController = TextEditingController();
  TextEditingController _TaskDescriptionController = TextEditingController();
  TextEditingController _deadLineDataController =
      TextEditingController(text: "Choose Deadline");
  final _formKey = GlobalKey<FormState>();
  DateTime? picked;

  void _uploadTask() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      print('it is valid ');
    } else
      print('it is Not valid ');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _TaskCategoryController.dispose();
    _TaskTitleController.dispose();
    _TaskDescriptionController.dispose();
    _deadLineDataController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
        child: Card(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "All Field are required ",
                      style: TextStyle(
                        color: Constant.darkblue,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _textTitle(lable: "Task Category "),
                        _textFormField(
                            valueKey: 'TaskCategory',
                            controller: _TaskCategoryController,
                            enabled: false,
                            fct: () {
                              _ShowTaskCategoryDialog(size: size);
                            },
                            maxlength: 100),
                        //
                        _textTitle(lable: "Task Title "),
                        _textFormField(
                            valueKey: 'TaskTitle',
                            controller: _TaskTitleController,
                            enabled: true,
                            fct: () {},
                            maxlength: 100),
                        //
                        _textTitle(lable: "Task description "),
                        _textFormField(
                            valueKey: 'TaskDescription',
                            controller: _TaskDescriptionController,
                            enabled: true,
                            fct: () {},
                            maxlength: 1000),
                        //
                        _textTitle(lable: "Task deadline data"),
                        _textFormField(
                            valueKey: 'TaskDeadLine',
                            controller: _deadLineDataController,
                            enabled: false,
                            fct: () {
                              _pickDataDialog();
                            },
                            maxlength: 100),

                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: MaterialButton(
                              color: Constant.darkred,
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              onPressed: () {
                                _uploadTask();
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Upload Task",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(
                                      Icons.upload_file,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textFormField(
      {required String valueKey,
      required TextEditingController controller,
      required bool enabled,
      required Function fct,
      required int maxlength}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          fct();
        },
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) return 'value is missing';
            return null;
          },
          controller: controller,
          enabled: enabled,
          key: ValueKey(valueKey),
          style: TextStyle(
              color: Constant.darkblue,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
          maxLines: valueKey == 'TaskDescription' ? 3 : 1,
          maxLength: maxlength,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            filled: true,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            fillColor: Theme.of(context).scaffoldBackgroundColor,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Constant.darkred,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _ShowTaskCategoryDialog({required Size size}) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              "Task Category",
              style: TextStyle(
                  fontSize: 20,
                  color: Constant.darkblue,
                  fontWeight: FontWeight.bold),
            ),
            content: Container(
              width: size.width * 0.2,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: Constant.taskCatigoryList.length,
                itemBuilder: (ctx, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _TaskCategoryController.text =
                            Constant.taskCatigoryList[index];
                      });
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          color: Constant.darkblue,
                        ),
                        //  SizedBox(width:10,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(Constant.taskCatigoryList[index],
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 18,
                                color: Constant.darkblue,
                              )),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: Text('Cancel'),
              ),
            ],
          );
        });
  }

  void _pickDataDialog() async {
    picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 0)),
        lastDate: DateTime(2100));
    if (picked != null) {
      setState(() {
        _deadLineDataController.text =
            '${picked!.year}-${picked!.month}-${picked!.day}';
      });
    }
  }

  Widget _textTitle({required String lable}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        lable,
        style: TextStyle(
          color: Constant.darkred,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
