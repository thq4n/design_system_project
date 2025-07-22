import 'package:flutter/material.dart';

import '../../base/ds_base.dart';
import '../../components/ds_basic_screen_form/ds_basic_screen_form.dart';
import '../../design_system_core/ds_color_usage/ds_color_usage_core.dart';
import '../../extensions/extensions.dart';
import 'ds_radio.dart';

class DSRadioDemo extends StatefulWidget {
  const DSRadioDemo({super.key});

  @override
  State<DSRadioDemo> createState() => _DSRadioDemoState();
}

class _DSRadioDemoState extends DSStateBase<DSRadioDemo> {
  int _selectedValue = 1;
  int _selectedSize = 1;
  int _selectedVariant = 0;
  bool _isDisabled = false;

  @override
  Widget build(BuildContext context) {
    return DSBasicScreenForm(
      title: 'DSRadio Demo',
      showBackButton: true,
      centerTitle: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              'Basic Radio Buttons',
              Column(
                children: [
                  DSRadio<int>(
                    value: 1,
                    groupValue: _selectedValue,
                    onChanged: _isDisabled
                        ? null
                        : (value) {
                            setState(() {
                              _selectedValue = value ?? 1;
                            });
                          },
                    label: 'Option 1',
                  ),
                  const SizedBox(height: 12),
                  DSRadio<int>(
                    value: 2,
                    groupValue: _selectedValue,
                    onChanged: _isDisabled
                        ? null
                        : (value) {
                            setState(() {
                              _selectedValue = value ?? 1;
                            });
                          },
                    label: 'Option 2',
                  ),
                  const SizedBox(height: 12),
                  DSRadio<int>(
                    value: 3,
                    groupValue: _selectedValue,
                    onChanged: _isDisabled
                        ? null
                        : (value) {
                            setState(() {
                              _selectedValue = value ?? 1;
                            });
                          },
                    label: 'Option 3',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildSection(
              'Radio with Description',
              Column(
                children: [
                  DSRadio<int>(
                    value: 1,
                    groupValue: _selectedValue,
                    onChanged: _isDisabled
                        ? null
                        : (value) {
                            setState(() {
                              _selectedValue = value ?? 1;
                            });
                          },
                    label: 'Premium Plan',
                    description:
                        'Best value for money with all features included',
                  ),
                  const SizedBox(height: 16),
                  DSRadio<int>(
                    value: 2,
                    groupValue: _selectedValue,
                    onChanged: _isDisabled
                        ? null
                        : (value) {
                            setState(() {
                              _selectedValue = value ?? 1;
                            });
                          },
                    label: 'Standard Plan',
                    description: 'Good for most users with essential features',
                  ),
                  const SizedBox(height: 16),
                  DSRadio<int>(
                    value: 3,
                    groupValue: _selectedValue,
                    onChanged: _isDisabled
                        ? null
                        : (value) {
                            setState(() {
                              _selectedValue = value ?? 1;
                            });
                          },
                    label: 'Basic Plan',
                    description: 'Perfect for getting started',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildSection(
              'Different Sizes',
              Column(
                children: [
                  DSRadio<int>(
                    value: 1,
                    groupValue: _selectedSize,
                    onChanged: (value) {
                      setState(() {
                        _selectedSize = value ?? 1;
                      });
                    },
                    label: 'Small Size',
                    size: DSRadioSize.sm,
                  ),
                  const SizedBox(height: 12),
                  DSRadio<int>(
                    value: 2,
                    groupValue: _selectedSize,
                    onChanged: (value) {
                      setState(() {
                        _selectedSize = value ?? 1;
                      });
                    },
                    label: 'Medium Size (Default)',
                    size: DSRadioSize.md,
                  ),
                  const SizedBox(height: 12),
                  DSRadio<int>(
                    value: 3,
                    groupValue: _selectedSize,
                    onChanged: (value) {
                      setState(() {
                        _selectedSize = value ?? 1;
                      });
                    },
                    label: 'Large Size',
                    size: DSRadioSize.lg,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildSection(
              'Different Variants',
              Column(
                children: [
                  DSRadio<int>(
                    value: 1,
                    groupValue: _selectedVariant,
                    onChanged: (value) {
                      setState(() {
                        _selectedVariant = value ?? 0;
                      });
                    },
                    label: 'Primary Variant',
                    variant: DSRadioVariant.primary,
                  ),
                  const SizedBox(height: 12),
                  DSRadio<int>(
                    value: 2,
                    groupValue: _selectedVariant,
                    onChanged: (value) {
                      setState(() {
                        _selectedVariant = value ?? 0;
                      });
                    },
                    label: 'Secondary Variant',
                    variant: DSRadioVariant.secondary,
                  ),
                  const SizedBox(height: 12),
                  DSRadio<int>(
                    value: 3,
                    groupValue: _selectedVariant,
                    onChanged: (value) {
                      setState(() {
                        _selectedVariant = value ?? 0;
                      });
                    },
                    label: 'Outline Variant',
                    variant: DSRadioVariant.outline,
                  ),
                  const SizedBox(height: 12),
                  DSRadio<int>(
                    value: 4,
                    groupValue: _selectedVariant,
                    onChanged: (value) {
                      setState(() {
                        _selectedVariant = value ?? 0;
                      });
                    },
                    label: 'Ghost Variant',
                    variant: DSRadioVariant.ghost,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildSection(
              'Label Position',
              Column(
                children: [
                  DSRadio<int>(
                    value: 1,
                    groupValue: _selectedValue,
                    onChanged: _isDisabled
                        ? null
                        : (value) {
                            setState(() {
                              _selectedValue = value ?? 1;
                            });
                          },
                    label: 'Label on Right (Default)',
                    labelOnRight: true,
                  ),
                  const SizedBox(height: 12),
                  DSRadio<int>(
                    value: 2,
                    groupValue: _selectedValue,
                    onChanged: _isDisabled
                        ? null
                        : (value) {
                            setState(() {
                              _selectedValue = value ?? 1;
                            });
                          },
                    label: 'Label on Left',
                    labelOnRight: false,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildSection(
              'Custom Content',
              Column(
                children: [
                  DSRadio<int>(
                    value: 1,
                    groupValue: _selectedValue,
                    onChanged: _isDisabled
                        ? null
                        : (value) {
                            setState(() {
                              _selectedValue = value ?? 1;
                            });
                          },
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: colors.brand.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Custom Content',
                                style: textTheme.bodyMedium,
                              ),
                              Text(
                                'With custom widget as child',
                                style: textTheme.bodySmall?.copyWith(
                                  color: DSColorUsages.text.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildSection(
              'Disabled State',
              Column(
                children: [
                  SwitchListTile(
                    title: const Text('Disable All Radios'),
                    value: _isDisabled,
                    onChanged: (value) {
                      setState(() {
                        _isDisabled = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  DSRadio<int>(
                    value: 1,
                    groupValue: _selectedValue,
                    onChanged: _isDisabled
                        ? null
                        : (value) {
                            setState(() {
                              _selectedValue = value ?? 1;
                            });
                          },
                    label: 'Disabled Option 1',
                    isDisabled: _isDisabled,
                  ),
                  const SizedBox(height: 12),
                  DSRadio<int>(
                    value: 2,
                    groupValue: _selectedValue,
                    onChanged: _isDisabled
                        ? null
                        : (value) {
                            setState(() {
                              _selectedValue = value ?? 1;
                            });
                          },
                    label: 'Disabled Option 2',
                    description: 'This option is disabled',
                    isDisabled: _isDisabled,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildSection(
              'Radio Only (No Label)',
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DSRadio<int>(
                    value: 1,
                    groupValue: _selectedValue,
                    onChanged: _isDisabled
                        ? null
                        : (value) {
                            setState(() {
                              _selectedValue = value ?? 1;
                            });
                          },
                    size: DSRadioSize.sm,
                  ),
                  DSRadio<int>(
                    value: 2,
                    groupValue: _selectedValue,
                    onChanged: _isDisabled
                        ? null
                        : (value) {
                            setState(() {
                              _selectedValue = value ?? 1;
                            });
                          },
                    size: DSRadioSize.md,
                  ),
                  DSRadio<int>(
                    value: 3,
                    groupValue: _selectedValue,
                    onChanged: _isDisabled
                        ? null
                        : (value) {
                            setState(() {
                              _selectedValue = value ?? 1;
                            });
                          },
                    size: DSRadioSize.lg,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildSection(
              'Current Selection',
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
                      'Selected Values:',
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Basic Selection: $_selectedValue'),
                    Text('Size Selection: $_selectedSize'),
                    Text('Variant Selection: $_selectedVariant'),
                    Text('Disabled: $_isDisabled'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        content,
      ],
    );
  }
}
