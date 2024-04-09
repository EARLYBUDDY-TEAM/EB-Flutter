part of 'home_view.dart';

class HomeScheduleAddButton extends StatelessWidget {
  const HomeScheduleAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, bottom: 80),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              EBColors.blue1,
              EBColors.purple1,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddScheduleView()),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(0),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          child: const Icon(
            Icons.add,
            size: 40,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
