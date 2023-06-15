import 'dart:convert';
import 'package:eindopdracht_b/screens/add_page.dart';
import 'package:eindopdracht_b/util/emoticons.dart';
import 'package:eindopdracht_b/util/exercises.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  bool isLoading = true;
  List items = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  //App Opmaak algemeen
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[200],
        title: Center(
          child: Text(
            'Moodyboard',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: _getPage(_selectedIndex),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage,
        label: Text('Add todo'),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.green[300],
          primaryColor: Colors.white,
          textTheme: Theme.of(context).textTheme.copyWith(
                caption: TextStyle(
                    color: Colors
                        .white70
                ),
              ),
            ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: 'Todo',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Happy',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'About',
            ),
          ],
        ),
      ),
    );
  }

  //Pagina indelng
  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return _buildHomePage();
      case 1:
        return _buildTodoPage();
      case 2:
        return _buildMotivationPage();
      case 3:
        return _buildAboutPage();
      default:
        return Container();
    }
  }

  //home_page + exercises_page + emoticons_page
  Widget _buildHomePage() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd MMMM yyyy').format(now);

    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Hi, Jasmin!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      formattedDate,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[600],
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.blue,
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Search',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 25),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'How are you feeling today?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                ),
                SizedBox(height: 25),
                ///4 different moods
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //bad
                    Column(
                      children: [
                        Emoticons(
                          emoticons: '😄',
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Well',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    //fine
                    Column(
                      children: [
                        Emoticons(
                          emoticons: '🙂',
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Fine',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    //well
                    Column(
                      children: [
                        Emoticons(
                          emoticons: '😩',
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Bad',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    //excellent
                    Column(
                      children: [
                        Emoticons(
                          emoticons: '😁',
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'excellent',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(25),
              color: Colors.grey[100],
              child: Center(
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Exercises',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.more_horiz,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            Exercises(
                              icon: Icons.favorite,
                              exerciseName: 'Communication Skills',
                              numberOfExercises: 10,
                            ),
                            Exercises(
                              icon: Icons.person,
                              exerciseName: 'Notes',
                              numberOfExercises: 10,
                            ),
                            Exercises(
                              icon: Icons.battery_0_bar,
                              exerciseName: 'Relaxing',
                              numberOfExercises: 10,
                            ),
                            Exercises(
                              icon: Icons.star,
                              exerciseName: 'Self Image',
                              numberOfExercises: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //todo_page + add_page API
  Widget _buildTodoPage() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Todo',
            style: TextStyle(
              color: Colors.lightBlue,
            ),
          ),
        ),
      ),
      body: Visibility(
        visible: isLoading,
        child: Center(child: CircularProgressIndicator()),
        replacement: RefreshIndicator(
          onRefresh: fetchTodo,
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: Center(
              child: Text(
                'No todo items',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            child: ListView.builder(
              itemCount: items.length,
              padding: EdgeInsets.all(12),
              itemBuilder: (context, index) {
                final item = items[index] as Map;
                final id = item['_id'] as String;
                final avatarColor = _getAvatarColor(index); // Nieuwe regel

                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                      backgroundColor: avatarColor, // Nieuwe regel
                    ),
                    title: Text(item['title']),
                    subtitle: Text(item['description']),
                    trailing: PopupMenuButton(
                      onSelected: (value) {
                        if (value == 'edit') {
                          navigateToEditPage(item);
                        } else if (value == 'delete') {
                          deleteById(id);
                        }
                      },
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            child: Text('Edit'),
                            value: 'edit',
                          ),
                          PopupMenuItem(
                            child: Text('Delete'),
                            value: 'delete',
                          ),
                        ];
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

 //styling number colors todo_page
  Color _getAvatarColor(int index) {
    // Pas de kleuren hier aan of voeg meer kleuren toe indien nodig
    List<Color> colors = [
      Colors.blue,
      Colors.lightGreenAccent,
      Colors.orangeAccent,
      Colors.yellow,
      Colors.lightBlueAccent,
    ];

    // Zorg ervoor dat de index binnen het bereik van de kleurenlijst blijft
    final colorIndex = index % colors.length;

    return colors[colorIndex];
  }

  //motivation_page
  Widget _buildMotivationPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.blue[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'You are capable of amazing things!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.orange[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Believe in yourself and all that you are.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.green[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Your hard work will pay off!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.purple[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Dream big and dare to fail.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.red[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'The only way to do great work is to love what you do.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.yellow[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Success is not final, failure is not fatal: It is the courage to continue that counts.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  //licences_page
  Widget _buildAboutPage() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => aboutMyApp(context),
              child: Text(
                'View Licenses',
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.pink[200],
                padding: EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20), // Afmetingen van de knop aanpassen
              ),
            ),
          ],
        ),
      ),
    );
  }

  //navigate
  Future<void> navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(todo: item),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    await fetchTodo();
  }
  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    await fetchTodo();
  }

  //deletebutton
  Future<void> deleteById(String id) async {
    final url = 'http://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      final filtered = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filtered;
      });
    } else {
      showErrorMessage('Deleting failed');
    }
  }

  //fetch API data
  Future<void> fetchTodo() async {
    try {
      final url = 'http://api.nstack.in/v1/todos?page=1&limit=10';
      final uri = Uri.parse(url);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map;
        final result = json['items'] as List;
        setState(() {
          items = result;
        });
      } else {
        showErrorMessage('Failed to fetch todos');
      }
    } catch (error) {
      showErrorMessage('An error occurred');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  //licences
  Future<void> aboutMyApp(BuildContext context) async {
    // Voeg de context parameter toe
    showAboutDialog(
      context: context,
      applicationIcon: FlutterLogo(),
      applicationName: 'About page App',
      applicationVersion: '0.0.1',
      applicationLegalese: 'DEVELOPED BY JAZZIE',
      children: <Widget>[
        SizedBox(height: 20),
        Text(
          'The app development process involved meticulous planning, design, coding, and testing. Appropriate licenses were selected, including open-source, commercial, and proprietary licenses, and license agreements were drafted to ensure legal compliance and protect intellectual property.',
        ),
      ],
    );
  }

  //errorMessage
  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
