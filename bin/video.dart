import 'dart:io';


void main() {
  print("Введите число: ");
  // final line = stdin.readLineSync() ?? "";
  // final num = int.tryParse(line);
  var num = int.parse(stdin.readLineSync()!);
  switch (num) {
    case 6: 
    print("Угадал");
    break;
    case 3: 
      print("слишком мало");
      break;
      default:
      print("хз хз");
  }

}
