import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(StudyPro());

final primary = Color(0xFF6750A4);
final dark = Color(0xFF11152B);
final accent = Color(0xFFF4C95D);

class Student {
  String name;
  String id;
  String email;
  String phone;
  String course;
  String semester;
  String division;
  String roll;
  String studyTime;
  List<String> subjects;

  int minutes = 0;

  final scores = <String, int>{};
  final tasks = <String>[];
  final notes = <String>[];
  final done = <String>{};

  Student({
    required this.name,
    required this.id,
    required this.email,
    required this.phone,
    required this.course,
    required this.semester,
    required this.division,
    required this.roll,
    required this.studyTime,
    required this.subjects,
  });
}

final students = <Student>[];

final builtInQuizzes = <String, List<Map<String, dynamic>>>{
  'Data Structures': [
    {
      'q': 'Which data structure follows LIFO?',
      'o': ['Queue', 'Stack', 'Tree', 'Graph'],
      'a': 1
    },
    {
      'q': 'Binary search requires data to be?',
      'o': ['Random', 'Sorted', 'Encrypted', 'Duplicated'],
      'a': 1
    },
    {
      'q': 'Which is a linear data structure?',
      'o': ['Tree', 'Graph', 'Array', 'Heap'],
      'a': 2
    },
    {
      'q': 'Which data structure follows FIFO?',
      'o': ['Stack', 'Queue', 'Tree', 'Graph'],
      'a': 1
    },
    {
      'q': 'Which traversal commonly uses a queue?',
      'o': ['BFS', 'DFS', 'Inorder', 'Postorder'],
      'a': 0
    },
  ],
  'Discrete Mathematics': [
    {
      'q': 'A set with no elements is called?',
      'o': ['Universal', 'Empty', 'Finite', 'Power'],
      'a': 1
    },
    {
      'q': 'A proposition is?',
      'o': [
        'A question',
        'A command',
        'A true or false statement',
        'A number'
      ],
      'a': 2
    },
    {
      'q': 'How many elements are in {1,2,3}?',
      'o': ['2', '3', '4', '1'],
      'a': 1
    },
    {
      'q': 'The complement of the universal set is?',
      'o': ['Universal set', 'Empty set', 'Power set', 'Subset'],
      'a': 1
    },
    {
      'q': 'A relation that is reflexive, symmetric and transitive is?',
      'o': ['Function', 'Equivalence relation', 'Subset', 'Sequence'],
      'a': 1
    },
  ],
  'MPMC': [
    {
      'q': '8085 is a?',
      'o': [
        '8-bit microprocessor',
        '16-bit processor',
        'Compiler',
        'Database'
      ],
      'a': 0
    },
    {
      'q': 'Which is the accumulator register?',
      'o': ['B', 'C', 'A', 'D'],
      'a': 2
    },
    {
      'q': 'The HL register pair is mainly used as?',
      'o': [
        'Memory pointer',
        'Counter',
        'Stack',
        'Flag register'
      ],
      'a': 0
    },
    {
      'q': 'Which instruction loads immediate data into A?',
      'o': [
        'MOV A,B',
        'MVI A,data',
        'LXI H,data',
        'STA'
      ],
      'a': 1
    },
    {
      'q': 'Which register holds the address of the next instruction?',
      'o': [
        'Accumulator',
        'Program Counter',
        'Stack Pointer',
        'B'
      ],
      'a': 1
    },
  ],
  'Mobile Programming': [
    {
      'q': 'Flutter mainly uses which programming language?',
      'o': ['Java', 'Dart', 'C++', 'Python'],
      'a': 1
    },
    {
      'q': 'Which widget creates a vertical layout?',
      'o': ['Row', 'Column', 'Stack', 'Table'],
      'a': 1
    },
    {
      'q': 'Which widget is used for text input?',
      'o': ['TextField', 'Icon', 'Card', 'Divider'],
      'a': 0
    },
    {
      'q': 'Which widget is commonly used for a clickable button?',
      'o': ['Text', 'ElevatedButton', 'Container', 'Image'],
      'a': 1
    },
    {
      'q': 'Which widget is commonly used for a scrollable list?',
      'o': ['ListView', 'Text', 'Icon', 'Padding'],
      'a': 0
    },
  ],
  'Software Engineering': [
    {
      'q': 'SDLC stands for?',
      'o': [
        'Software Development Life Cycle',
        'System Data Logic Code',
        'Software Design Level Control',
        'None'
      ],
      'a': 0
    },
    {
      'q': 'Which software model follows a sequential approach?',
      'o': ['Agile', 'Waterfall', 'Spiral', 'Prototype'],
      'a': 1
    },
    {
      'q': 'What is a major purpose of software testing?',
      'o': [
        'Find defects',
        'Write theory',
        'Design logos',
        'Increase RAM'
      ],
      'a': 0
    },
    {
      'q': 'Agile mainly focuses on?',
      'o': [
        'Continuous iteration',
        'No testing',
        'No feedback',
        'Only documentation'
      ],
      'a': 0
    },
    {
      'q': 'A software requirement describes?',
      'o': [
        'What the system should do',
        'Only color',
        'Only hardware',
        'Only database'
      ],
      'a': 0
    },
  ],
};

final aptitude = [
  {
    'q': '2, 6, 12, 20, ?',
    'o': ['24', '30', '32', '36'],
    'a': 1
  },
  {
    'q': 'If CAT = DBU, then DOG = ?',
    'o': ['EPH', 'EOG', 'FPH', 'DPH'],
    'a': 0
  },
  {
    'q': 'A > B and B > C. Who is shortest?',
    'o': ['A', 'B', 'C', 'Cannot say'],
    'a': 2
  },
  {
    'q': '5 pens cost ₹50. What is the cost of 8 pens?',
    'o': ['₹70', '₹80', '₹90', '₹100'],
    'a': 1
  },
  {
    'q': 'Which number does not belong?',
    'o': ['3', '7', '10', '11'],
    'a': 2
  },
  {
    'q': 'What is 25% of 200?',
    'o': ['25', '40', '50', '75'],
    'a': 2
  },
  {
    'q': 'Monday + 10 days = ?',
    'o': ['Wednesday', 'Thursday', 'Friday', 'Saturday'],
    'a': 1
  },
];

ThemeData appTheme(bool darkMode) {
  return ThemeData(
    useMaterial3: true,
    brightness: darkMode ? Brightness.dark : Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      brightness: darkMode ? Brightness.dark : Brightness.light,
    ),
    scaffoldBackgroundColor:
    darkMode ? Color(0xFF0D0D14) : Color(0xFFF5F5FA),
    cardTheme: CardThemeData(
      elevation: darkMode ? 0 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
    ),
  );
}

String? emailValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Email is required';
  }

  final email = value.trim();

  final pattern = RegExp(
    r'^[\w\.-]+@[\w\.-]+\.\w+$',
  );

  if (!pattern.hasMatch(email)) {
    return 'Enter a valid email address';
  }

  return null;
}

String? phoneValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Mobile number is required';
  }

  if (!RegExp(r'^[0-9]{10}$').hasMatch(value.trim())) {
    return 'Enter exactly 10 digits';
  }

  return null;
}

String? requiredValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Required';
  }

  return null;
}

class StudyPro extends StatefulWidget {
  StudyPro({super.key});

  @override
  State<StudyPro> createState() => _StudyProState();
}

class _StudyProState extends State<StudyPro> {
  Student? current;
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StudyPro',
      theme: appTheme(false),
      darkTheme: appTheme(true),
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      home: current == null
          ? Login(
        login: (student) {
          setState(() => current = student);
        },
      )
          : MainHome(
        student: current!,
        darkMode: darkMode,
        toggleDark: () {
          setState(() => darkMode = !darkMode);
        },
        logout: () {
          setState(() => current = null);
        },
      ),
    );
  }
}

class Login extends StatelessWidget {
  final void Function(Student) login;

  Login({
    super.key,
    required this.login,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              dark,
              Color(0xFF302B63),
              primary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 500),
              child: Card(
                elevation: 18,
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 38,
                        backgroundColor: primary,
                        child: Icon(
                          Icons.auto_awesome,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'STUDYPRO',
                        style: TextStyle(
                          fontSize: 31,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        'Student Productivity & Academic Management',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 28),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: FilledButton.icon(
                          icon: Icon(Icons.person_add),
                          label: Text('CREATE STUDENT PROFILE'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Register(
                                  save: (student) {
                                    students.add(student);
                                    Navigator.pop(context);
                                    login(student);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 11),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: OutlinedButton.icon(
                          icon: Icon(Icons.login),
                          label: Text('STUDENT LOGIN'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => StudentLogin(
                                  login: login,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Register extends StatefulWidget {
  final void Function(Student) save;

  Register({
    super.key,
    required this.save,
  });

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final form = GlobalKey<FormState>();

  final name = TextEditingController();
  final id = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final course = TextEditingController();
  final roll = TextEditingController();
  final subject = TextEditingController();

  String semester = 'Semester 3';
  String division = 'A';
  String studyTime = '2:00 PM - 4:00 PM';

  final subjects = <String>[];

  @override
  void dispose() {
    name.dispose();
    id.dispose();
    email.dispose();
    phone.dispose();
    course.dispose();
    roll.dispose();
    subject.dispose();
    super.dispose();
  }

  Widget field(
      String label,
      TextEditingController controller,
      IconData icon, {
        String? Function(String?)? validator,
        TextInputType? keyboard,
        List<TextInputFormatter>? formatters,
      }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 11),
      child: TextFormField(
        controller: controller,
        validator: validator ?? requiredValidator,
        keyboardType: keyboard,
        inputFormatters: formatters,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }

  void addSubject() {
    final value = subject.text.trim();

    if (value.isEmpty) return;

    if (subjects.any(
          (x) => x.toLowerCase() == value.toLowerCase(),
    )) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('This subject is already added.'),
        ),
      );
      return;
    }

    setState(() {
      subjects.add(value);
      subject.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Registration'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(18),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 750),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(22),
                child: Form(
                  key: form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create Your Profile',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Enter your personal, academic and subject information.',
                      ),
                      SizedBox(height: 20),
                      field(
                        'Full Name',
                        name,
                        Icons.person,
                      ),
                      field(
                        'Student ID',
                        id,
                        Icons.badge,
                      ),
                      field(
                        'Email',
                        email,
                        Icons.email,
                        validator: emailValidator,
                        keyboard: TextInputType.emailAddress,
                      ),
                      field(
                        'Mobile Number',
                        phone,
                        Icons.phone,
                        validator: phoneValidator,
                        keyboard: TextInputType.phone,
                        formatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                      ),
                      field(
                        'Course',
                        course,
                        Icons.school,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: semester,
                              decoration: InputDecoration(
                                labelText: 'Semester',
                              ),
                              items: List.generate(
                                8,
                                    (i) => DropdownMenuItem(
                                  value: 'Semester ${i + 1}',
                                  child: Text('Semester ${i + 1}'),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() => semester = value!);
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: division,
                              decoration: InputDecoration(
                                labelText: 'Division',
                              ),
                              items: ['A', 'B', 'C', 'D']
                                  .map(
                                    (x) => DropdownMenuItem(
                                  value: x,
                                  child: Text(x),
                                ),
                              )
                                  .toList(),
                              onChanged: (value) {
                                setState(() => division = value!);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 11),
                      field(
                        'Roll Number',
                        roll,
                        Icons.numbers,
                      ),
                      DropdownButtonFormField<String>(
                        initialValue: studyTime,
                        decoration: InputDecoration(
                          labelText: 'Preferred Study Time',
                          prefixIcon: Icon(Icons.schedule),
                        ),
                        items: [
                          '7:00 AM - 9:00 AM',
                          '2:00 PM - 4:00 PM',
                          '5:00 PM - 7:00 PM',
                          '8:00 PM - 10:00 PM',
                        ]
                            .map(
                              (x) => DropdownMenuItem(
                            value: x,
                            child: Text(x),
                          ),
                        )
                            .toList(),
                        onChanged: (value) {
                          setState(() => studyTime = value!);
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        'My Subjects',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Enter the subjects for your current semester.',
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: subject,
                              onSubmitted: (_) => addSubject(),
                              decoration: InputDecoration(
                                labelText: 'Enter Subject',
                                prefixIcon: Icon(Icons.menu_book),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          FilledButton(
                            onPressed: addSubject,
                            child: Icon(Icons.add),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      if (subjects.isEmpty)
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Row(
                              children: [
                                Icon(Icons.info_outline),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    'Add at least one subject to continue.',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ...List.generate(
                        subjects.length,
                            (index) => Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text('${index + 1}'),
                            ),
                            title: Text(
                              subjects[index],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete_outline),
                              onPressed: () {
                                setState(() {
                                  subjects.removeAt(index);
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: FilledButton.icon(
                          icon: Icon(Icons.rocket_launch),
                          label: Text('CREATE PROFILE'),
                          onPressed: () {
                            if (!form.currentState!.validate()) {
                              return;
                            }

                            if (subjects.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Please add at least one subject.',
                                  ),
                                ),
                              );
                              return;
                            }

                            if (students.any(
                                  (student) =>
                              student.id.toLowerCase() ==
                                  id.text.trim().toLowerCase(),
                            )) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                  Text('Student ID already exists.'),
                                ),
                              );
                              return;
                            }

                            widget.save(
                              Student(
                                name: name.text.trim(),
                                id: id.text.trim(),
                                email: email.text.trim(),
                                phone: phone.text.trim(),
                                course: course.text.trim(),
                                semester: semester,
                                division: division,
                                roll: roll.text.trim(),
                                studyTime: studyTime,
                                subjects: List.from(subjects),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StudentLogin extends StatefulWidget {
  final void Function(Student) login;

  StudentLogin({
    super.key,
    required this.login,
  });

  @override
  State<StudentLogin> createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  final id = TextEditingController();

  @override
  void dispose() {
    id.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Login'),
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          child: Padding(
            padding: EdgeInsets.all(25),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 450),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.school,
                    size: 65,
                    color: primary,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 18),
                  TextField(
                    controller: id,
                    decoration: InputDecoration(
                      labelText: 'Student ID',
                      prefixIcon: Icon(Icons.badge),
                    ),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FilledButton(
                      child: Text('LOGIN'),
                      onPressed: () {
                        final result = students.where(
                              (student) =>
                          student.id.toLowerCase() ==
                              id.text.trim().toLowerCase(),
                        );

                        if (result.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Student ID not found.'),
                            ),
                          );
                        } else {
                          widget.login(result.first);
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MainHome extends StatefulWidget {
  final Student student;
  final bool darkMode;
  final VoidCallback toggleDark;
  final VoidCallback logout;

  MainHome({
    super.key,
    required this.student,
    required this.darkMode,
    required this.toggleDark,
    required this.logout,
  });

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  int page = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      Dashboard(student: widget.student),
      SubjectsPage(student: widget.student),
      FocusPage(student: widget.student),
      SchedulePage(student: widget.student),
      Profile(
        student: widget.student,
        darkMode: widget.darkMode,
        toggleDark: widget.toggleDark,
        logout: widget.logout,
      ),
    ];

    return Scaffold(
      body: pages[page],
      bottomNavigationBar: NavigationBar(
        selectedIndex: page,
        onDestinationSelected: (index) {
          setState(() => page = index);
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Subjects',
          ),
          NavigationDestination(
            icon: Icon(Icons.timer_outlined),
            selectedIcon: Icon(Icons.timer),
            label: 'Focus',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month),
            label: 'Schedule',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  final Student student;

  Dashboard({
    super.key,
    required this.student,
  });

  int get average {
    if (student.scores.isEmpty) return 0;

    return (student.scores.values.reduce((a, b) => a + b) /
        student.scores.length)
        .round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'StudyPro',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Container(
            padding: EdgeInsets.all(23),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [dark, primary],
              ),
              borderRadius: BorderRadius.circular(26),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, ${student.name.split(' ').first}! 👋',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  '${student.course} • ${student.semester}',
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 15),
                Wrap(
                  spacing: 7,
                  runSpacing: 7,
                  children: [
                    tag('ID ${student.id}'),
                    tag('Division ${student.division}'),
                    tag('${student.subjects.length} Subjects'),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 18),
          Text(
            'Your Progress',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 9),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisSpacing: 9,
            mainAxisSpacing: 9,
            childAspectRatio: 1.55,
            children: [
              Stat(
                'Study Time',
                '${student.minutes} min',
                Icons.schedule,
              ),
              Stat(
                'Quiz Average',
                '$average%',
                Icons.quiz,
              ),
              Stat(
                'Subjects',
                '${student.subjects.length}',
                Icons.menu_book,
              ),
              Stat(
                'Tasks',
                '${student.tasks.length}',
                Icons.task_alt,
              ),
            ],
          ),
          SizedBox(height: 18),
          Text(
            'Quick Access',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 8),
          ActionTile(
            'Focus Session',
            'Start focused study',
            Icons.timer,
                () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FocusPage(student: student),
              ),
            ),
          ),
          ActionTile(
            'Tasks',
            'Manage academic tasks',
            Icons.task_alt,
                () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Tasks(student: student),
              ),
            ),
          ),
          ActionTile(
            'Notes',
            'Save study notes',
            Icons.note_alt,
                () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Notes(student: student),
              ),
            ),
          ),
          ActionTile(
            'Aptitude Test',
            'Practice logical reasoning',
            Icons.psychology,
                () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Quiz(
                  student: student,
                  title: 'Aptitude',
                  questions: aptitude,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 11,
        ),
      ),
    );
  }
}

class Stat extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  Stat(
      this.title,
      this.value,
      this.icon, {
        super.key,
      });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: primary,
            ),
            Spacer(),
            Text(
              value,
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  ActionTile(
      this.title,
      this.subtitle,
      this.icon,
      this.onTap, {
        super.key,
      });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: primary.withAlpha(30),
          child: Icon(
            icon,
            color: primary,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
}

class SubjectsPage extends StatelessWidget {
  final Student student;

  SubjectsPage({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Subjects'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Container(
            padding: EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [dark, primary],
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ACADEMIC HUB',
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  '${student.subjects.length} Subjects',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 14),
          if (student.subjects.isEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Text('No subjects added.'),
              ),
            ),
          ...List.generate(
            student.subjects.length,
                (index) {
              final subject = student.subjects[index];

              return ActionTile(
                subject,
                'Study, focus and test',
                Icons.menu_book,
                    () {
                  final questions = builtInQuizzes[subject];

                  if (questions == null) {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(subject),
                        content: Text(
                          'A quiz has not been added for this custom subject yet.\n\n'
                              'You can still use the Focus Timer and timetable for this subject.',
                        ),
                        actions: [
                          FilledButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Quiz(
                          student: student,
                          title: subject,
                          questions: questions,
                        ),
                      ),
                    );
                  }
                },
              );
            },
          ),
          ActionTile(
            'Aptitude & Logical Reasoning',
            '${aptitude.length} questions',
            Icons.psychology,
                () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Quiz(
                  student: student,
                  title: 'Aptitude',
                  questions: aptitude,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Quiz extends StatefulWidget {
  final Student student;
  final String title;
  final List<Map<String, dynamic>> questions;

  Quiz({
    super.key,
    required this.student,
    required this.title,
    required this.questions,
  });

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int index = 0;
  int score = 0;
  int? selected;

  void next() {
    if (selected == null) return;

    final newScore =
        score + (selected == widget.questions[index]['a'] ? 1 : 0);

    if (index == widget.questions.length - 1) {
      final percentage =
      (newScore * 100 / widget.questions.length).round();

      widget.student.scores[widget.title] = percentage;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: Text('Test Completed 🎉'),
          content: Text(
            'Score: $newScore/${widget.questions.length}\n'
                'Percentage: $percentage%',
          ),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text('DONE'),
            ),
          ],
        ),
      );
    } else {
      setState(() {
        score = newScore;
        index++;
        selected = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[index];
    final options = List<String>.from(question['o']);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: (index + 1) / widget.questions.length,
              minHeight: 7,
              borderRadius: BorderRadius.circular(8),
            ),
            SizedBox(height: 18),
            Text(
              'Question ${index + 1} of ${widget.questions.length}',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8),
            Text(
              question['q'],
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 13),
            ...List.generate(
              options.length,
                  (optionIndex) => Card(
                child: RadioListTile<int>(
                  value: optionIndex,
                  groupValue: selected,
                  activeColor: primary,
                  title: Text(options[optionIndex]),
                  onChanged: (value) {
                    setState(() => selected = value);
                  },
                ),
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton(
                onPressed: selected == null ? null : next,
                child: Text(
                  index == widget.questions.length - 1
                      ? 'SUBMIT TEST'
                      : 'NEXT QUESTION',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FocusPage extends StatefulWidget {
  final Student student;

  FocusPage({
    super.key,
    required this.student,
  });

  @override
  State<FocusPage> createState() => _FocusPageState();
}

class _FocusPageState extends State<FocusPage> {
  Timer? timer;

  int duration = 25;
  int seconds = 1500;

  bool running = false;

  String? subject;

  @override
  void initState() {
    super.initState();

    if (widget.student.subjects.isNotEmpty) {
      subject = widget.student.subjects.first;
    }
  }

  void start() {
    if (subject == null) return;

    timer?.cancel();

    if (seconds <= 0) {
      seconds = duration * 60;
    }

    setState(() => running = true);

    timer = Timer.periodic(
      Duration(seconds: 1),
          (t) {
        if (seconds <= 1) {
          t.cancel();

          setState(() {
            seconds = 0;
            running = false;
          });

          widget.student.minutes += duration;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Focus session completed! 🎉'),
            ),
          );
        } else {
          setState(() => seconds--);
        }
      },
    );
  }

  void reset() {
    timer?.cancel();

    setState(() {
      running = false;
      seconds = duration * 60;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutesText =
    (seconds ~/ 60).toString().padLeft(2, '0');

    final secondsText =
    (seconds % 60).toString().padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(
        title: Text('Focus Timer'),
      ),
      body: ListView(
        padding: EdgeInsets.all(17),
        children: [
          Container(
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [dark, primary],
              ),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              children: [
                Text(
                  'FOCUS SESSION',
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '$minutesText:$secondsText',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 62,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  subject ?? 'Select a subject',
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          if (widget.student.subjects.isEmpty)
            Card(
              child: Padding(
                padding: EdgeInsets.all(18),
                child: Text(
                  'Please add a subject from your profile first.',
                ),
              ),
            )
          else
            DropdownButtonFormField<String>(
              initialValue: subject,
              decoration: InputDecoration(
                labelText: 'Subject',
                prefixIcon: Icon(Icons.menu_book),
              ),
              items: widget.student.subjects
                  .map(
                    (value) => DropdownMenuItem(
                  value: value,
                  child: Text(value),
                ),
              )
                  .toList(),
              onChanged: running
                  ? null
                  : (value) {
                setState(() => subject = value);
              },
            ),
          SizedBox(height: 11),
          DropdownButtonFormField<int>(
            initialValue: duration,
            decoration: InputDecoration(
              labelText: 'Duration',
              prefixIcon: Icon(Icons.timelapse),
            ),
            items: [15, 25, 45, 60, 90]
                .map(
                  (value) => DropdownMenuItem(
                value: value,
                child: Text('$value minutes'),
              ),
            )
                .toList(),
            onChanged: running
                ? null
                : (value) {
              setState(() {
                duration = value!;
                seconds = duration * 60;
              });
            },
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: running
                      ? () {
                    timer?.cancel();
                    setState(() => running = false);
                  }
                      : start,
                  icon: Icon(
                    running ? Icons.pause : Icons.play_arrow,
                  ),
                  label: Text(
                    running ? 'PAUSE' : 'START',
                  ),
                ),
              ),
              SizedBox(width: 10),
              OutlinedButton.icon(
                onPressed: reset,
                icon: Icon(Icons.restart_alt),
                label: Text('RESET'),
              ),
            ],
          ),
          SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: Icon(
                Icons.lightbulb,
                color: accent,
              ),
              title: Text(
                'Focus Tip',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Keep distractions away and focus on one subject at a time.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SchedulePage extends StatefulWidget {
  final Student student;

  SchedulePage({
    super.key,
    required this.student,
  });

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  late String time;

  final days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  @override
  void initState() {
    super.initState();
    time = widget.student.studyTime;
  }

  @override
  Widget build(BuildContext context) {
    final subjects = widget.student.subjects;

    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Timetable'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Study Preference',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    initialValue: time,
                    decoration: InputDecoration(
                      labelText: 'Preferred Study Time',
                      prefixIcon: Icon(Icons.schedule),
                    ),
                    items: [
                      '7:00 AM - 9:00 AM',
                      '2:00 PM - 4:00 PM',
                      '5:00 PM - 7:00 PM',
                      '8:00 PM - 10:00 PM',
                    ]
                        .map(
                          (value) => DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      ),
                    )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        time = value!;
                        widget.student.studyTime = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          Text(
            'Weekly Schedule',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 7),
          if (subjects.isEmpty)
            Card(
              child: Padding(
                padding: EdgeInsets.all(18),
                child: Text(
                  'Add subjects to your profile to create your timetable.',
                ),
              ),
            ),
          ...List.generate(
            subjects.length,
                (index) => Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: Text('${index + 1}'),
                ),
                title: Text(
                  subjects[index],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  '${days[index % days.length]} • $time',
                ),
                trailing: Icon(
                  Icons.menu_book,
                  color: primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Tasks extends StatefulWidget {
  final Student student;

  Tasks({
    super.key,
    required this.student,
  });

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  final controller = TextEditingController();

  void addTask() {
    final text = controller.text.trim();

    if (text.isEmpty) return;

    setState(() {
      widget.student.tasks.add(text);
      controller.clear();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Tasks'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Add Task'),
              content: TextField(
                controller: controller,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Enter academic task',
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('CANCEL'),
                ),
                FilledButton(
                  onPressed: () {
                    addTask();
                    Navigator.pop(context);
                  },
                  child: Text('ADD'),
                ),
              ],
            ),
          );
        },
        icon: Icon(Icons.add),
        label: Text('TASK'),
      ),
      body: widget.student.tasks.isEmpty
          ? Center(
        child: Text(
          'No tasks yet. Add your first task!',
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(14),
        itemCount: widget.student.tasks.length,
        itemBuilder: (_, index) {
          final task = widget.student.tasks[index];
          final completed =
          widget.student.done.contains(task);

          return Card(
            child: CheckboxListTile(
              value: completed,
              title: Text(
                task,
                style: TextStyle(
                  decoration: completed
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    widget.student.done.add(task);
                  } else {
                    widget.student.done.remove(task);
                  }
                });
              },
              secondary: IconButton(
                icon: Icon(Icons.delete_outline),
                onPressed: () {
                  setState(() {
                    widget.student.tasks.removeAt(index);
                    widget.student.done.remove(task);
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class Notes extends StatefulWidget {
  final Student student;

  Notes({
    super.key,
    required this.student,
  });

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final controller = TextEditingController();

  void addNote() {
    final text = controller.text.trim();

    if (text.isEmpty) return;

    setState(() {
      widget.student.notes.add(text);
      controller.clear();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Notes'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('New Note'),
              content: TextField(
                controller: controller,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Write your note...',
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('CANCEL'),
                ),
                FilledButton(
                  onPressed: () {
                    addNote();
                    Navigator.pop(context);
                  },
                  child: Text('SAVE'),
                ),
              ],
            ),
          );
        },
        icon: Icon(Icons.add),
        label: Text('NOTE'),
      ),
      body: widget.student.notes.isEmpty
          ? Center(
        child: Text('No notes yet.'),
      )
          : ListView.builder(
        padding: EdgeInsets.all(14),
        itemCount: widget.student.notes.length,
        itemBuilder: (_, index) {
          return Card(
            child: ListTile(
              leading: Icon(
                Icons.note_alt,
                color: primary,
              ),
              title: Text(widget.student.notes[index]),
              trailing: IconButton(
                icon: Icon(Icons.delete_outline),
                onPressed: () {
                  setState(() {
                    widget.student.notes.removeAt(index);
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class Profile extends StatelessWidget {
  final Student student;
  final bool darkMode;
  final VoidCallback toggleDark;
  final VoidCallback logout;

  Profile({
    super.key,
    required this.student,
    required this.darkMode,
    required this.toggleDark,
    required this.logout,
  });

  Widget info(
      String title,
      String value,
      IconData icon,
      ) {
    return Card(
      child: ListTile(
        leading: Icon(
          icon,
          color: primary,
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 12),
        ),
        subtitle: Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: ListView(
        padding: EdgeInsets.all(17),
        children: [
          Center(
            child: CircleAvatar(
              radius: 45,
              backgroundColor: primary,
              child: Text(
                student.name[0].toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          SizedBox(height: 9),
          Center(
            child: Text(
              student.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Center(
            child: Text(
              '${student.course} • ${student.semester}',
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: FilledButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProfile(
                      student: student,
                    ),
                  ),
                );
              },
              icon: Icon(Icons.edit),
              label: Text('EDIT PROFILE'),
            ),
          ),
          SizedBox(height: 12),
          info(
            'Student ID',
            student.id,
            Icons.badge,
          ),
          info(
            'Email',
            student.email,
            Icons.email,
          ),
          info(
            'Mobile Number',
            student.phone,
            Icons.phone,
          ),
          info(
            'Course',
            student.course,
            Icons.school,
          ),
          info(
            'Semester',
            student.semester,
            Icons.menu_book,
          ),
          info(
            'Division',
            student.division,
            Icons.class_,
          ),
          info(
            'Roll Number',
            student.roll,
            Icons.numbers,
          ),
          info(
            'Preferred Study Time',
            student.studyTime,
            Icons.schedule,
          ),
          Card(
            child: ExpansionTile(
              leading: Icon(
                Icons.menu_book,
                color: primary,
              ),
              title: Text(
                'My Subjects',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '${student.subjects.length} subjects',
              ),
              children: student.subjects
                  .map(
                    (subject) => ListTile(
                  leading: Icon(
                    Icons.circle,
                    size: 9,
                  ),
                  title: Text(subject),
                ),
              )
                  .toList(),
            ),
          ),
          Card(
            child: SwitchListTile(
              value: darkMode,
              onChanged: (_) => toggleDark(),
              title: Text('Dark Mode'),
              subtitle: Text(
                'Change app appearance',
              ),
              secondary: Icon(Icons.dark_mode),
            ),
          ),
          SizedBox(height: 8),
          FilledButton.icon(
            onPressed: logout,
            icon: Icon(Icons.logout),
            label: Text('LOG OUT'),
          ),
        ],
      ),
    );
  }
}

class EditProfile extends StatefulWidget {
  final Student student;

  EditProfile({
    super.key,
    required this.student,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final form = GlobalKey<FormState>();

  late final TextEditingController name;
  late final TextEditingController email;
  late final TextEditingController phone;
  late final TextEditingController course;
  late final TextEditingController roll;
  late final TextEditingController subject;

  late String semester;
  late String division;
  late String studyTime;

  late List<String> subjects;

  @override
  void initState() {
    super.initState();

    name = TextEditingController(
      text: widget.student.name,
    );

    email = TextEditingController(
      text: widget.student.email,
    );

    phone = TextEditingController(
      text: widget.student.phone,
    );

    course = TextEditingController(
      text: widget.student.course,
    );

    roll = TextEditingController(
      text: widget.student.roll,
    );

    subject = TextEditingController();

    semester = widget.student.semester;
    division = widget.student.division;
    studyTime = widget.student.studyTime;
    subjects = List.from(widget.student.subjects);
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    course.dispose();
    roll.dispose();
    subject.dispose();
    super.dispose();
  }

  Widget field(
      String label,
      TextEditingController controller,
      IconData icon, {
        String? Function(String?)? validator,
        TextInputType? keyboard,
        List<TextInputFormatter>? formatters,
      }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 11),
      child: TextFormField(
        controller: controller,
        validator: validator ?? requiredValidator,
        keyboardType: keyboard,
        inputFormatters: formatters,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }

  void addSubject() {
    final value = subject.text.trim();

    if (value.isEmpty) return;

    if (subjects.any(
          (x) => x.toLowerCase() == value.toLowerCase(),
    )) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('This subject is already added.'),
        ),
      );
      return;
    }

    setState(() {
      subjects.add(value);
      subject.clear();
    });
  }

  void save() {
    if (!form.currentState!.validate()) return;

    if (subjects.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please keep at least one subject.'),
        ),
      );
      return;
    }

    widget.student.name = name.text.trim();
    widget.student.email = email.text.trim();
    widget.student.phone = phone.text.trim();
    widget.student.course = course.text.trim();
    widget.student.roll = roll.text.trim();
    widget.student.semester = semester;
    widget.student.division = division;
    widget.student.studyTime = studyTime;
    widget.student.subjects = List.from(subjects);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile updated successfully!'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(18),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 750,
            ),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(22),
                child: Form(
                  key: form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Edit Your Profile',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Update your personal, academic and subject information.',
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        initialValue: widget.student.id,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Student ID',
                          prefixIcon: Icon(Icons.badge),
                        ),
                      ),
                      SizedBox(height: 11),
                      field(
                        'Full Name',
                        name,
                        Icons.person,
                      ),
                      field(
                        'Email',
                        email,
                        Icons.email,
                        validator: emailValidator,
                        keyboard: TextInputType.emailAddress,
                      ),
                      field(
                        'Mobile Number',
                        phone,
                        Icons.phone,
                        validator: phoneValidator,
                        keyboard: TextInputType.phone,
                        formatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                      ),
                      field(
                        'Course',
                        course,
                        Icons.school,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: semester,
                              decoration: InputDecoration(
                                labelText: 'Semester',
                              ),
                              items: List.generate(
                                8,
                                    (i) => DropdownMenuItem(
                                  value: 'Semester ${i + 1}',
                                  child: Text('Semester ${i + 1}'),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() => semester = value!);
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: division,
                              decoration: InputDecoration(
                                labelText: 'Division',
                              ),
                              items: ['A', 'B', 'C', 'D']
                                  .map(
                                    (value) => DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                ),
                              )
                                  .toList(),
                              onChanged: (value) {
                                setState(() => division = value!);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 11),
                      field(
                        'Roll Number',
                        roll,
                        Icons.numbers,
                      ),
                      DropdownButtonFormField<String>(
                        initialValue: studyTime,
                        decoration: InputDecoration(
                          labelText: 'Preferred Study Time',
                          prefixIcon: Icon(Icons.schedule),
                        ),
                        items: [
                          '7:00 AM - 9:00 AM',
                          '2:00 PM - 4:00 PM',
                          '5:00 PM - 7:00 PM',
                          '8:00 PM - 10:00 PM',
                        ]
                            .map(
                              (value) => DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          ),
                        )
                            .toList(),
                        onChanged: (value) {
                          setState(() => studyTime = value!);
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        'My Subjects',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Add or remove subjects for your current semester.',
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: subject,
                              onSubmitted: (_) => addSubject(),
                              decoration: InputDecoration(
                                labelText: 'Enter Subject',
                                prefixIcon: Icon(Icons.menu_book),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          FilledButton(
                            onPressed: addSubject,
                            child: Icon(Icons.add),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      ...List.generate(
                        subjects.length,
                            (index) => Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text('${index + 1}'),
                            ),
                            title: Text(
                              subjects[index],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete_outline,
                              ),
                              onPressed: () {
                                setState(() {
                                  subjects.removeAt(index);
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: FilledButton.icon(
                          onPressed: save,
                          icon: Icon(Icons.save),
                          label: Text('SAVE CHANGES'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}