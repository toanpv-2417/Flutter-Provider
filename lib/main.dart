import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => CounterProvider(),
    child: const MyApp(),
  ));
}

class CounterProvider extends ChangeNotifier {
  int _counter = 30;

  int get counter => _counter;

  void add() {
    _counter++;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ScreenOne(),
    );
  }
}

class ScreenOne extends StatelessWidget {
  const ScreenOne({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              context.watch<CounterProvider>().counter.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ScreenSecond()));
                },
                child: const Text('go to screen two'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CounterProvider>().add();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ScreenSecond extends StatelessWidget {
  const ScreenSecond({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CounterProvider>(builder: (context, myData, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Screen22'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '${myData.counter}',
                style: Theme.of(context).textTheme.headline4,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('go back'))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            myData.add();
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
