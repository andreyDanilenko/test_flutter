import 'package:flutter/material.dart';
import 'package:test/features/profile/data/profile_model.dart';
import 'package:test/features/profile/data/profile_repository.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Profile? profile;
  int currentAvatarIndex = 0;
  bool isEditing = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final data = await ProfileRepository().loadProfile();
    setState(() {
      profile = data;
      nameController.text = data.name;
      emailController.text = data.email;
      phoneController.text = data.phone;
    });
  }

  void _toggleEdit() {
    setState(() {
      isEditing = !isEditing;
      if (!isEditing) {
        nameController.text = profile!.name;
        emailController.text = profile!.email;
        phoneController.text = profile!.phone;
      }
    });
  }

  void _saveProfile() {
    setState(() {
      profile = Profile(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        avatars: profile!.avatars,
      );
      isEditing = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Данные обновлены")),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (profile == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Профиль"),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.close : Icons.edit),
            onPressed: _toggleEdit,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isEditing ? _buildEditMode() : _buildViewMode(),
      ),
    );
  }

  Widget _buildViewMode() {
    return Padding(
      padding: const EdgeInsets.only(top: 100.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  currentAvatarIndex =
                      (currentAvatarIndex + 1) % profile!.avatars.length;
                });
              },
              child: CircleAvatar(
                backgroundImage:
                    AssetImage(profile!.avatars[currentAvatarIndex]),
                radius: 50,
              ),
            ),
            const SizedBox(height: 16),
            Text(profile!.name, style: const TextStyle(fontSize: 24)),
            Text(profile!.email, style: const TextStyle(fontSize: 16)),
            Text(profile!.phone, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildEditMode() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              currentAvatarIndex =
                  (currentAvatarIndex + 1) % profile!.avatars.length;
            });
          },
          child: CircleAvatar(
            backgroundImage: AssetImage(profile!.avatars[currentAvatarIndex]),
            radius: 50,
          ),
        ),
        const SizedBox(height: 16),
        _buildTextField("Имя", nameController),
        _buildTextField("Email", emailController),
        _buildTextField("Телефон", phoneController),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _saveProfile,
          child: const Text("Сохранить"),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
