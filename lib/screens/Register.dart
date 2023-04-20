import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_go/constans.dart';
import 'package:lets_go/shared_prefs.dart';
import 'package:lets_go/Utils.dart';

class Register extends StatefulWidget {
  const Register({Key? key, required Function this.changeReg})
      : super(key: key);

  final Function changeReg;
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isCheked = true;
  bool isUsernameCorrect = true;
  bool isEmailCorrect = true;
  bool isPasswordCorrect = true;
  bool isPassword2Correct = true;

  var userName = TextEditingController();
  var eMail = TextEditingController();
  var passWord = TextEditingController();
  var passWord2 = TextEditingController();

  /*тут некоторые строки связаны с файербейс. Я их пока что закоментирую,
  потому что это не особо правильно и файербейс пока что не подключен к проекту*/

  //CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'EthA',
            style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 50,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: userName,
                  onChanged: (text) {
                    if (text.length < 2) {
                      setState(() {
                        isUsernameCorrect = false;
                      });
                    } else {
                      setState(() {
                        isUsernameCorrect = true;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    label: Text('Username'),
                    floatingLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        style: BorderStyle.none,
                        width: 0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Color(0xffff0000),
                        width: 1,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Color(0xffff0000),
                        width: 2,
                      ),
                    ),
                    errorText: isUsernameCorrect || userName.text.isEmpty
                        ? null
                        : "Type 2 or more symbols",
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                TextField(
                  controller: eMail,
                  onChanged: (text) {
                    if (!text.contains('@')) {
                      setState(() {
                        isEmailCorrect = false;
                      });
                    } else {
                      setState(() {
                        isEmailCorrect = true;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    label: const Text('Email'),
                    floatingLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        style: BorderStyle.none,
                        width: 0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Color(0xffff0000),
                        width: 1,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Color(0xffff0000),
                        width: 2,
                      ),
                    ),
                    errorText: isEmailCorrect || eMail.text.isEmpty
                        ? null
                        : "Type correct email",
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                TextField(
                  controller: passWord,
                  onChanged: (text) {
                    if (text.length < 8) {
                      setState(() {
                        isPasswordCorrect = false;
                      });
                    } else {
                      setState(() {
                        isPasswordCorrect = true;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    label: const Text('Password'),
                    floatingLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        style: BorderStyle.none,
                        width: 0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Color(0xffff0000),
                        width: 1,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Color(0xffff0000),
                        width: 2,
                      ),
                    ),
                    errorText: isPasswordCorrect || passWord.text.isEmpty
                        ? null
                        : "Type 8 or more symbol",
                  ),
                  obscuringCharacter: '*',
                  obscureText: isCheked,
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                TextField(
                  controller: passWord2,
                  onChanged: (text) {
                    if (text.length < 8) {
                      setState(() {
                        isPassword2Correct = false;
                      });
                    } else {
                      setState(() {
                        isPassword2Correct = true;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    label: const Text('Repeat password'),
                    floatingLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        style: BorderStyle.none,
                        width: 0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Color(0xffff0000),
                        width: 1,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Color(0xffff0000),
                        width: 2,
                      ),
                    ),
                    errorText: isPassword2Correct || passWord2.text.isEmpty
                        ? null
                        : "Type 8 or more symbols",
                  ),
                  obscuringCharacter: '*',
                  obscureText: isCheked,
                ),
                Row(children: [
                  Checkbox(
                    value: isCheked,
                    onChanged: (value) {
                      setState(() {
                        isCheked = !isCheked;
                      });
                    },
                  ),
                  const Text('Hide password'),
                ]),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        print(
                            '${userName.text} & ${passWord.text} / ${passWord2.text}');
                        ScaffoldMessenger.of(context).clearSnackBars();
                        if (userName.text.isNotEmpty &&
                            isUsernameCorrect &&
                            eMail.text.isNotEmpty &&
                            isEmailCorrect &&
                            passWord.text.isNotEmpty &&
                            isPasswordCorrect &&
                            (passWord.text == passWord2.text)) {
                          //Navigator.pushNamedAndRemoveUntil(
                          //  context, '/', (route) => false);
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => const Center(
                                    child: CircularProgressIndicator(),
                                  ));
                          try {
                            var userCrds = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: eMail.text.trim(),
                              password: passWord.text.trim(),
                            );
                            await userCrds.user!.updateDisplayName(userName.text.trim());
                            print("AAAAAAAA");
                             try{
                              Navigator.of(context, rootNavigator: true).pop();
                             }catch(e){
                              print(e);
                             }
                          } on FirebaseAuthException catch (e) {
                            print("ERROREEE");
                            Navigator.of(context, rootNavigator: true).pop();
                            Utils.showDialogCustom(
                                context: context,
                                title: 'Oops!',
                                content: e.message.toString());
                          }
                          //SharedPrefs().isSigned = true;
                          SharedPrefs().username = userName.text;
                          SharedPrefs().email = eMail.text;
                        } else if (userName.text.isEmpty ||
                            eMail.text.isEmpty ||
                            passWord.text.isEmpty ||
                            passWord2.text.isEmpty) {
                          Utils.showSnackBar(
                              context: context,
                              text: 'There are some empty fields!',
                              color: Color(0xffff0000));
                        } else if (passWord.text != passWord2.text) {
                          Utils.showSnackBar(
                              context: context,
                              text: "Passwords don\'t match!",
                              color: Color(0xffff0000));
                        } else {
                          Utils.showSnackBar(
                              context: context,
                              text: "Please, fulfill the requirements!",
                              color: Color(0xffff0000));
                        }
                      },
                      child: const Text('Register'),
                    )),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Already have an account? ',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Container(
                child: GestureDetector(
                  onTap: () {
                    print('login');
                    widget.changeReg();
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 17,
                        color: kSecondaryColor,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    eMail.dispose();
    passWord2.dispose();
    passWord.dispose();
    userName.dispose();
    super.dispose();
  }

  Future register() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: eMail.text.trim(),
      password: passWord.text.trim(),
    );
  }
}
