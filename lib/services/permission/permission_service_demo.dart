import 'package:flutter/material.dart';

import 'permission_service.dart';

/// Demo widget để minh họa cách sử dụng PermissionService
class PermissionServiceDemo extends StatefulWidget {
  const PermissionServiceDemo({super.key});

  @override
  State<PermissionServiceDemo> createState() => _PermissionServiceDemoState();
}

class _PermissionServiceDemoState extends State<PermissionServiceDemo> {
  final List<String> _permissionResults = [];
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permission Service Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildPermissionButton(
              'Check Camera Permission',
              _checkCameraPermission,
            ),
            const SizedBox(height: 8),
            _buildPermissionButton(
              'Request Camera Permission',
              _requestCameraPermission,
            ),
            const SizedBox(height: 8),
            _buildPermissionButton(
              'Request Multiple Permissions',
              _requestMultiplePermissions,
            ),
            const SizedBox(height: 8),
            _buildPermissionButton(
              'Open App Settings',
              _openAppSettings,
            ),
            const SizedBox(height: 16),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else
              Expanded(
                child: _buildResultsList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionButton(String title, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: _isLoading ? null : onPressed,
      child: Text(title),
    );
  }

  Widget _buildResultsList() {
    if (_permissionResults.isEmpty) {
      return const Center(
        child: Text(
          'No permission results yet.\n'
          'Tap the buttons above to test permissions.',
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.builder(
      itemCount: _permissionResults.length,
      itemBuilder: (context, index) {
        final result = _permissionResults[index];
        return Card(
          child: ListTile(
            title: Text(result),
            leading: Icon(
              result.contains('✅') ? Icons.check_circle : Icons.cancel,
              color: result.contains('✅') ? Colors.green : Colors.red,
            ),
          ),
        );
      },
    );
  }

  Future<void> _checkCameraPermission() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final hasPermission = await PermissionService.instance.checkPermission(
        Permission.camera,
        context,
      );

      setState(() {
        _permissionResults.insert(
          0,
          '${DateTime.now().toString().substring(11, 19)} - '
          'Camera Permission Check: '
          '${hasPermission ? '✅ Granted' : '❌ Denied'}',
        );
      });
    } catch (e) {
      setState(() {
        _permissionResults.insert(
          0,
          '${DateTime.now().toString().substring(11, 19)} - '
          'Camera Permission Check: ❌ Error - $e',
        );
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _requestCameraPermission() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final granted = await PermissionService.instance.requestCameraPermission(
        context,
        showWarningDialog: true,
      );

      setState(() {
        _permissionResults.insert(
          0,
          '${DateTime.now().toString().substring(11, 19)} - '
          'Camera Permission Request: ${granted ? '✅ Granted' : '❌ Denied'}',
        );
      });
    } catch (e) {
      setState(() {
        _permissionResults.insert(
          0,
          '${DateTime.now().toString().substring(11, 19)} - '
          'Camera Permission Request: ❌ Error - $e',
        );
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _requestMultiplePermissions() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final results = await PermissionService.instance.requestPermissions(
        [
          Permission.camera,
          Permission.microphone,
          Permission.location,
        ],
        context,
        showWarningDialog: true,
      );

      final permissionNames = ['Camera', 'Microphone', 'Location'];
      final resultText = permissionNames.asMap().entries.map((entry) {
        final index = entry.key;
        final name = entry.value;
        final granted = results[index];
        return '$name: ${granted ? '✅' : '❌'}';
      }).join(', ');

      setState(() {
        _permissionResults.insert(
          0,
          '${DateTime.now().toString().substring(11, 19)} - '
          'Multiple Permissions: $resultText',
        );
      });
    } catch (e) {
      setState(() {
        _permissionResults.insert(
          0,
          '${DateTime.now().toString().substring(11, 19)} - '
          'Multiple Permissions: ❌ Error - $e',
        );
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _openAppSettings() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await PermissionService.instance.openAppSetting();

      setState(() {
        _permissionResults.insert(
          0,
          '${DateTime.now().toString().substring(11, 19)} - '
          'App Settings: ✅ Opened',
        );
      });
    } catch (e) {
      setState(() {
        _permissionResults.insert(
          0,
          '${DateTime.now().toString().substring(11, 19)} - '
          'App Settings: ❌ Error - $e',
        );
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
