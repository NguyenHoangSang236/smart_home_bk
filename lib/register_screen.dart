import 'package:flutter/material.dart';
import 'package:smart_home/account_model.dart';
import 'package:smart_home/utils.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _cfmPasswordController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();

  bool _isPasswordObscure = false;
  bool _isCfmPasswordObscure = false;

  void comeBack() {
    Navigator.pop(context);
  }

  void setObscureForPassword() {
    setState(() {
      _isPasswordObscure = !_isPasswordObscure;
    });
  }

  void setObscureForCfmPassword() {
    setState(() {
      _isCfmPasswordObscure = !_isCfmPasswordObscure;
    });
  }

  void register() {
    // Utils.removeLocalStorageData("accounts");
    if (_userNameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _cfmPasswordController.text.isEmpty ||
        _fullNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bạn cần nhập đầy đủ thông tin'),
          duration: Duration(seconds: 2),
        ),
      );
    } else if (_cfmPasswordController.text != _passwordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Mật khẩu xác nhận không khớp với mật khẩu bạn muốn tạo'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      Utils.saveNewAccount(
        AccountModel(
          userName: _userNameController.text,
          password: _passwordController.text,
          name: _fullNameController.text,
        ),
      ).then((isSuccess) {
        if (!isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Tài khoản đã tồn tại'),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Chào mừng bạn!'),
              duration: Duration(seconds: 2),
            ),
          );
          comeBack();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: comeBack,
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Hãy đăng ký tài khoản để sử dụng ứng dụng',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 27,
              ),
            ),
            const SizedBox(height: 50),
            TextField(
              controller: _fullNameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.perm_identity),
                filled: true,
                fillColor: Colors.white,
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
                hintStyle: TextStyle(color: Colors.black),
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _userNameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.account_box_outlined),
                filled: true,
                fillColor: Colors.white,
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
                hintStyle: TextStyle(color: Colors.black),
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: _isPasswordObscure,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                filled: true,
                fillColor: Colors.white,
                suffix: SizedBox(
                  height: 25,
                  width: 25,
                  child: IconButton(
                    onPressed: setObscureForPassword,
                    style: IconButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    icon: Icon(
                      _isPasswordObscure
                          ? Icons.remove_red_eye_outlined
                          : Icons.remove_red_eye_rounded,
                      color: Colors.black,
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
                hintStyle: const TextStyle(color: Colors.black),
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _cfmPasswordController,
              obscureText: _isCfmPasswordObscure,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_open),
                filled: true,
                fillColor: Colors.white,
                suffix: SizedBox(
                  height: 25,
                  width: 25,
                  child: IconButton(
                    onPressed: setObscureForCfmPassword,
                    style: IconButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    icon: Icon(
                      _isCfmPasswordObscure
                          ? Icons.remove_red_eye_outlined
                          : Icons.remove_red_eye_rounded,
                      color: Colors.black,
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
                hintText: 'Xác nhận mật khẩu',
                hintStyle: const TextStyle(color: Colors.black),
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 45),
            ElevatedButton(
              onPressed: register,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width / 5,
                  vertical: 10,
                ),
                backgroundColor: const Color(0xFF0098FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Đăng kí tài khoản',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
