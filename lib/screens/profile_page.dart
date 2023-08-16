import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
        backgroundColor: Colors.white, 
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            children: [
              const _SingleSection(
                title: "Informações da conta",
                children: [
                  _CustomListTile(title: "Nome"),
                  _CustomListTile(title: "Email"),
                  _CustomListTile(title: "Senha"),
                ],
              ),
              const _SingleSection(
                title: "Pokédex",
                children: [
                  // Add your Pokédex related content here
                ],
              ),
              _SingleSection(
                title: "Notificações",
                children: [
                  _SwitchListTile(
                    title: "Atualizações na pokédex",
                    switchValue: false,
                    onSwitchChanged: (value) {
                      // Handle switch value change here
                    },
                  ),
                  _SwitchListTile(
                    title: "Mundo Pokémon",
                    switchValue: false,
                    onSwitchChanged: (value) {
                      // Handle switcswh value change here
                    },
                  ),
                ],
              ),
              const _SingleSection(
                title: "Geral",
                children: [
                  _CustomListTile(title: "Versão"),
                  _CustomListTile(title: "Termos e condições"),
                  _CustomListTile(title: "Central de ajuda"),
                  _CustomListTile(title: "Sobre"),
                ],
              ),
              const _SingleSection(
                title: "Outros",
                children: [
                  _CustomListTile(title: "Sair"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const _CustomListTile({Key? key, required this.title, this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasForwardIcon = title == "Nome" || title == "Email" || title == "Senha";

    return ListTile(
      title: Text(title),
      trailing: hasForwardIcon
          ? trailing ?? const Icon(CupertinoIcons.forward, size: 18)
          : trailing,
      onTap: () {},
    );
  }
}

class _SwitchListTile extends StatelessWidget {
  final String title;
  final bool switchValue;
  final ValueChanged<bool> onSwitchChanged;

  const _SwitchListTile({
    Key? key,
    required this.title,
    required this.switchValue,
    required this.onSwitchChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Switch(
        value: switchValue,
        onChanged: onSwitchChanged,
      ),
      onTap: () {},
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SingleSection({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(fontSize: 16),
          ),
        ),
        Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
