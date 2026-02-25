import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../models/resident.dart';

class ResidentEditDialog extends StatefulWidget {
  final Resident resident;

  const ResidentEditDialog({super.key, required this.resident});

  @override
  State<ResidentEditDialog> createState() => _ResidentEditDialogState();
}

class _ResidentEditDialogState extends State<ResidentEditDialog> {
  late TextEditingController nameController;
  late TextEditingController lastNameController;
  late TextEditingController ageController;

  late String aspiration;
  late String? eyeColor;
  late String? hairColor;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.resident.name);
    lastNameController = TextEditingController(text: widget.resident.lastName);
    ageController = TextEditingController(text: widget.resident.age.toString());

    aspiration = widget.resident.traits.aspiration;
    eyeColor = widget.resident.traits.eyeColor;
    hairColor = widget.resident.traits.hairColor;
  }

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    ageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24), 
      ),
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Container(
        padding: const EdgeInsets.all(20),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.75, 
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(PhosphorIcons.info(PhosphorIconsStyle.bold), color: Theme.of(context).colorScheme.onSurface),
                    SizedBox(width: 10),
                    Text(
                      "Karta Sima",
                      style: GoogleFonts.quicksand(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(PhosphorIcons.x(PhosphorIconsStyle.bold), color: Theme.of(context).colorScheme.onSurface),
                  onPressed: () => Navigator.of(context).pop(false), // Zamykamy bez zapisu
                ),
              ],
            ),
            Divider(color: Theme.of(context).colorScheme.outlineVariant),
            
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    _buildSectionTitle("Podstawowe"),

                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceContainerHigh,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(PhosphorIcons.user(PhosphorIconsStyle.bold), size: 60, color: Theme.of(context).colorScheme.onSurface),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            children: [
                              TextField(
                                controller: nameController,
                                decoration: const InputDecoration(labelText: "Imię", labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: lastNameController,
                                decoration: const InputDecoration(labelText: "Nazwisko", labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Wiek", labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    
                    const SizedBox(height: 25),
                    _buildSectionTitle("Cechy i Wygląd"),
                    
                    DropdownButtonFormField<String>(
                      initialValue: aspiration,
                      decoration: const InputDecoration(labelText: "Aspiracja"),
                      items: ["Nieznana", "Bogactwo", "Romans", "Wiedza", "Rodzina", "Popularność"]
                          .map((String val) => DropdownMenuItem(value: val, child: Text(val)))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          if (val != null) aspiration = val;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    
                    DropdownButtonFormField<String>(
                      initialValue: eyeColor,
                      decoration: const InputDecoration(labelText: "Kolor oczu"),
                      items: ["Brązowe", "Niebieskie", "Zielone", "Szare", "Czerwone"]
                          .map((String val) => DropdownMenuItem(value: val, child: Text(val)))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          if (val != null) eyeColor = val;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      initialValue: hairColor,
                      decoration: const InputDecoration(labelText: "Kolor włosów"),
                      items: ["Czarne", "Brązowe", "Blond", "Rude", "Szare", "Białe"]
                          .map((String val) => DropdownMenuItem(value: val, child: Text(val)))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          if (val != null) hairColor = val;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // --- PRZYCISK ZAPISU (Zawsze na dole) ---
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: _saveChanges,
                child: const Text("Zapisz zmiany", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 8),
          Text(
            title.toUpperCase(),
            style: GoogleFonts.quicksand(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  void _saveChanges() {
    final newAge = int.tryParse(ageController.text.trim());
    if (nameController.text.isEmpty || lastNameController.text.isEmpty || newAge == null) {
      // Możesz tu rzucić błąd
      return;
    }

    widget.resident.name = nameController.text.trim();
    widget.resident.lastName = lastNameController.text.trim();
    widget.resident.age = newAge;
    
    widget.resident.traits.aspiration = aspiration;
    widget.resident.traits.eyeColor = eyeColor?.trim();
    widget.resident.traits.hairColor = hairColor?.trim();

    Navigator.of(context).pop(true);
  }
}