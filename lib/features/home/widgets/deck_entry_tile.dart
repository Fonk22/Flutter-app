import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:memo_deck/core/service_locator.dart';
import 'package:memo_deck/features/activity_tracker/logic/study_session_manager.dart';
import 'package:memo_deck/features/home/bloc/deck_management_cubit.dart';
import 'package:memo_deck/features/home/widgets/delete_deck_confirmation_dialog.dart';
import '../../../shared/models/deck_entry.dart';

class DeckEntryTile extends StatelessWidget {
  const DeckEntryTile({super.key, required this.deck});
  final DeckEntry deck;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        title: Text(deck.name),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _practiceButton(context),
            const SizedBox(
              width: 5,
            ),
            _deckMenu(context),
          ],
        ),
      ),
    );
  }

  Widget _practiceButton(BuildContext context) {
    return FilledButton.tonal(
        onPressed: () async {
          serviceLocator<StudySessionManager>().startNewSession(deck.deckId);
          await context.pushNamed('QuizPage', extra: deck.deckId);
          serviceLocator<StudySessionManager>().endSession();
        },
        child: const Text('Practice'),);
  }

  Widget _deckMenu(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(
        Icons.more_vert,
      ),
      onSelected: (value) async {
        switch (value) {
          case 'add_card':
            unawaited(context.pushNamed('ManageFlashcardPage',
                pathParameters: {'deckId': deck.deckId},),);
          case 'remove_deck':
            {
              await showDeleteDeckConfirmationDialog(context, deck, () {
                context.read<DeckManagementCubit>()
                .removeDeck(deck);
              });
            }
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'add_card',
          child: Row(
            children: [
              Icon(Icons.add),
              SizedBox(
                width: 8,
              ),
              Text('Add Card'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'remove_deck',
          child: Row(
            children: [
              Icon(
                Icons.delete,
                color: Colors.red,
              ),
              SizedBox(
                width: 8,
              ),
              Text('Remove Deck'),
            ],
          ),
        ),
      ],
    );
  }
}
