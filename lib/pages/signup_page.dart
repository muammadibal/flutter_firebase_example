part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool isLoading = false;
  bool obsecurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                SizedBox(height: 70),
                Text(
                  "Create\nNew Account",
                  style: title.copyWith(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 70),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Email"),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Full Name"),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Address"),
                ),
                SizedBox(height: 20),
                TextField(
                  obscureText: obsecurePassword,
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: "Password",
                    suffixIcon: IconButton(
                      icon: Icon(obsecurePassword
                          ? Icons.close_rounded
                          : Icons.remove_red_eye),
                      onPressed: () {
                        setState(() {
                          obsecurePassword = !obsecurePassword;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 30),
                (isLoading)
                    ? SpinKitFadingCircle(
                        color: Colors.blue,
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });

                          await context.read<UserCubit>().signUp(
                              emailController.text,
                              passwordController.text,
                              nameController.text,
                              addressController.text);

                          UserState state = context.read<UserCubit>().state;

                          if (state is UserLoaded) {
                            setState(() {
                              isLoading = false;
                            });

                            Get.off(() => HomePage());
                          } else {
                            Get.snackbar("", "",
                                backgroundColor: Colors.red[300],
                                icon: Icon(Icons.close, color: Colors.white),
                                titleText: Text("Sign In Failed",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)),
                                messageText: Text(
                                    (state as UserLoadingFailed).message,
                                    style: GoogleFonts.poppins(
                                        color: Colors.white)));
                          }

                          setState(() {
                            isLoading = false;
                          });
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: Center(child: Text("Sign Up"))),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            elevation: MaterialStateProperty.all(0))),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sudah punya akun? ",
                      style: subTitle.copyWith(color: Colors.black87),
                    ),
                    InkWell(
                        onTap: () {
                          Get.off(() => SignInPage());
                        },
                        child: Text(
                          "Masuk",
                          style: subTitle.copyWith(color: Colors.blue),
                        ))
                  ],
                ),
                SizedBox(height: 50)
              ],
            ),
          ),
        ],
      )),
    );
  }
}
