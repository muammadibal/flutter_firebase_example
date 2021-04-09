part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

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
                "Login",
                style: title.copyWith(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black87)
              ),
              SizedBox(height: 70),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  labelText: "Email"
                ),
              ),
              SizedBox(height: 20),
              TextField(
                obscureText: obsecurePassword,
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  labelText: "Password",

                  suffixIcon: IconButton(
                    icon: Icon(
                      obsecurePassword ? Icons.close_rounded : Icons.remove_red_eye
                    ),
                    onPressed: (){
                      setState((){
                        obsecurePassword = !obsecurePassword;
                      });
                    },
                  ),
                ),                
              ),

              SizedBox(height: 30),

              (isLoading) ? SpinKitFadingCircle(
                color: Colors.blue
              ) : ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });

                  await context.read<UserCubit>().signIn(emailController.text, passwordController.text);

                  UserState state = context.read<UserCubit>().state;

                  if(state is UserLoaded) {
                    setState(() {
                      isLoading = false;
                    });

                    Get.off(()=> HomePage());

                  } else {
                    Get.snackbar("", "",
                      backgroundColor: Colors.red[300],
                      icon: Icon(Icons.close, color: Colors.white),
                      titleText: Text(
                        "Sign In Failed",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                        )
                      ),
                      messageText: Text(
                        (state as UserLoadingFailed).message,
                        style: GoogleFonts.poppins(color: Colors.white)
                      )
                    );
                  }

                  setState(() {
                    isLoading = false;
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Center(child: Text("Sign In"))
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  elevation: MaterialStateProperty.all(0)
                )
              ),

              SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Belum punya akun? ",
                    style: subTitle.copyWith(color: Colors.black87)
                  ),
                  InkWell(
                    onTap: () {
                      Get.off(() => SignUpPage());
                    },
                    child: Text(
                      "Daftar",
                      style: subTitle.copyWith(color: Colors.blue),
                    )
                  )
                ],
              )

                ]
              ),
            ),
            

          ],
        )
      ),
    );
  }
}