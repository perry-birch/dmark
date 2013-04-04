# Welcome to the first edition of the Dmark: Getting Started doc.

----

Feedback and suggestions are always welcome & appreciated.

Benchmarks can (currently) be run as either a 'Suite' or 'Runner'.

Suite is a batch of benchmarks which share a common configuration. *may consider renaming to Group...

Runner is a single benchmark.

A runner is created inside each Suite to facilitate execution of the benchmark

----


>First, you'll want to describe the settings for the benchmark:

    var settings = RunSettings.byIterations(int numberOfRuns, int numberOfWarmups);

>or

    var settings = RunSettings.byDuration(Durtion timeToRun, Duration timeToWarmup);

>Then you could create a runner:

    var runner = Runner.using(settings);

>All set, now you can just use any Action and run it!

    var myBenchmark = () { doCoolStuff(); };

    var runResults = runner.exec('myBenchmark', myBenchmark);

>With results in hand you can use the Writer to write them out to the console: (You'll probably want to customize the Writer, it's still pretty basic)

    Writer.writeSingle(runResults);

>If you want to run several tests and collect their results together then you'll want to use a suite:

    var mySecondBenchmark = () { doBoringStuff(); };

    var myThirdBenchmark = () { doPointlessStuff(); };

    var suite = Suite.using('suiteName', settings, 
        benchmarks: { 
            'myFirstBenchmark': myBenchmark, 
            'mySecondBenchmark': mySecondBenchmark, 
            'myThirdBenchmark': myThirdBenchmark 
        });

    var suiteResults = suite.exec();

>Writing the result from a suite is easy:

    for(var i = 0; i < suiteResults.length; i++) { 
        Writer.writeSingle(results.elementAt(i)); 
    }


----
## Edited
* 04-April-2013 initial release

----
## Credits
* [Vizidrix](https://github.com/organizations/Vizidrix)
* [Perry Birch](https://github.com/PerryBirch)

