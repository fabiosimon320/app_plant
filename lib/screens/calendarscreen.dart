import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant_app/providers/followedplantprovider.dart';
import 'package:plant_app/widgets/infocard.dart';
import 'package:plant_app/widgets/myappbar.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/plant.dart';


class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  CalendarScreenState createState() => CalendarScreenState();
}
class CalendarScreenState extends ConsumerState<CalendarScreen> {
  DateTime giornoSelezionato = DateTime.now();
  DateTime focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {

    final followedPlants = ref.watch(followedPlantsDataProvider);

    DateTime now = DateTime.now();
    final Map<DateTime, List<Plant>> eventsByDay = {};

    const daysAhead = 30;

    for (final plant in followedPlants) {
      for (int i = 0; i <= daysAhead; i++) {
        if (i % plant.waterday == 0) {
          final day = DateTime(now.year, now.month, now.day).add(
              Duration(days: i));
          eventsByDay.putIfAbsent(day, () => []);
          eventsByDay[day]!.add(plant);
        }
      }
    }

    return Scaffold(

      appBar: MyAppBar(title: 'Calendario'),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TableCalendar(
                focusedDay: focusedDay,
                firstDay: DateTime.now(),
                lastDay: now.add(Duration(days: daysAhead)),
                eventLoader: (day) {
                  final normalizedDay = DateTime(day.year, day.month, day.day);
                  return eventsByDay[normalizedDay] ?? [];
                },

                selectedDayPredicate: (day) {
                  return isSameDay(day, giornoSelezionato);
                },

                onDaySelected: (giornoAggiornato, giornoCorrente) {
                  setState(() {
                    giornoSelezionato = giornoAggiornato;
                    focusedDay = giornoCorrente;
                  });
                }


            ),
            const SizedBox(height: 40),

            Expanded(
              child: ListView.separated(
                itemCount: (eventsByDay[DateTime(
                    giornoSelezionato.year,
                    giornoSelezionato.month,
                    giornoSelezionato.day)] ?? []).length,
                itemBuilder: (context, index) {
                  final plant = (eventsByDay[DateTime(
                      giornoSelezionato.year,
                      giornoSelezionato.month,
                      giornoSelezionato.day)] ?? [])[index];
                  return InfoCard(
                    icon: Icons.water_drop,
                    title: '',
                    value: 'Annaffia ${plant.name}',
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}

