import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../tabs/account/state.dart';

class SigninPage extends ConsumerStatefulWidget {
  const SigninPage({super.key});

  @override
  ConsumerState<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends ConsumerState<SigninPage> {
  final GlobalKey webViewKey = GlobalKey();
  late InAppWebViewController webViewController;

  double progress = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WebsafeSvg.asset('assets/logo.svg', height: 32.0),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                InAppWebView(
                  key: webViewKey,
                  initialUrlRequest: URLRequest(
                    url: WebUri('https://sso.imerzone.com/login-sso'),
                  ),
                  onWebViewCreated: (controller) {
                    webViewController = controller;
                  },
                  onReceivedHttpError: (controller, request, errorResponse) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Proses autentikasi gagal. Silahkan periksa kredensial yang Anda masukkan sudah benar.',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.onError),
                        ),
                        backgroundColor:
                            Theme.of(context).colorScheme.errorContainer,
                      ),
                    );
                    Navigator.of(context).pop();
                  },
                  onLoadStop: (controller, url) async {
                    await Future.delayed(const Duration(seconds: 1));
                    if (url.toString().contains('/api/auth/login')) {
                      const source = 'document.documentElement.innterHTML';
                      controller
                          .evaluateJavascript(source: source)
                          .then((content) {
                        ref.read(accountProvider.notifier).login(content);
                        Navigator.of(context).pop();
                      });
                    }
                  },
                  shouldOverrideUrlLoading:
                      (controller, navigationAction) async {
                    final uri = navigationAction.request.url;

                    if (uri != null) {
                      if (![
                        'sso.imerzone.com',
                        'imerzone.com',
                      ].contains(uri.host)) {
                        return NavigationActionPolicy.CANCEL;
                      }
                    }

                    return NavigationActionPolicy.ALLOW;
                  },
                  onProgressChanged: (controller, progress) {
                    setState(() {
                      this.progress = progress / 100;
                    });
                  },
                  initialSettings: InAppWebViewSettings(
                    javaScriptEnabled: true,
                    useShouldOverrideUrlLoading: true,
                    isInspectable: kDebugMode,
                  ),
                ),
                progress < 1.0
                    ? LinearProgressIndicator(value: progress)
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
