import 'package:flutter/material.dart';

void main() {
  runApp(const CombinaDescombinaApp());
}

class CombinaDescombinaApp extends StatelessWidget {
  const CombinaDescombinaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Combina e Descombina',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MusicScreen(),
      },
    );
  }
}

class MusicScreen extends StatefulWidget {
  const MusicScreen({super.key});

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  bool isCombinado = true;

  void _toggleState() {
    setState(() {
      isCombinado = !isCombinado;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    // Changing background color smoothly based on the state
    final backgroundColor = isCombinado ? colorScheme.primaryContainer : colorScheme.errorContainer;
    final textColor = isCombinado ? colorScheme.onPrimaryContainer : colorScheme.onErrorContainer;
    final iconColor = isCombinado ? colorScheme.primary : colorScheme.error;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('A Musa do Imprevisto', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: ListView(
              padding: const EdgeInsets.all(24.0),
              children: [
                _buildHeader(textColor),
                const SizedBox(height: 32),
                _buildLyricsCard(
                  title: 'Verso 1',
                  lyrics: 'Ela diz que vai, diz que tá de pé\n'
                          'Marca no relógio, diz que sabe o que quer\n'
                          'Bota o vestido, passa o batom\n'
                          'Diz que a noite hoje vai ser muito bom.',
                ),
                const SizedBox(height: 16),
                _buildLyricsCard(
                  title: 'Refrão',
                  lyrics: 'Mas ela combina... e depois descombina!\n'
                          'É a rainha da reviravolta, dona da neblina\n'
                          'Quando você acha que o plano tá feito\n'
                          'Ela manda mensagem: "Ai, não vai ter jeito!"',
                  isChorus: true,
                  highlightColor: iconColor,
                ),
                const SizedBox(height: 16),
                _buildLyricsCard(
                  title: 'Verso 2',
                  lyrics: 'Na sexta o barzinho já tava fechado\n'
                          'No sábado o show, ingresso comprado\n'
                          'Domingo um café pra curar a ressaca\n'
                          'Mas chega na hora... ela vira a casaca!',
                ),
                const SizedBox(height: 48),
                _buildInteractiveButton(iconColor),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(Color textColor) {
    return Column(
      children: [
        Icon(
          isCombinado ? Icons.calendar_month : Icons.event_busy,
          size: 80,
          color: textColor,
        ),
        const SizedBox(height: 16),
        Text(
          isCombinado ? 'Tudo Combinado! 🎉' : 'Ih... Descombinou! 😅',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          isCombinado 
              ? 'O plano está de pé. Prepare-se para sair!' 
              : 'Recebeu a mensagem de última hora. Volta pro sofá.',
          style: TextStyle(
            fontSize: 16,
            color: textColor.withOpacity(0.8),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildLyricsCard({
    required String title,
    required String lyrics,
    bool isChorus = false,
    Color? highlightColor,
  }) {
    return Card(
      elevation: isChorus ? 8 : 2,
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isChorus && highlightColor != null
            ? BorderSide(color: highlightColor, width: 2)
            : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              lyrics,
              style: TextStyle(
                fontSize: isChorus ? 18 : 16,
                fontWeight: isChorus ? FontWeight.w600 : FontWeight.normal,
                height: 1.6,
                fontStyle: isChorus ? FontStyle.italic : FontStyle.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveButton(Color buttonColor) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        child: ElevatedButton.icon(
          onPressed: _toggleState,
          icon: Icon(
            isCombinado ? Icons.cancel_outlined : Icons.check_circle_outline,
            size: 28,
          ),
          label: Text(
            isCombinado ? 'Simular o "Descombina"' : 'Tentar Combinar de Novo',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: buttonColor,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 4,
          ),
        ),
      ),
    );
  }
}
