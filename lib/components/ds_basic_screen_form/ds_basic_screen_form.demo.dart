import 'package:flutter/material.dart';

import '../../design_system_project.dart';

class DSBasicScreenFormDemo extends StatefulWidget {
  const DSBasicScreenFormDemo({super.key});

  @override
  State<DSBasicScreenFormDemo> createState() => _DSBasicScreenFormDemoState();
}

class _DSBasicScreenFormDemoState extends State<DSBasicScreenFormDemo> {
  final DSInputController _nameController = DSInputController();
  final DSInputController _emailController = DSInputController();
  final DSInputController _phoneController = DSInputController();

  @override
  Widget build(BuildContext context) {
    return DSBasicScreenForm(
      title: 'Basic Screen Form Demo',
      description: 'This is a demo of the DSBasicScreenForm component',
      showBackButton: true,
      hasBottomBorderRadius: true,
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.white),
          onPressed: () {
            // Handle menu action
          },
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            Text(
              'Form Example',
              style: textTheme.lg?.bold,
            ),
            const SizedBox(height: 24),
            DSInput(
              controller: _nameController,
              title: 'Full Name',
              required: true,
              hint: 'Enter your full name',
              prefixIcon: DSImageView(
                source: DSAssets.vuesax.userLinear,
                width: DSIconSizes.size24,
              ),
            ),
            const SizedBox(height: 16),
            DSInput(
              controller: _emailController,
              title: 'Email Address',
              required: true,
              hint: 'Enter your email address',
              keyboardType: TextInputType.emailAddress,
              prefixIcon: DSImageView(
                source: DSAssets.vuesax.smsLinear,
                width: DSIconSizes.size24,
              ),
            ),
            const SizedBox(height: 16),
            DSInput(
              controller: _phoneController,
              title: 'Phone Number',
              hint: 'Enter your phone number',
              keyboardType: TextInputType.phone,
              prefixIcon: DSImageView(
                source: DSAssets.vuesax.callLinear,
                width: DSIconSizes.size24,
              ),
            ),
            const SizedBox(height: 32),
            DSButton(
              variant: DSButtonVariants.primary,
              size: DSButtonSize.lg,
              label: 'Submit Form',
              onPressed: () {
                // Handle form submission
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Form submitted successfully!'),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            DSButton(
              variant: DSButtonVariants.outline,
              size: DSButtonSize.lg,
              label: 'Clear Form',
              onPressed: () {
                _nameController.clear();
                _emailController.clear();
                _phoneController.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Example with header image
class DSBasicScreenFormWithHeaderDemo extends StatefulWidget {
  const DSBasicScreenFormWithHeaderDemo({super.key});

  @override
  State<DSBasicScreenFormWithHeaderDemo> createState() =>
      _DSBasicScreenFormWithHeaderDemoState();
}

class _DSBasicScreenFormWithHeaderDemoState
    extends State<DSBasicScreenFormWithHeaderDemo> {
  @override
  Widget build(BuildContext context) {
    return DSBasicScreenForm(
      title: 'Profile Settings',
      description: 'Manage your account preferences',
      showHeaderImage: true,
      showBackButton: true,
      hasBottomBorderRadius: true,
      centerTitle: true,
      appbarColor: DSColorUsages.background.brandPrimary,
      actions: [
        IconButton(
          icon: const Icon(Icons.save, color: Colors.white),
          onPressed: () {
            // Handle save action
          },
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            Text(
              'Account Information',
              style: textTheme.lg?.bold,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: DSColorUsages.background.secondary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profile Settings',
                    style: textTheme.base?.bold,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '''Configure your account preferences and personal information.''',
                    style: textTheme.sm?.regular.copyWith(
                      color: DSColorUsages.text.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Example with custom styling
class DSBasicScreenFormCustomDemo extends StatefulWidget {
  const DSBasicScreenFormCustomDemo({super.key});

  @override
  State<DSBasicScreenFormCustomDemo> createState() =>
      _DSBasicScreenFormCustomDemoState();
}

class _DSBasicScreenFormCustomDemoState
    extends State<DSBasicScreenFormCustomDemo> {
  @override
  Widget build(BuildContext context) {
    return DSBasicScreenForm(
      title: 'Custom Styled Form',
      description: 'With custom colors and styling',
      showBackButton: true,
      hasBottomBorderRadius: false,
      centerTitle: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            Text(
              'Custom Content',
              style: textTheme.lg?.bold,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: DSColorUsages.background.primary,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: DSColorUsages.icon.brand,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Information',
                        style: textTheme.base?.bold,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '''This is an example of a custom styled form with different colors and layout.''',
                    style: textTheme.sm?.regular.copyWith(
                      color: DSColorUsages.text.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
