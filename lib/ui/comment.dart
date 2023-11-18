import 'package:flutter/material.dart';

void main() {
  runApp(const CommentPost());
}

class CommentPost extends StatelessWidget {
  const CommentPost({Key? key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color.fromARGB(255, 41, 41, 41),
      ),
      home: Scaffold(
        body: ListView(
          children: [
            Comment(pengirim: "orang lain"),
            Comment(pengirim: "sendiri"),
            Comment(pengirim: "upin")
          ],
        ),
      ),
    );
  }
}

class Comment extends StatelessWidget {
  final String pengirim;
  const Comment({Key? key, required this.pengirim}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (pengirim == "orang lain") {
      return buildCommentOrangLain();
    } else if (pengirim == "sendiri") {
      return buildCommentSendiri();
    } else {
      return buildCommentUpin();
    }
  }

  Widget buildCommentOrangLain() {
    return Column(
      children: [
        Container(
          width: 417,
          height: 250,
          child: Stack(
            children: [
              Positioned(
                left: 34,
                top: 17,
                child: Container(
                  width: 24,
                  height: 24,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 7),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [],
                  ),
                ),
              ),
              Positioned(
                child: Container(
                  width: 400,
                  height: 720,
                  decoration: BoxDecoration(
                    color: Color(0xFF292929),
                  ),
                ),
              ),
              Positioned(
                left: 24,
                top: 38,
                child: Container(
                  width: 342,
                  height: 201,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 342,
                          height: 201,
                          decoration: ShapeDecoration(
                            color: Color(0xFFD9D9D9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 342,
                          height: 201,
                          decoration: ShapeDecoration(
                            color: Color(0xFFF5F5F5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        top: 14,
                        child: SizedBox(
                          width: 285,
                          height: 20,
                          child: Text(
                            '@Yunus',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 39,
                        top: 48,
                        child: SizedBox(
                          width: 287,
                          height: 139,
                          child: Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec venenatis, neque a malesuada tincidunt, elit orci semper ipsum, vitae auctor libero massa sit amet lorem. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Donec quis massa lacus. ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 0,
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
      ],
    );
  }

  Widget buildCommentSendiri() {
    return Column(
      children: [
        Container(
          width: 417,
          height: 214,
          child: Stack(
            children: [
              Positioned(
                left: 34,
                top: 17,
                child: Container(
                  width: 24,
                  height: 24,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 7),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [],
                  ),
                ),
              ),
              Positioned(
                child: Container(
                  width: 400,
                  height: 720,
                  decoration: BoxDecoration(
                    color: Color(0xFF292929),
                  ),
                ),
              ),
              Positioned(
                left: 24,
                top: 0,
                child: Container(
                  width: 342,
                  height: 201,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 342,
                          height: 201,
                          decoration: ShapeDecoration(
                            color: Color(0xFF8C92B6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 262,
                        top: 15,
                        child: SizedBox(
                          width: 47,
                          height: 20,
                          child: Text(
                            'You',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 39,
                        top: 48,
                        child: SizedBox(
                          width: 287,
                          height: 139,
                          child: Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec venenatis, neque a malesuada tincidunt, elit orci semper ipsum, vitae auctor libero massa sit amet lorem. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Donec quis massa lacus. ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 0,
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
      ],
    );
  }

  Widget buildCommentUpin() {
    return Column(
      children: [
        Container(
          width: 417,
          height: 300,
          child: Stack(
            children: [
              Positioned(
                left: 24,
                top: 0,
                child: Container(
                  width: 342,
                  height: 201,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 342,
                          height: 201,
                          decoration: ShapeDecoration(
                            color: Color(0xFFF5F5F5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        top: 14,
                        child: SizedBox(
                          width: 285,
                          height: 20,
                          child: Text(
                            '@Yunus',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 39,
                        top: 48,
                        child: SizedBox(
                          width: 287,
                          height: 139,
                          child: Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec venenatis, neque a malesuada tincidunt, elit orci semper ipsum, vitae auctor libero massa sit amet lorem. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Donec quis massa lacus. ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 0,
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
      ],
    );
  }
}
