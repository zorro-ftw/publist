import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:publist/models/task_data.dart';
import 'package:publist/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:publist/firebase_services/auth_service.dart';




class AddTaskScreen extends StatelessWidget {

  AddTaskScreen({@required this.role});
  final Role role;
  final _auth=AuthService();

  @override
  Widget build(BuildContext context) {
    String inputText,header,buttonText,validate;
    if (role==Role.addTask){
      header='Add Task';
      buttonText='Add';
    }
    else if (role==Role.email){
      header='Enter your new e-mail';
      buttonText='Change';
    }
    else if (role==Role.password){
      header='Enter your new password';
      buttonText='Change';
    }
    else if (role==Role.rename){
      header='Enter your new name';
      buttonText='Change';
    }


    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              header,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.black,
              ),
            ),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (newText) {
                inputText = newText;
              },
            ),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.orange),
              child:Text(
                buttonText,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                if (inputText != null) {
                  if(role==Role.addTask){
                  Provider.of<TaskData>(context, listen: false)
                      .addTask(inputText);
                  Navigator.pop(context);
                  }
                  else if(role==Role.password){
                    validate =
                        PasswordValidator.validate(inputText, inputText);
                    if (validate != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(validate),
                        ),
                      );
                    }
                    else{
                  String result= await _auth.changePassword(inputText);
                  ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(result),
                  ),);
                  Navigator.pop(context);
                  }}
                  else if(role==Role.email){
                    validate =
                        EmailValidator.validate(inputText);
                    if (validate != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(validate),
                        ),
                      );
                    }
                    else{
                      String result=await _auth.changeEmail(inputText);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(result),
                      ),
                    );
                    Navigator.pop(context);
                  }}
                  else if(role==Role.rename){
                    validate=NameValidator.validate(inputText);
                    if(validate!=null){
                      ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(validate),
                      ),);}
                    else{
                      String result=await _auth.changeName(inputText);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(result),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
