import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../dashboard/presentation/pages/dashboard_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _rememberMe = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {}); // Update the button text and fields
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLogin = _tabController.index == 0;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFF),
      body: Stack(
        children: [
          // Background decorative elements
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF2ECC71).withOpacity(0.1),
                    const Color(0xFF2ECC71).withOpacity(0),
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  // Premium Logo Integration (Increased Size)
                  Container(
                    width: 80,
                    height: 80,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 24,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset(
                        'assets/images/lotted_care_logo_premium.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // App Name instead of Welcome Back
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFF2ECC71), Color(0xFF1B5E20)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ).createShader(bounds),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'LottedCare',
                        style: GoogleFonts.dancingScript(
                          fontSize: 44,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isLogin 
                      ? 'Your unified health management companion'
                      : 'Join us and start your health journey today',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color(0xFF5D6D7E).withOpacity(0.8),
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Refined Segmented Control / Tab Bar
                  Container(
                    height: 48,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F4F7),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent, // Cleaner look
                      indicator: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      labelColor: const Color(0xFF0D1B2A),
                      unselectedLabelColor: const Color(0xFF5D6D7E),
                      labelStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                      tabs: const [
                        Tab(text: 'Login'),
                        Tab(text: 'Register'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Form Fields (Dynamic based on Tab)
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Column(
                      key: ValueKey(_tabController.index),
                      children: [
                        if (!isLogin) ...[
                          _buildModernField(
                            label: 'Full Name',
                            hint: 'John Doe',
                            icon: Icons.person_outline_rounded,
                          ),
                          const SizedBox(height: 16),
                        ],
                        _buildModernField(
                          label: 'Email Address',
                          hint: 'name@example.com',
                          icon: Icons.alternate_email_rounded,
                        ),
                        const SizedBox(height: 16),
                        _buildModernField(
                          label: 'Password',
                          hint: 'Your password',
                          icon: Icons.lock_outline_rounded,
                          isPassword: true,
                          obscureText: _obscurePassword,
                          onSuffixTap: () => setState(() => _obscurePassword = !_obscurePassword),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),
                  // Remember Me & Forgot Password (Login Only)
                  if (isLogin)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => _rememberMe = !_rememberMe),
                          child: Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  color: _rememberMe ? const Color(0xFF2ECC71) : Colors.transparent,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: _rememberMe ? const Color(0xFF2ECC71) : const Color(0xFFD5DBDB),
                                    width: 2,
                                  ),
                                ),
                                child: _rememberMe
                                    ? const Icon(Icons.check, size: 12, color: Colors.white)
                                    : null,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Remember me',
                                style: TextStyle(color: Color(0xFF5D6D7E), fontSize: 13, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Color(0xFF2ECC71),
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  
                  const SizedBox(height: 24),

                  // Primary Button (Login / Register)
                  Container(
                    width: double.infinity,
                    height: 58,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(29),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF2ECC71), Color(0xFF27AE60)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2ECC71).withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const DashboardPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29)),
                      ),
                      child: Text(
                        isLogin ? 'Sign In' : 'Create Account',
                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Divider
                  Row(
                    children: [
                      Expanded(child: Divider(color: const Color(0xFFD5DBDB), thickness: 1)),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'OR',
                          style: TextStyle(color: Color(0xFFAEB6BF), fontSize: 11, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Expanded(child: Divider(color: const Color(0xFFD5DBDB), thickness: 1)),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Google Login Button
                  _buildGoogleButton(),
                  
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernField({
    required String label,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onSuffixTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0D1B2A),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextFormField(
            obscureText: obscureText,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0xFFAEB6BF), fontWeight: FontWeight.normal, fontSize: 14),
              prefixIcon: Icon(icon, color: const Color(0xFF2ECC71), size: 20),
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: const Color(0xFFAEB6BF),
                        size: 20,
                      ),
                      onPressed: onSuffixTap,
                    )
                  : null,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 18),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFFF2F3F4)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFF2ECC71), width: 1.5),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGoogleButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFF2F3F4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(28),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.g_mobiledata_rounded, color: Colors.blue, size: 32),
            const SizedBox(width: 8),
            const Text(
              'Continue with Google',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF0D1B2A),
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
