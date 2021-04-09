part of 'pages.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Colors.blue,
      body: Stack(
        children: [
          Container(color: Colors.blue,),
          SafeArea(
            child: Container(
              color: Color(0xFFF6F7F9),
              )
          ),
          SafeArea(
            child: ListView(
              children: [
                Container(
                  height: 90,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)
                    ),
                    color: Colors.blue
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (context.read<UserCubit>().state as UserLoaded).user.name,
                          style: title
                        ),
                        SizedBox(height: 5),
                        Text(
                          (context.read<UserCubit>().state as UserLoaded).user.address,
                          style: subTitle
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 500),
                ElevatedButton(
                  onPressed: ()async{
                    await context.read<UserCubit>().signOut();
                      Get.off(()=> SignInPage());
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Center(child: Text("Sign Out"))
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
                SizedBox(height: 500),

              ],
            ),
          ),
        ],
      ),
    );
  }
}