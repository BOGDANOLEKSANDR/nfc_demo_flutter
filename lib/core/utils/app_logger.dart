import 'package:logger/logger.dart';

Logger getLogger() => Logger(printer: AppLogPrinter(errorMethodCount: 7, methodCount: 0));

class AppLogPrinter extends LogPrinter {
  static final levelColors = {
    Level.verbose: AnsiColor.fg(AnsiColor.grey(0.5)),
    Level.debug: AnsiColor.none(),
    Level.info: AnsiColor.fg(12),
    Level.warning: AnsiColor.fg(208),
    Level.error: AnsiColor.fg(196),
    Level.wtf: AnsiColor.fg(199),
  };

  final int methodCount;
  final int errorMethodCount;

  AppLogPrinter({
    this.methodCount = 2,
    this.errorMethodCount = 8,
  });

  @override
  List<String> log(LogEvent event) {
    var messageStr = PrettyPrinter().stringifyMessage(event.message);

    String? stackTraceStr;
    if (event.stackTrace == null) {
      if (event.level == Level.error && errorMethodCount > 0) {
        stackTraceStr = PrettyPrinter().formatStackTrace(StackTrace.current, errorMethodCount);
      } else if (methodCount > 0) {
        stackTraceStr = PrettyPrinter().formatStackTrace(StackTrace.current, methodCount);
      }
    } else if (errorMethodCount > 0) {
      stackTraceStr = PrettyPrinter().formatStackTrace(event.stackTrace, errorMethodCount);
    }

    var errorStr = event.error?.toString();

    return _formatAndPrint(
      event.level,
      messageStr,
      errorStr,
      stackTraceStr,
    );
  }

  AnsiColor _getErrorColor(Level level) {
    if (level == Level.wtf) {
      return levelColors[Level.wtf]!.toBg();
    } else {
      return levelColors[Level.error]!.toBg();
    }
  }

  List<String> _formatAndPrint(
    Level level,
    String message,
    String? error,
    String? stacktrace,
  ) {
    List<String> buffer = [];
    var color = levelColors[level]!;

    if (error != null) {
      var errorColor = _getErrorColor(level);
      for (var line in error.split('\n')) {
        buffer.add(
          errorColor.resetForeground + errorColor(line) + errorColor.resetBackground,
        );
      }
    }

    for (var line in message.split('\n')) {
      buffer.add(color(line));
    }
    if (stacktrace != null) {
      for (var line in stacktrace.split('\n')) {
        buffer.add(color(line));
      }
    }
    buffer.add('\n');

    return buffer;
  }
}
