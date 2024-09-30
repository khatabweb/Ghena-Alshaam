import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;

  const AppNetworkImage({
    Key? key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadImage(imageUrl, context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return _buildErrorIcon();
          } else {
            return Container(
              width: width ?? double.maxFinite,
              height: height ?? double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: fit,
                ),
              ),
            );
          }
        } else {
          return Container(
            width: width,
            height: height,
            color: Colors.white,
            child: Center(
              child: _buildLoadingIndicator(context),
            ),
          );
        }
      },
    );
  }

  Widget _buildLoadingIndicator(context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return CupertinoActivityIndicator();
    } else {
      return CircularProgressIndicator();
    }
  }

  Widget _buildErrorIcon() {
    return Container(
      width: width,
      height: height,
      color: Colors.white,
      child: Center(
        child: Icon(
          Icons.info,
          color: Colors.red,
          size: 40,
        ),
      ),
    );
  }

  Future<void> _loadImage(String url, BuildContext context) async {
    try {
      await precacheImage(NetworkImage(url), context);
    } catch (e) {
      throw e;
    }
  }
}

// import 'package:flutter/material.dart';

// class AppNetworkImage extends StatelessWidget {
//   final String imageUrl;
//   final BoxFit fit;
//   final double? width;
//   final double? height;

//   const AppNetworkImage({
//     Key? key,
//     required this.imageUrl,
//     this.fit = BoxFit.cover,
//     this.width,
//     this.height,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _loadImage(imageUrl, context),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           if (snapshot.hasError) {
//             return Container(
//               width: width ?? double.maxFinite,
//               height: height ?? double.maxFinite,
//               color: Colors.white,
//               child: Center(
//                 child: Icon(Icons.info, color: Colors.red, size: 50),
//               ),
//             );
//           } else {
//             return Container(
//               width: width ?? double.maxFinite,
//               height: height ?? double.maxFinite,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 image: DecorationImage(
//                   image: NetworkImage(imageUrl),
//                   fit: fit,
//                 ),
//               ),
//             );
//           }
//         } else {
//           return Container(
//             width: width,
//             height: height,
//             color: Colors.white,
//             child: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         }
//       },
//     );
//   }

//   Future<void> _loadImage(String url, BuildContext context) async {
//     try {
//       await precacheImage(NetworkImage(url), context);
//     } catch (e) {
//       // Handle error, will be reflected in FutureBuilder snapshot
//       throw e;
//     }
//   }
// }
