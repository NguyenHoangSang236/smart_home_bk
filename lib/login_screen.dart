import 'package:flutter/material.dart';
import 'package:smart_home/register_screen.dart';
import 'package:smart_home/room_screen.dart';
import 'package:smart_home/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _userController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isObscure = true;
  bool _rememberMe = false;
  String _savedName = '';

  void rememberMe(bool? value) {
    setState(() {
      _rememberMe = value ?? false;
    });
  }

  void login() async {
    if (_userController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Hãy điền đẩy đủ Tên đăng nhập và Mật khẩu'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      List<Map<String, dynamic>> accounts = await Utils.getAllAccounts();
      bool isQualified = false;

      for (Map<String, dynamic> acc in accounts) {
        if (acc['userName'] == _userController.text &&
            acc['password'] == _passwordController.text) {
          isQualified = true;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Chào mừng bạn quay trở lại!'),
              duration: Duration(seconds: 2),
            ),
          );

          if (_rememberMe) {
            Utils.setLocalStorageData("savedUserName", acc['userName']);
            Utils.setLocalStorageData("savedPassword", acc['password']);
            Utils.setLocalStorageData("savedName", acc['name']);
            Utils.setLocalStorageData("rememberMe", 'true');
          } else {
            Utils.removeLocalStorageData("savedUserName");
            Utils.removeLocalStorageData("savedPassword");
            Utils.removeLocalStorageData("savedName");
            Utils.setLocalStorageData("rememberMe", 'false');
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RoomScreen(name: acc['name']),
            ),
          );
          break;
        }
      }

      if (!isQualified) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Tài khoản sai tên đăng nhâp hoặc mật khâủ, xin hãy kiểm tra lại',
            ),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void redirectToRegisterPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterPage()),
    );
  }

  void setObscureForPassword() {
    {
      setState(() {
        _isObscure = !_isObscure;
      });
    }
  }

  @override
  void initState() {
    Utils.getLocalStorageData('savedUserName').then(
      (value) => _userController.text = value.toString(),
    );
    Utils.getLocalStorageData('savedPassword').then(
      (value) => _passwordController.text = value.toString(),
    );
    Utils.getLocalStorageData('savedName').then(
      (value) => _savedName = value.toString(),
    );
    Utils.getLocalStorageData('rememberMe').then((value) {
      _rememberMe = value == 'true';

      if (_rememberMe!) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoomScreen(
              name: _savedName,
            ),
          ),
        );
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/smart_home_1.jpeg',
              width: MediaQuery.sizeOf(context).width,
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 35),
                  const Text(
                    'Chào mừng bạn !',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(height: 35),
                  TextField(
                    controller: _userController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      hintText: 'Tên đăng nhập',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      suffix: SizedBox(
                        height: 25,
                        width: 25,
                        child: IconButton(
                          onPressed: setObscureForPassword,
                          style: IconButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          icon: Icon(
                            _isObscure
                                ? Icons.remove_red_eye_outlined
                                : Icons.remove_red_eye_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      hintText: 'Mật khẩu',
                      hintStyle: const TextStyle(color: Colors.white),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                          value: _rememberMe ?? false, onChanged: rememberMe),
                      const Text(
                        "Ghi nhớ đăng nhập",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.sizeOf(context).width / 5,
                        vertical: 10,
                      ),
                      backgroundColor: const Color(0xFF0098FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Text(
                      'Đăng nhập',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'hoặc',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: redirectToRegisterPage,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.sizeOf(context).width / 6,
                        vertical: 7,
                      ),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Text(
                      'Đăng ký',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
