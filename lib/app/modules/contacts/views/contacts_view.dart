import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/contacts_controller.dart';

class ContactsView extends GetView<ContactsController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MoralarScaffold(
      appBar: const MoralarAppBar(
        titleText: 'Entrar em contato',
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 64),
              Container(
                padding: const EdgeInsets.all(24),
                child: MoralarImage.asset(Assets.images.appLogo),
              ),
              const SizedBox(height: 64),
              Text(
                'Entrar em contato',
                style: textTheme.displayMedium?.copyWith(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 64),
              MoralarButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          backgroundColor: Colors.transparent,
                          child: Container(
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // launch("tel://2126209924");
                                InkWell(
                                  onTap: () {
                                    launch("tel://2126209924");
                                  },
                                  child: Text(
                                    "(21) 2620-9924",
                                    style: textTheme.bodyMedium?.copyWith(
                                        fontSize: 18,
                                        color: MoralarColors.strawberry),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    launch("tel://21982041720");
                                  },
                                  child: Text(
                                    "(21) 98204-1720",
                                    style: textTheme.bodyMedium?.copyWith(
                                        fontSize: 18,
                                        color: MoralarColors.strawberry),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
                color: MoralarColors.kellyGreen,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.phone, color: Colors.white),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        'Entrar em contato com a equipe TTS',
                        style: textTheme.labelLarge?.copyWith(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
