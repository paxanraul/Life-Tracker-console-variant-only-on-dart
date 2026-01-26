import "dart:io";
import "dart:convert";

// === ФУНКЦИИ ===

// Показать статистику
void showStats(int exp, int level, int gold, int expNeeded) {
  print("\n📊 ВАША СТАТИСТИКА:");
  print("Опыт: $exp/$expNeeded");
  print("Уровень: $level");
  print("Золото: $gold");
  
  int expLeft = expNeeded - exp;
  if (expLeft > 0) {
    print("До следующего уровня нужно: $expLeft опыта");
  }
}

// Проверка повышения уровня 
Map<String, int> checkLevelUp(int exp, int level, int gold, int expNeeded) {
  while (exp >= expNeeded) {
    level++;
    exp = exp - expNeeded;
    
    // Награда золотом (растет с уровнем)
    int goldReward = 50 + (level * 10);
    gold += goldReward;
    
    // Квадратичный рост опыта
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

// Определить сложность по опыту
String getDifficulty(int exp) {
  if (exp < 30) {
    return "Легкое😊";
  } else if (exp < 70) {
    return "Среднее😐";
  } else if (exp < 120) {
    return "Сложное👹";
  } else if (exp < 200) {
    return "Супер сложное🔥";
  }
  else {
    return "НУ ЭТО ПРОСТО ПИЗДЕЦ БРАТАН!!☠️";
  }
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

// ФУНКЦИЯ проверки имени
String getValidName() {
  String name = "";
  bool valid = false;
  
  while (!valid) {
    stdout.write('Назови своего персонажа: ');
    name = stdin.readLineSync(encoding: utf8)!.trim();
    
    if (name.isEmpty) {
      print("❌ Имя не может быть пустым!");
    } else if (name.length < 3) {
      print('❌ Имя слишком короткое! Минимум 3 символа. Попробуйте снова.');
    } else {
      valid = true;
    }
  }
  
  return name;
}

// Создание нескольких задач
List<Map<String, dynamic>> createMultipleTasks() {
  List<Map<String, dynamic>> tasks = [];
  bool addingMore = true;
  int taskNumber = 1;

  print("\n🎯           Создание задач");
  print("=" * 40);

  while (addingMore) {
    print("\n--- Задача №$taskNumber ---");
    // Запрашиваем описание задачи (добавил двоеточие для ясности)
    String description = getValidText("Описание задачи: ", 3);

    // Запрашиваем опыт для задачи
    int expReward = getValidNumber("Опыт за выполнение (цифрами): ");

    // Определяем сложность 
    String difficulty = getDifficulty(expReward);

    // Создаем задачу
    Map<String, dynamic> task = {
      "number": taskNumber,
      "description": description,
      "expReward": expReward, 
      "difficulty": difficulty,
      "completed": false
    };

    tasks.add(task);
    print("✅ Задача добавлена: '$description', ($difficulty, +$expReward опыта)");

    // Добавить ли ещё?
    stdout.write("\nДобавить ещё одну задачу? (да/нет): ");
    String answer = stdin.readLineSync(encoding: utf8)!.trim().toLowerCase();

    if (answer != "да") {
      addingMore = false;
    } else {
      taskNumber++;
    }
  }

  return tasks;
}

void showAllTasks(List<Map<String, dynamic>> tasks) {
  if (tasks.isEmpty) {
    print("\nНихуя те делать не надо ❌");
    return;
  }

  print("\n📝 ВАШИ ЗАДАЧИ:");
  print("=" * 40);

  for (var task in tasks) {
    String status = task["completed"] ? "✅" : "📋";
    print("$status Задача ${task["number"]}: ${task["description"]}");
    print("     Сложность: ${task["difficulty"]} | Опыт:  +${task["expReward"]}");
    print("-" * 40);  // Изменил на тире для лучшего вида
  }
}

// Выполнение задач (исправлена для возврата результатов)
Map<String, int> completeTasks(List<Map<String, dynamic>> tasks) {
  print("\n👾 ВЫПОЛНЕНИЕ ЗАДАЧ");
  print("=" * 40);

  int exp = 0;
  int totalExpEarned = 0;
  int tasksCompleted = 0;
  
  for (var task in tasks) {
    print("\n--- Задача ${task["number"]}: ${task["description"]} ---");
    stdout.write("Выполнили эту задачу? (да/нет): ");
    String answer = stdin.readLineSync(encoding: utf8)!.trim().toLowerCase();

    if (answer == "да") {
      task["completed"] = true;
      int expReward = task["expReward"] as int; // Явное приведение типа
      exp += expReward;
      totalExpEarned += expReward;
      tasksCompleted++;

      print("✅ АЙ САУЛ! +$expReward");
    } else {
      print("❌ НУ ЧЕТ НЕ САУЛ");
    }
  }

  // Конечный результат
  print("\n" + "=" * 40);
  print("🏆 Результат:");
  print("Выполнение задач: $tasksCompleted/${tasks.length}");
  print("Получено опыта: +$totalExpEarned");
  print("Всего опыта: $exp");
  
  // Возвращаем только опыт, так как уровень проверяется отдельно
  return {"exp": exp, "totalExpEarned": totalExpEarned};
}

// === ГЛАВНАЯ ФУНКЦИЯ ===
void main() {
  stdout.encoding = utf8;
  
  int exp = 0;
  int gold = 100;
  int level = 1;
  int expNeeded = 100;
  
  print("⚡️Добро пожаловать в Life-Tracker⚡️");
  
  String salam = getValidName();
  
  print('Отлично, приятно познакомиться $salam, пора приступать к улучшению вашей жизни!\n');
  
  showStats(exp, level, gold, expNeeded);
  
  print("\nНе желаете ли приобрести начальный пакет для быстрого результата?");
  stdout.write("(да/нет): ");
  
  String answer = stdin.readLineSync(encoding: utf8)!.trim().toLowerCase();
  
  if (answer == "да") {
    print("\n✅ Вы выбрали: ДА");
    print("Отлично! Перейдите пожалуйста по ссылке для оплаты в телеграм t.me/whocaresbratec");
    print("Спасибо за оплату!");
  } else if (answer == "нет") {
    print("\n❌ Вы выбрали: НЕТ");
    stdout.write("\nПочему нет? Напишите об этом пожалуйста: ");
    String explanation = stdin.readLineSync(encoding: utf8)!.trim();
    print("\nВаш ответ: $explanation");
    print("\nСпасибо за обратную связь!");
  } else {
    print("\n😵 Непонятный ответ: '$answer', попробуйте еще раз.");
  }
  
  print("\nЖелаем вам успехов!");
  
  // === СОЗДАНИЕ НЕСКОЛЬКИХ ЗАДАЧ ===
  print("\n\nПора приступать!");
  stdout.write("Хотите создать задачи? (да/нет): ");
  String startAnswer = stdin.readLineSync(encoding: utf8)!.trim().toLowerCase();
  
  List<Map<String, dynamic>> tasks = []; // Объявляем переменную здесь

  if (startAnswer == "да") {
    // 1. Создаем задачи
    tasks = createMultipleTasks();
    
    // 2. Показываем все задачи
    showAllTasks(tasks);
    
    // 3. Спрашиваем начать ли выполнение
    stdout.write("\n\nНачать выполнение задач? (да/нет): ");
    String executeAnswer = stdin.readLineSync(encoding: utf8)!.trim().toLowerCase();
    
    if (executeAnswer == "да") {
      // 4. Выполняем задачи и получаем опыт
      Map<String, int> taskResults = completeTasks(tasks);
      int earnedExp = taskResults["exp"]!;
      int totalEarned = taskResults["totalExpEarned"]!;
      
      // 5. Добавляем опыт к персонажу
      exp += earnedExp;
      print("\n🥳 ЗАДАЧИ ВЫПОЛНЕНЫ!");
      print("💫 Общий полученный опыт: +$totalEarned");
      print("📊 Теперь у вас $exp опыта!");
      
      // 6. Проверяем уровень
      Map<String, int> result = checkLevelUp(exp, level, gold, expNeeded);
      exp = result["exp"]!;
      level = result["level"]!;
      gold = result["gold"]!;
      expNeeded = result["expNeeded"]!;
      
      // 7. Показываем обновленную статистику
      showStats(exp, level, gold, expNeeded);
      
    } else {
      print("\nОтложим задачи на потом😴");
      showStats(exp, level, gold, expNeeded);
    }
    
  } else {
    print("\nПропускаем создание задач...");
    
    // === СТАРАЯ ЛОГИКА ДЛЯ ОДНОЙ ЗАДАЧИ ===
    String task1 = getValidText("\nЧто сегодня хотите сделать? Напишите свою задачу: ", 3);
    print("\nВы хотите сделать: $task1");
    
    int expReward = getValidNumber("\nСколько опыта вы бы хотели за него получить? (напишите цифрами): ");
    
    String difficulty = getDifficulty(expReward);
    print("\n$expReward опыта, отлично!");
    print("Ваше задание оценивается как: $difficulty");
    
    stdout.write("\nВы выполнили задание? (да/нет): ");
    String completed = stdin.readLineSync(encoding: utf8)!.trim().toLowerCase();
    
    if (completed == "да") {
      print("\n🎉 Отлично! Вы выполнили задание!");
      
      exp += expReward;
      print("💫 Получено опыта: +$expReward");
      print("Теперь у вас $exp опыта!");
      
      Map<String, int> result = checkLevelUp(exp, level, gold, expNeeded);
      exp = result["exp"]!;
      level = result["level"]!;
      gold = result["gold"]!;
      expNeeded = result["expNeeded"]!;
      
    } else if (completed == "нет") {
      print("\n😔 Ничего страшного! В следующий раз обязательно получится!");
      print("Опыт не получен. Попробуйте снова!");
    } else {
      print("\n😵 Непонятный ответ: '$completed'");
      print("Опыт не получен.");
    }
    
    showStats(exp, level, gold, expNeeded);
  }
}