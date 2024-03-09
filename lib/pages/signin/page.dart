import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:websafe_svg/websafe_svg.dart';

// import '../state.dart';
import '../tabs/account/state.dart';

class SigninPage extends ConsumerStatefulWidget {
  const SigninPage({super.key});

  @override
  ConsumerState<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends ConsumerState<SigninPage> {
  late TextEditingController emailController;
  late FocusNode emailFocusNode;
  late TextEditingController passwordController;
  late FocusNode passwordFocusNode;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    emailFocusNode = FocusNode();
    passwordController = TextEditingController();
    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    emailFocusNode.dispose();
    passwordController.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              WebsafeSvg.asset('assets/logo.svg', height: 56.0),
              const SizedBox(height: 40.0),
              TextField(
                controller: emailController,
                focusNode: emailFocusNode,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Masukkan email Anda',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onSubmitted: (value) {
                  emailFocusNode.unfocus();
                  FocusScope.of(context).requestFocus(passwordFocusNode);
                },
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: passwordController,
                focusNode: passwordFocusNode,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Masukkan password Anda',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                textInputAction: TextInputAction.done,
                onSubmitted: (value) {
                  passwordFocusNode.unfocus();
                },
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            ref.read(accountProvider.notifier).login(
                                  context,
                                  email: emailController.text,
                                  password: passwordController.text,
                                );

                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ).then((_) {
                          // ref.read(pagesProvider.notifier).changePage(0);
                          Navigator.of(context).pop();
                        });
                      },
                      child: const Text('Login'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

  // final GlobalKey webViewKey = GlobalKey();
  // late InAppWebViewController webViewController;

  // double progress = 0;
      // body: Column(
      //   children: [
      //     Expanded(
      //       child: Stack(
      //         children: [
      //           InAppWebView(
      //             key: webViewKey,
      //             initialUrlRequest: URLRequest(
      //               url: WebUri('https://sso.imerzone.com/login-sso'),
      //             ),
      //             onWebViewCreated: (controller) {
      //               webViewController = controller;
      //             },
      //             onReceivedHttpError: (controller, request, errorResponse) {
      //               ScaffoldMessenger.of(context).showSnackBar(
      //                 SnackBar(
      //                   content: Text(
      //                     'Proses autentikasi gagal. Silahkan periksa kredensial yang Anda masukkan sudah benar.',
      //                     style: Theme.of(context)
      //                         .textTheme
      //                         .bodySmall
      //                         ?.copyWith(
      //                             color: Theme.of(context).colorScheme.onError),
      //                   ),
      //                   backgroundColor:
      //                       Theme.of(context).colorScheme.errorContainer,
      //                 ),
      //               );
      //               Navigator.of(context).pop();
      //             },
      //             onLoadStop: (controller, url) async {
      //               await Future.delayed(const Duration(seconds: 1));
      //               if (url.toString().contains('/api/auth/login')) {
      //                 const source = 'document.documentElement.innterHTML';
      //                 controller
      //                     .evaluateJavascript(source: source)
      //                     .then((content) {
      //                   ref.read(accountProvider.notifier).login(content);
      //                   Navigator.of(context).pop();
      //                 });
      //               }
      //             },
      //             shouldOverrideUrlLoading:
      //                 (controller, navigationAction) async {
      //               final uri = navigationAction.request.url;

      //               if (uri != null) {
      //                 if (![
      //                   'sso.imerzone.com',
      //                   'imerzone.com',
      //                 ].contains(uri.host)) {
      //                   return NavigationActionPolicy.CANCEL;
      //                 }
      //               }

      //               return NavigationActionPolicy.ALLOW;
      //             },
      //             onProgressChanged: (controller, progress) {
      //               setState(() {
      //                 this.progress = progress / 100;
      //               });
      //             },
      //             initialSettings: InAppWebViewSettings(
      //               javaScriptEnabled: true,
      //               useShouldOverrideUrlLoading: true,
      //               isInspectable: kDebugMode,
      //             ),
      //           ),
      //           progress < 1.0
      //               ? LinearProgressIndicator(value: progress)
      //               : Container(),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),