import 'package:ana_flutter/core/config/env_key.dart';
import 'package:ana_flutter/utils/env_utils.dart';
import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_text_styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Purple circle + brain icon
                  Container(
                    width: 64,
                    height: 64,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xFF6D5BFF), Color(0xFF9B59FF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Center(
                      child: Icon(Icons.memory, size: 32, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Login Required',
                    style: AppTextStyles.headlineMedium(
                      context,
                    ).withFontWeight(FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Sign in to access your AI notes and sync across devices',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  SupaSocialsAuth(
                    nativeGoogleAuthConfig: NativeGoogleAuthConfig(
                      webClientId: getEnvVariable(EnvironmentKey.webClientUrl),
                      iosClientId: getEnvVariable(EnvironmentKey.iosClientUrl),
                    ),
                    socialProviders: [
                      OAuthProvider.apple,
                      OAuthProvider.google,
                    ],
                    redirectUrl: getEnvVariable(
                      EnvironmentKey.supabaseRedirectUrl,
                    ),
                    colored: true,
                    onSuccess: (Session response) {},
                    onError: (error) {},
                  ),

                  const SizedBox(height: 24),
                  const Divider(thickness: 0.5, color: Colors.grey),
                  const SizedBox(height: 8),

                  // Terms text with tappable links
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      const Text(
                        'By continuing, you agree to our ',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      GestureDetector(
                        onTap: () => _launchUrl('https://your.app/terms'),
                        child: const Text(
                          'Terms of Service',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      const Text(
                        ' and ',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      GestureDetector(
                        onTap: () => _launchUrl('https://your.app/privacy'),
                        child: const Text(
                          'Privacy Policy',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
