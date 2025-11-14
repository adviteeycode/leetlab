import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:flutter_highlight/themes/atom-one-light.dart';
import 'package:highlight/languages/java.dart';
import 'package:leetlab/providers/theme_provider.dart';
import 'package:leetlab/ui/widgets/buttons/leet_lab_elevated_button.dart';
import 'package:leetlab/ui/widgets/glass_morphism.dart';
import 'package:provider/provider.dart';

class CodeEditor extends StatefulWidget {
  const CodeEditor({super.key, required this.code});

  final String code;

  @override
  State<CodeEditor> createState() => _CodeEditorPageState();
}

class _CodeEditorPageState extends State<CodeEditor> {
  CodeController? _codeController;
  final _scrollController = ScrollController();
  final _focusNode = FocusNode();
  double fontSize = 14;
  bool _showPasteWarning = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _codeController = CodeController(text: widget.code, language: java);
      });
    });
  }

  void _increaseFont() {
    setState(() {
      fontSize = (fontSize + 1).clamp(10, 28);
    });
  }

  void _decreaseFont() {
    setState(() {
      fontSize = (fontSize - 1).clamp(10, 28);
    });
  }

  void _showPasteWarningAnimation() {
    setState(() {
      _showPasteWarning = true;
    });
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showPasteWarning = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context) / 5 * 3;
    ThemeData theme = Theme.of(context);
    ThemeProvider provider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: _codeController == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Focus(
                  focusNode: _focusNode,
                  autofocus: true,
                  onKeyEvent: (node, event) {
                    if (event is KeyDownEvent) {
                      final isControlPressed =
                          HardwareKeyboard.instance.isControlPressed;
                      final isMetaPressed =
                          HardwareKeyboard.instance.isMetaPressed;

                      if (event.logicalKey == LogicalKeyboardKey.enter) {
                        _showPasteWarningAnimation();
                        return KeyEventResult.handled;
                      }

                      // Block paste: Ctrl/Cmd + V
                      if (event.logicalKey == LogicalKeyboardKey.keyV &&
                          (isControlPressed || isMetaPressed)) {
                        _showPasteWarningAnimation();

                        return KeyEventResult.handled;
                      }
                      // Ctrl/Cmd + = to increase font
                      else if (event.logicalKey == LogicalKeyboardKey.equal &&
                          (isControlPressed || isMetaPressed)) {
                        _increaseFont();
                        return KeyEventResult.handled;
                      }
                      // Ctrl/Cmd + - to decrease font
                      else if (event.logicalKey == LogicalKeyboardKey.minus &&
                          (isControlPressed || isMetaPressed)) {
                        _decreaseFont();
                        return KeyEventResult.handled;
                      }
                    }
                    return KeyEventResult.ignored;
                  },
                  child: GlassMorphism(
                    borderRadius: 12,
                    borderWidth: 1,
                    child: Column(
                      children: [
                        // ================= HEADER =================
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.code, size: 33),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Code Editor",
                                    style: theme.textTheme.headlineMedium,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              // Font Size Controls
                              if (size.width > 600)
                                GlassMorphism(
                                  borderRadius: 10,
                                  borderWidth: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 6,
                                    ),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: _decreaseFont,
                                          child: const Icon(Icons.remove),
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          "${fontSize.toInt()}",
                                          style: theme.textTheme.displaySmall,
                                        ),
                                        const SizedBox(width: 6),
                                        InkWell(
                                          onTap: _increaseFont,
                                          child: const Icon(Icons.add),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              const SizedBox(width: 12),

                              if (size.width > 600)
                                Container(
                                  height: 40,
                                  width: 2,
                                  decoration: BoxDecoration(
                                    color: theme.primaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),

                              const SizedBox(width: 12),
                              // Run Button
                              InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  final code = _codeController?.text ?? '';
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Running code:\n$code"),
                                    ),
                                  );
                                },
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.play_arrow, size: 32),
                                        const SizedBox(width: 4),
                                        Text(
                                          "Run",
                                          style: theme.textTheme.displaySmall,
                                        ),
                                        const SizedBox(width: 4),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 8),

                              // Submit Button
                              LeetLabElevatedButton(
                                text: "Submit",
                                onPressed: () {},
                                isLoading: false,
                              ),
                            ],
                          ),
                        ),

                        // ================= CODE FIELD =================
                        Expanded(
                          child: Scrollbar(
                            thumbVisibility: true,
                            controller: _scrollController,
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              child: CodeTheme(
                                data: CodeThemeData(
                                  styles: provider.isDarkTheme
                                      ? monokaiSublimeTheme
                                      : atomOneLightTheme,
                                ),
                                child: CodeField(
                                  controller: _codeController!,
                                  textStyle: TextStyle(
                                    fontSize: fontSize,
                                    letterSpacing: 1.15,
                                  ),
                                  minLines: 100,
                                  expands: false,
                                  readOnly: false,
                                ),
                              ),
                            ),
                          ),
                        ),

                        Container(height: 8),
                      ],
                    ),
                  ),
                ),

                // Paste Warning Overlay
                if (_showPasteWarning)
                  Positioned(
                    child: AnimatedOpacity(
                      opacity: _showPasteWarning ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: Center(child: Image.asset("assets/icon/logo.png")),
                    ),
                  ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _scrollController.dispose();
    _codeController?.dispose();
    super.dispose();
  }
}
