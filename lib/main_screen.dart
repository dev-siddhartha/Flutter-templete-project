import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/core/cubits/theme_cubit/theme_cubit.dart';
import 'package:flutter_template/core/utils/app_imports.dart';
import 'package:flutter_template/core/utils/global_bloc_provider.dart';
import 'package:flutter_template/core/utils/theme/global_theme.dart';
import 'package:flutter_template/core/widgets/theme_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.environment});

  final String environment;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: MediaQuery.of(context).size,
      minTextAdapt: true,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: GlobalBlocProvider().globalBlocProviders,
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, theme) {
              return AnimatedTheme(
                data: theme == ThemeMode.light
                    ? GlobalTheme.lightThemeData
                    : GlobalTheme.darkThemeData,
                duration: const Duration(milliseconds: 500),
                child: MaterialApp(
                  title: 'Siddhartha',
                  theme: GlobalTheme.lightThemeData,
                  darkTheme: GlobalTheme.darkThemeData,
                  themeMode: theme,
                  home: MyHomePage(title: environment),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextWidget(
              widget.title,
            ),
            TextWidget(
              '$_counter',
            ),
            const ThemeWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
