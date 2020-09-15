
import 'dart:io';

import 'package:chat_app/widgets/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends  StatefulWidget {
  AuthForm(this.submitFn,this._isLoading);
  var _isLoading;
  final void Function(String email,String password,String username,File image,bool isLogin,BuildContext ctx) submitFn;
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey=GlobalKey<FormState>();
  var _isLogin=true;
  String _userEmail='';
  String _userName='';
  String _userPassword='';
  File _userImageFile;

  void _pickedImage(File image){
    _userImageFile=image;
  }

  void _trySubmit(){
    final _isValid=_formkey.currentState.validate();
    FocusScope.of(context).unfocus(); //close the keyboard
    if(_userImageFile==null && !_isLogin){
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Please Pick an image.'),
          backgroundColor: Theme.of(context).errorColor,
        )
      );
      return;
    }
    if(_isValid){
      _formkey.currentState.save();
      widget.submitFn(_userEmail.trim(),_userPassword.trim(),_userName.trim(),_userImageFile,_isLogin,context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(!_isLogin)
                  UserImagePicker(_pickedImage),
                  TextFormField(
                    key: ValueKey('email'),
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: false,
                    validator:(value){
                      if(value.isEmpty || !value.contains('@')){
                        return 'please Enter a valid email address.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email address',
                    ),
                    onSaved: (value){
                      _userEmail=value;
                    },
                  ),
                  if(!_isLogin)
                   TextFormField(
                     key: ValueKey('username'),
                    autocorrect: true,
                    textCapitalization: TextCapitalization.words,
                    enableSuggestions: false,
                    validator:(value){
                      if(value.isEmpty || value.length<4){
                        return 'Please enter at least 4 characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Username'
                    ),
                    onSaved: (value){
                      _userName=value;
                    },
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator:(value){
                      if(value.isEmpty || value.length<7){
                        return 'Password must be atleast 7 characters long';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    onSaved: (value){
                      _userPassword=value;
                    },
                  ),
                  SizedBox(height: 12,),
                  if(widget._isLoading) CircularProgressIndicator(),
                  if(!widget._isLoading)
                  RaisedButton(
                    child: Text(_isLogin?'Login':'Signup'),
                    onPressed: _trySubmit,
                  ),
                  if(!widget._isLoading)
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(_isLogin?'Create new account':'I already have an account'),
                    onPressed: (){
                      setState(() {
                        _isLogin=!_isLogin;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );;
  }
}
