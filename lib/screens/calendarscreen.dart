import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant_app/providers/followedplantprovider.dart';
import 'package:plant_app/widgets/infocard.dart';
import 'package:plant_app/widgets/myappbar.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/plant.dart';
import '../services/notification_service.dart';


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

    const daysAhead = 60;

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

    final todayPlants = eventsByDay[DateTime(now.year, now.month, now.day)] ?? [];
    if (todayPlants.isNotEmpty) {
      NotificationService().showWaterReminder();
    }

    return Scaffold(
      appBar: MyAppBar(title: 'Calendario'),
      extendBodyBehindAppBar: true,
      body: Stack(
          children: [
            Positioned.fill(

                child: Image.asset('assets/images/sfondocalendario.png',
                fit: BoxFit.cover, repeat: ImageRepeat.repeat,
                opacity: const AlwaysStoppedAnimation<double>(0.9),
                ),
            ),

            Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: kToolbarHeight),
                  TableCalendar(

                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                      ),
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
                          icon: Icons.water_drop_outlined,
                          title: '',
                          value: 'Annaffia pianta: ${plant.name}',
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 10),
                    ),
                  ),
                ],
              ),
            ),
          ]
        )
      );
    }
  
}

