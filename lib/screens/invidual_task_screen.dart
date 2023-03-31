import 'package:elred_todo_app/data_models/task_model.dart';
import 'package:elred_todo_app/provider_models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/dateFormatting.dart';

class IndividualTaskScreen extends StatefulWidget {
  IndividualTaskScreen({Key? key, this.taskModel, required this.id})
      : super(key: key);

  TaskModel? taskModel;
  String? id;

  @override
  State<IndividualTaskScreen> createState() => _IndividualTaskScreenState();
}

class _IndividualTaskScreenState extends State<IndividualTaskScreen> {
  TextEditingController? title;
  TextEditingController? description;
  DateTime? datePicked;
  bool _validate = false;

  String getFormattedDate(DateTime? date) {
    if (date != null) {
      return DateFormatUtil().formatDate(date);
    } else {
      return '';
    }
  }

  @override
  void initState() {
    super.initState();
    description =
        TextEditingController(text: widget.taskModel?.description ?? '');
    title = TextEditingController(text: widget.taskModel?.title ?? '');
    datePicked = widget.taskModel?.date ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF1F0),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 25),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      margin: EdgeInsets.only(
                          right: 16.0, top: 10.0, bottom: 10.0, left: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  const Text(
                    'Add a new thing',
                    style: TextStyle(
                        color: Colors.red,
                        fontFamily: 'LibreBaskerville',
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  (widget.taskModel?.id == null)
                      ? Container(
                          width: 70,
                        )
                      : GestureDetector(
                          onTap: () async {
                            Provider.of<TodoModel>(context, listen: false)
                                .deleteTaskInList(
                                    widget.id, widget.taskModel, context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            margin: EdgeInsets.only(
                                right: 16.0,
                                top: 10.0,
                                bottom: 10.0,
                                left: 16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30.0,
                    ),
                    const Center(
                      child: CircleAvatar(
                        radius: 30,
                        foregroundColor: Colors.transparent,
                        child: Icon(
                          Icons.work,
                          color: Colors.red,
                          size: 25,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    TextField(
                      onChanged: (value) {
                        // Call setState to update the UI
                        setState(() {});
                      },
                      controller: title,
                      maxLines: null,
                      cursorColor: Colors.red,
                      decoration: InputDecoration(
                          suffixIcon: title!.text.isEmpty
                              ? null
                              : IconButton(
                                  onPressed: title!.clear,
                                  icon: const CircleAvatar(
                                    radius: 10,
                                    foregroundColor: Colors.transparent,
                                    child: Icon(
                                      Icons.clear,
                                      size: 15,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                          hintText: 'Add Title',
                          hintStyle: TextStyle(
                              color: Colors.redAccent.shade100, fontSize: 20),
                          border: InputBorder.none,
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          errorText:
                              _validate ? "Title can't be empty!" : null),
                      style: TextStyle(
                          fontSize: 30.0, color: Colors.redAccent.shade200),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    GestureDetector(
                      onTap: () async {
                        datePicked = await showDatePicker(
                                context: context,
                                initialDate: datePicked as DateTime,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2050)) ??
                            datePicked;
                        setState(() {});
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          getFormattedDate(datePicked),
                          style: TextStyle(
                              color: Colors.red.shade300,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      onChanged: (value) {
                        // Call setState to update the UI
                        setState(() {});
                      },
                      cursorColor: Colors.red,
                      controller: description,
                      decoration: InputDecoration(
                        suffixIcon: description!.text.isEmpty
                            ? null
                            : IconButton(
                                onPressed: description!.clear,
                                icon: const CircleAvatar(
                                  radius: 10,
                                  foregroundColor: Colors.transparent,
                                  child: Icon(
                                    Icons.clear,
                                    size: 15,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                        border: InputBorder.none,
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        hintStyle: TextStyle(
                            color: Colors.redAccent.shade100, fontSize: 20),
                        hintText: 'Add description',
                      ),
                      maxLines: null,
                      style: TextStyle(
                          color: Colors.redAccent.shade200,
                          fontSize: 20.0,
                          letterSpacing: 1.5,
                          height: 1.5),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 100),
                          color: Colors.red,
                          child: MaterialButton(
                            elevation: 5,
                            child: const Text(
                              'Add your thing',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'LibreBaskerville',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            onPressed: () async {
                              setState(() {
                                title!.text.isEmpty
                                    ? _validate = true
                                    : _validate = false;
                              });
                              if (!_validate) {
                                FocusScope.of(context).unfocus();
                                Provider.of<TodoModel>(context, listen: false)
                                    .addTaskInList(
                                        widget.id,
                                        widget.taskModel?.id,
                                        context,
                                        title?.text,
                                        description?.text,
                                        datePicked);
                              }
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
