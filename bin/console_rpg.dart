import "dart:io";
import "dart:convert";

// === ФУНКЦИИ ===

// Показать статистику
void showStats(int exp, int level, int gold, int expNeeded) {
  print("\n📊 СТАТИСТИКА:");
  print("Опыт: $exp/$expNeeded");
  print("Уровень: $level");
  print("Золото: $gold");
}

// Проверка повышения уровня
Map<String, int> checkLevelUp(int exp, int level, int gold, int expNeeded) {
  while (exp >= expNeeded) {
    level++;
    exp = exp - expNeeded;
    
    // Награда золотом (50-100 случайно или фиксированно)
    int goldReward = 50 + (level * 10); // Каждый уровень дает больше золота
    gold += goldReward;
    
    // Увеличиваем требуемый опыт для следующего уровня
    expNeeded = 100 + (level * level * 25);
    
    print("\n🎊 ПОЗДРАВЛЯЕМ! Вы достигли $level уровня!");
    print("💰 Получено золота: +$goldReward (всего: $gold)");
    print("📈 Для следующего уровня нужно: $expNeeded опыта");
  }
  
  return {
    "exp": exp, 
    "level": level, 
    "gold": gold,
    "expNeeded": expNeeded
  };
}

// Валидация ввода числа
int getValidNumber(String prompt) {
  int number = 0;
  bool valid = false;
  
  while (!valid) {
    stdout.write(prompt);
    String input = stdin.readLineSync(encoding: utf8)!.trim();
    
    if (int.tryParse(input) != null) {
      number = int.parse(input);
      if (number > 0) {
        valid = true;
      } else {
        print("❌ Число должно быть больше 0!");
      }
    } else {
      print("❌ Только цифры! Вы ввели: '$input'");
    }
  }
  
  return number;
}

// Валидация ввода текста
String getValidText(String prompt, int minLength) {
  String text = "";
  bool valid = false;
  
  while (!valid) {
    stdout.write(prompt);
    text = stdin.readLineSync(encoding: utf8)!.trim();
    
    if (text.isEmpty) {
      print("❌ Текст не может быть пустым!");
    } else if (text.length < minLength) {
      print("❌ Слишком короткий текст! Минимум $minLength символа.");
    } else {
      valid = true;
    }
  }
  
  return text;
}

// === ГЛАВНАЯ ФУНКЦИЯ ===
void main() {
  stdout.encoding = utf8;
  
  int exp = 0;
  int gold = 100;
  int level = 1;
  int expNeeded = 100; // Опыт нужный для следующего уровня
  
  print("⚡️Добро пожаловать в Life-Tracker⚡️");
  stdout.write('Назови своего персонажа: ');
  String salam = stdin.readLineSync(encoding: utf8)!.trim();
  
  print('Отлично, приятно познакомиться $salam, пора приступать к улучшению вашей жизни!\n');
  
  showStats(exp, level, gold, expNeeded);
  
  print("\nНе желаете ли приобрести начальный пакет для быстрого результата?");
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
  
  String task1 = getValidText("\n\nПора приступать!\nЧто сегодня хотите сделать? Напишите свою задачу: ", 3);
  
  print("\nВы хотите сделать: $task1");
  print("Ваше задание оценивается как: Сложное👹");
  
  int expReward = getValidNumber("\nСколько опыта вы бы хотели за него получить? (напишите цифрами): ");
  
  print("\n$expReward опыта, отлично!");
  
  // Добавляем опыт к персонажу
  exp += expReward;
  print("\n🎉 Теперь у вас $exp опыта!");
  
  // Проверяем уровень
  Map<String, int> result = checkLevelUp(exp, level, gold, expNeeded);
  exp = result["exp"]!;
  level = result["level"]!;
  gold = result["gold"]!;
  expNeeded = result["expNeeded"]!;
  
  showStats(exp, level, gold, expNeeded);
}