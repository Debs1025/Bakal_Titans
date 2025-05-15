import 'package:flutter/material.dart';
import '../homescreen.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(
            'assets/Profile/backarrow.png',
            width: 24,
            height: 24,
            color: const Color(0xFFF97000),
          ),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          ),
        ),
        title: const Text(
          'Terms & Conditions',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTermsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildTermsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Text(
        '''By downloading, accessing, or using Bakal Titans app, you agree to be bound by these Terms and Conditions. If you do not agree with these Terms, please do not use the App. These Terms govern your use of the App and any services provided through it.

1. Acceptance of Terms

By using the App, you confirm that you are at least 18 years old or have the consent of a parent or legal guardian. You agree to comply with these Terms and any applicable laws and regulations.

2. Use of the App

The App is designed to help you manage your gym membership, book classes, track workouts, and access gym-related services. You agree to:

Provide accurate and complete information when creating an account.

Keep your login credentials confidential and not share them with others.

Use the App only for lawful purposes and in accordance with these Terms.

Not attempt to hack, reverse-engineer, or interfere with the App’s functionality.


3. Membership and Payments

Membership: The App may allow you to purchase or manage gym memberships. Membership terms, including duration, fees, and cancellation policies, will be provided at the time of purchase.

Payments: All payments made through the App are processed by third-party payment providers. You agree to provide accurate payment information and authorize charges for services or memberships.

Refunds: Refunds, if applicable, will be processed in accordance with the gym’s refund policy, which will be communicated at the time of purchase.

Automatic Renewal: Some memberships may automatically renew unless canceled before the renewal date. You will be notified of renewal terms prior to any charges.


4. User Conduct

You agree not to:

Use the App to harass, abuse, or harm others.

Post or share content that is offensive, defamatory, or violates the rights of others.

Use the App to distribute spam or unsolicited communications.

Engage in any activity that disrupts or impairs the App’s performance.


5. Health and Safety

Physical Activity: The App may provide workout plans or fitness tracking features. You acknowledge that physical exercise carries inherent risks, and you are responsible for ensuring that you are medically fit to participate in any activities.

Consult a Professional: Always consult a healthcare professional before starting any fitness program. The App’s content is not a substitute for professional medical advice.

Assumption of Risk: You assume all risks associated with using the App’s fitness features, including injury or health complications.


6. Intellectual Property

All content, trademarks, and materials within the App, including but not limited to text, graphics, logos, and software, are the property of [Company Name] or its licensors. You may not copy, modify, distribute, or reproduce any content without prior written permission.


7. Third-Party Services

The App may integrate with third-party services (e.g., payment processors, fitness trackers). These services are subject to their own terms and conditions, and [Company Name] is not responsible for their performance or content.


8. Limitation of Liability

To the fullest extent permitted by law:

The App is provided "as is" without warranties of any kind, express or implied.

Gerard Fitness Incorporation is not liable for any direct, indirect, incidental, or consequential damages arising from your use of the App, including but not limited to loss of data, injury, or financial loss.

Gerard Fitness Incorporation does not guarantee the accuracy, reliability, or availability of the App or its content.


9. Termination

We reserve the right to suspend or terminate your access to the App at our discretion, with or without notice, for any reason, including violation of these Terms. Upon termination, your right to use the App will cease immediately.


10. Privacy

Your use of the App is subject to our Privacy Policy, which explains how we collect, use, and protect your personal information. By using the App, you consent to the practices described in the Privacy Policy.


11. Modifications to Terms

We may update these Terms from time to time. You will be notified of significant changes through the App or via email. Your continued use of the App after such changes constitutes acceptance of the updated Terms.


12. Contact Us

If you have any questions or concerns about these Terms, please contact us at:

Email: bakaltitans@gmail.com

Address: Naga City, Camarines Sur, Philippines

By using the App, you acknowledge that you have read, understood, and agree to be bound by these Terms and Conditions.

Note: This is a general template. Please consult a legal professional to customize these Terms to your specific business needs and ensure compliance with applicable laws.''',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          height: 1.5,
        ),
      ),
    );
  }
}