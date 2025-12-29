import "dart:io";
import "dart:convert";  

void main() {
  
  stdout.encoding = utf8;
  
  int exp = 0;
  int gold = 100; 
  int level = 1;

  stdout.write('Салам алейкум!! Назови своего персонажа: ');
  
 
  String salam = stdin.readLineSync(encoding: utf8)!.trim(); 
  
  print('Отлично, приятно познакомиться $salam!\n');
  
  print("📊 ВАША СТАТИСТИКА:");
  print("Опыт: $exp/100");
  print("Золото: $gold");
  print("Уровень: $level\n");
  
  print("Не желаете ли приобрести начальный пакет для быстрого результата?");
  stdout.write("(да/нет): ");
  

  String answer = stdin.readLineSync(encoding: utf8)!.trim().toLowerCase();
  
  
  if (answer == "да") {
    print("\n✅ Вы выбрали: ДА");
    stdout.write("Отлично, выберите способ оплаты (сбп/карта): ");
    
    String payment = stdin.readLineSync(encoding: utf8)!.trim();
    stdout.write("Вы выбрали оплату через $payment. Перейдите пожалуйста по ссылке для оплаты в телеграм t.me/whocaresbratec");
  } else if (answer == "нет") {
    print("\n❌ Вы выбрали: НЕТ");
    stdout.write("\nПочему нет? Напишите об этом пожалуйста: ");
    String explanation = stdin.readLineSync(encoding: utf8)!.trim();
    stdout.write("\nВаш ответ: $explanation");
    print("\nСпасибо за обратную связь, хорошей игры!");
    
  } else {
    print("\n🤔 Непонятный ответ: '$answer'");
    print("\nИгра продолжается в обычном режиме...");
  }
}
