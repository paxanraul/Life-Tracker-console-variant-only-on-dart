import "dart:io";
import "dart:convert";  

void main() {
  
  stdout.encoding = utf8;
  
  int exp = 0;
  int gold = 100; 
  int level = 1;
  print("⚡️Добро пожаловать в Life-Tracker⚡️");
  stdout.write('Назови своего персонажа: ');
  
 
  String salam = stdin.readLineSync(encoding: utf8)!.trim(); 
  
  print('Отлично, приятно познакомиться $salam, пора приступать к улучшению вашей жизни!\n');
  
  print("📊 ВАША СТАТИСТИКА:");
  print("Опыт: $exp/100");
  print("Уровень: $level");
  print("Золото: $gold\n");
  
  print("Не желаете ли приобрести начальный пакет для быстрого результата?");
  stdout.write("(да/нет): ");
  

  String answer = stdin.readLineSync(encoding: utf8)!.trim().toLowerCase();
  
  
  if (answer == "да") {
    print("\n✅ Вы выбрали: ДА");
    stdout.write("Отлично! Перейдите пожалуйста по ссылке для оплаты в телеграм t.me/whocaresbratec");
    stdout.write("Спасибо за оплату!");
  } else if (answer == "нет") {
    print("\n❌ Вы выбрали: НЕТ");
    stdout.write("\nПочему нет? Напишите об этом пожалуйста: ");
    String explanation = stdin.readLineSync(encoding: utf8)!.trim();
    stdout.write("\nВаш ответ: $explanation");
    print("\nСпасибо за обратную связь!");
    
  } else {
    print("\n😵 Непонятный ответ: '$answer', попробуйте еще раз.");
  }
  stdout.write("\nЖелаем вам успехов!");
}
