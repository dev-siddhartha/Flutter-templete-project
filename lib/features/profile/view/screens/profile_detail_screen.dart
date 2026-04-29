import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/core/services/state/normal_state.dart';
import 'package:flutter_template/core/utils/app_imports.dart';
import 'package:flutter_template/features/profile/model/profile_model.dart';
import 'package:flutter_template/features/profile/viewmodel/bloc/profile_bloc/profile_bloc.dart';

class ProfileDetailScreen extends StatefulWidget {
  const ProfileDetailScreen({super.key});

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  @override
  void initState() {
    super.initState();
    getIt<ProfileBloc>().add(
      GetProfileEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const TextWidget("Profile")),
      body: RefreshIndicator(
        onRefresh: () async => getIt<ProfileBloc>().add(GetProfileEvent()),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            final profile = state.detailState;

            if (profile is NormalLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (profile is NormalFailureState) {
              return Center(
                child: TextWidget(
                    profile.failure?.message ?? 'counld not get profile'),
              );
            }

            if (profile is NormalSuccessState) {
              final data = profile.data;

              return _ProfileBody(data: data ?? ProfileModel());
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  final ProfileModel data;

  const _ProfileBody({required this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HeaderSection(data: data),
          const SizedBox(height: 16),
          _SectionCard(
            title: "Personal Info",
            child: _PersonalInfo(data: data),
          ),
          _SectionCard(
            title: "Address",
            child: _AddressInfo(data: data.address ?? Address()),
          ),
          _SectionCard(
            title: "Company",
            child: _CompanyInfo(data: data.company ?? Company()),
          ),
          _SectionCard(
            title: "Bank",
            child: _BankInfo(data: data.bank ?? Bank()),
          ),
        ],
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final ProfileModel data;

  const _HeaderSection({required this.data});

  @override
  Widget build(BuildContext context) {
    final imagePath = data.localImage; // from cache

    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage:
              imagePath != null ? FileImage(File(imagePath)) : null,
          child: imagePath == null ? const Icon(Icons.person) : null,
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              "${data.firstName} ${data.lastName}",
              textType: TextType.title,
            ),
            TextWidget(data.email ?? ''),
            TextWidget("Role: ${data.role}"),
          ],
        )
      ],
    );
  }
}

class _PersonalInfo extends StatelessWidget {
  final ProfileModel data;

  const _PersonalInfo({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _InfoRow("Username", data.username),
        _InfoRow("Gender", data.gender),
        _InfoRow("Age", data.age.toString()),
        _InfoRow("Phone", data.phone),
        _InfoRow("Blood Group", data.bloodGroup),
        _InfoRow("Height", data.height.toString()),
        _InfoRow("Weight", data.weight.toString()),
        _InfoRow("Eye Color", data.eyeColor),
      ],
    );
  }
}

class _AddressInfo extends StatelessWidget {
  final Address data;

  const _AddressInfo({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _InfoRow("Street", data.address),
        _InfoRow("City", data.city),
        _InfoRow("State", data.state),
        _InfoRow("Postal Code", data.postalCode),
        _InfoRow("Country", data.country),
      ],
    );
  }
}

class _CompanyInfo extends StatelessWidget {
  final Company data;

  const _CompanyInfo({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _InfoRow("Company", data.name),
        _InfoRow("Department", data.department),
        _InfoRow("Title", data.title),
      ],
    );
  }
}

class _BankInfo extends StatelessWidget {
  final Bank data;

  const _BankInfo({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _InfoRow("Card Type", data.cardType),
        _InfoRow("Card Number", data.cardNumber),
        _InfoRow("Currency", data.currency),
        _InfoRow("IBAN", data.iban),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              title,
              textType: TextType.custom,
              textOptions: const TextOptions(fontWeight: FontWeight.bold),
            ),
            const Divider(),
            child,
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String? value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: TextWidget(
              label,
              textType: TextType.custom,
              textOptions: const TextOptions(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: TextWidget(value ?? "-"),
          ),
        ],
      ),
    );
  }
}
