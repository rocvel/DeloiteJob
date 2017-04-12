﻿
Процедура ПриОткрытии()
	ФлагЗакрытия=Истина;
	Таб1=Новый ТабличноеПоле;
	Пользователи1=ПользователиИнформационнойБазы.ПолучитьПользователей();
	СписокСправочников=Новый СписокЗначений();
	Попытка
		СписокСправочников.Добавить(Метаданные.Справочники.Банки);
	Исключение
	КонецПопытки;
	Попытка
		СписокСправочников.Добавить(Метаданные.Справочники.БанковскиеСчета);
	Исключение
	КонецПопытки;
	Попытка
		СписокСправочников.Добавить(Метаданные.Справочники.ГруппыПользователей);
	Исключение
	КонецПопытки;
	Попытка
		СписокСправочников.Добавить(Метаданные.Справочники.ДоговорыКонтрагентов);
	Исключение
	КонецПопытки;
    Попытка
		СписокСправочников.Добавить(Метаданные.Справочники.Контрагенты); 
	Исключение
	КонецПопытки;
	Попытка
		СписокСправочников.Добавить(Метаданные.Справочники.Номенклатура);
	Исключение
	КонецПопытки;	
	Попытка
		СписокСправочников.Добавить(Метаданные.Справочники.ОсновныеСредства);
	Исключение
	КонецПопытки;
	Попытка
		СписокСправочников.Добавить(Метаданные.Справочники.Пользователи);
	Исключение
	КонецПопытки;
	Попытка
		СписокСправочников.Добавить(Метаданные.Справочники.РасходыБудущихПериодов);
	Исключение
	КонецПопытки;	
 	СписокСправочников.СортироватьПоЗначению();	
  	Таб1.Колонки.Добавить("Пользователь");    	
	Для каждого Справ1 Из СписокСправочников Цикл
		Таб1.Колонки.Добавить();			
	КонецЦикла;              
	Для каждого Пользователь1  Из Пользователи1  Цикл
		Строка=Таб1.Добавить();
		Строка[0]=Пользователь1;
		НомАтр=1;
		ФлагЕстьПрава=Ложь;
		Для каждого Справ1 Из СписокСправочников Цикл
			Если ПравоДоступа("ИнтерактивноеДобавление",Справ1.Значение,Пользователь1) Тогда
				Строка[НомАтр]="Добавление "; 
				ФлагЕстьПрава=Истина;
			КонецЕсли;
			Если ПравоДоступа("Редактирование",Справ1.Значение,Пользователь1) Тогда
				Строка[НомАтр]=Строка(Строка[НомАтр])+"Изменение "; 
				ФлагЕстьПрава=Истина;
			КонецЕсли;
			Если ПравоДоступа("ИнтерактивноеУдаление",Справ1.Значение,Пользователь1) Тогда
				Строка[НомАтр]=Строка(Строка[НомАтр])+"Удаление ";
				ФлагЕстьПрава=Истина;
			КонецЕсли;
			НомАтр=НомАтр+1;	
		КонецЦикла; 
		Если ФлагЕстьПрава=Ложь Тогда
			Таб1.Удалить(Строка);
		КонецЕсли; 
	КонецЦикла; 	
	ЭлементыФормы.ТабличноеПоле1.Значение=Таб1;
	ЭлементыФормы.ТабличноеПоле1.СоздатьКолонки();
	Колонки1=ЭлементыФормы.ТабличноеПоле1.Колонки;
	НомАтр=0;
	Для каждого Колонка1 Из Колонки1  Цикл
		Колонка1.Ширина=20;	
		Если НомАтр=0 Тогда
			Колонка1.ТекстШапки="Пользователь"
		Иначе
			Колонка1.ТекстШапки=СписокСправочников[НомАтр-1];
		КонецЕсли; 
		НомАтр=НомАтр+1
	КонецЦикла; 
КонецПроцедуры

Процедура ОсновныеДействияФормыНазад(Кнопка)
	ФормаВыбора1=ПолучитьФорму("ФормаВыбора");
	ФормаВыбора1.Открыть();
	ФлагЗакрытия=Ложь;
	ЭтаФорма.Закрыть();
КонецПроцедуры

Процедура ПередЗакрытием(Отказ, СтандартнаяОбработка)
	Если  ФлагЗакрытия Тогда
		Режим1 = РежимДиалогаВопрос.ДаНет;
		Текст = "Закончить работу обработки?";
		Ответ = Вопрос(Текст, Режим1);
		Если Ответ = КодВозвратаДиалога.Нет Тогда
	    	Отказ=истина;
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

