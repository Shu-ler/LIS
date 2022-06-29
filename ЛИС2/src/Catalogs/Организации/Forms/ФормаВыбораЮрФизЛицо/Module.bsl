#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ВидОрганизации = "ЮридическоеЛицо";
	
	ЗаполнитьСписокВыбораВидаОрганизации();
	
	Элементы.СтраницыФормы.ТекущаяСтраница = Элементы.СтраницаВидОрганизации;
	Элементы.СтраницыКоманднойПанели.ТекущаяСтраница = Элементы.СтраницаКоманднойПанелиГоловнаяОрганизация;
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	МассивНепроверяемыхРеквизитов = Новый Массив;
	
	Если ВидОрганизации <> "ОбособленноеПодразделение" Тогда
		МассивНепроверяемыхРеквизитов.Добавить("ГоловнаяОрганизация");
	КонецЕсли;
	
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, МассивНепроверяемыхРеквизитов);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Заголовок = ПолучитьЗаголовокФормы();
	УстановитьВидимостьКнопок();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ВидОрганизацииПриИзменении(Элемент)
	
	Если ВидОрганизации = "ОбособленноеПодразделение" Тогда
		Элементы.СтраницыКоманднойПанели.ТекущаяСтраница = Элементы.СтраницаКоманднойПанелиВидОрганизации;
	Иначе
		Элементы.СтраницыКоманднойПанели.ТекущаяСтраница = Элементы.СтраницаКоманднойПанелиГоловнаяОрганизация;
	КонецЕсли;
	
	УстановитьВидимостьКнопок();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Далее(Команда)
	
	Если ВидОрганизации = "ОбособленноеПодразделение" Тогда
		Элементы.СтраницыФормы.ТекущаяСтраница = Элементы.СтраницаГоловнаяОрганизация;
		Если ЗначениеЗаполнено(ЭтотОбъект.ВладелецФормы.ТекущаяСтрока) Тогда
			ГоловнаяОрганизация = ЭтотОбъект.ВладелецФормы.ТекущаяСтрока;
		КонецЕсли;
	КонецЕсли;
	Элементы.СтраницыКоманднойПанели.ТекущаяСтраница = Элементы.СтраницаКоманднойПанелиГоловнаяОрганизация;
	
	Заголовок = ПолучитьЗаголовокФормы();
	УстановитьВидимостьКнопок();
	
КонецПроцедуры

&НаКлиенте
Процедура Назад(Команда)
	
	Элементы.СтраницыФормы.ТекущаяСтраница = Элементы.СтраницаВидОрганизации;
	Элементы.СтраницыКоманднойПанели.ТекущаяСтраница = Элементы.СтраницаКоманднойПанелиВидОрганизации;
	
	Заголовок = ПолучитьЗаголовокФормы();
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьОрганизацию(Команда)
	
	Если Не ПроверитьЗаполнение() Тогда
		Возврат;
	КонецЕсли;
	
	ЗначенияЗаполнения = Новый Структура;
	Если ВидОрганизации = "ИндивидуальныйПредприниматель" Тогда
		ЗначенияЗаполнения.Вставить("ЮридическоеФизическоеЛицо",
			ПредопределенноеЗначение("Перечисление.ЮридическоеФизическоеЛицо.ФизическоеЛицо"));
	ИначеЕсли ВидОрганизации = "ЮридическоеЛицо" Тогда
		ЗначенияЗаполнения.Вставить("ЮридическоеФизическоеЛицо",
			ПредопределенноеЗначение("Перечисление.ЮридическоеФизическоеЛицо.ЮридическоеЛицо"));
	Иначе 
		ЗначенияЗаполнения.Вставить("ЮридическоеФизическоеЛицо",
			ПредопределенноеЗначение("Перечисление.ЮридическоеФизическоеЛицо.ЮридическоеЛицо"));		
		ЗначенияЗаполнения.Вставить("ОбособленноеПодразделение", Истина);
	КонецЕсли;
	
	Если ВидОрганизации = "ОбособленноеПодразделение" Тогда
		ЗначенияЗаполнения.Вставить("Родитель", ГоловнаяОрганизация);
	КонецЕсли;
	
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("ЗначенияЗаполнения",       ЗначенияЗаполнения);
	
	Модифицированность = Ложь;
	
	Закрыть();
	
	ОткрытьФорму("Справочник.Организации.Форма.ФормаЭлемента", СтруктураПараметров, ВладелецФормы);

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗаполнитьСписокВыбораВидаОрганизации()
	
	СписокВыбора = Элементы.ВидОрганизации.СписокВыбора;
	
	СписокВыбора.Очистить();
	СписокВыбора.Добавить("ЮридическоеЛицо", НСтр("ru = 'Юридическое лицо'"));
	СписокВыбора.Добавить("ИндивидуальныйПредприниматель", НСтр("ru = 'Индивидуальный предприниматель'"));
	СписокВыбора.Добавить("ОбособленноеПодразделение", НСтр("ru = 'Обособленное подразделение'"));
	
КонецПроцедуры

&НаКлиенте
Функция ПолучитьЗаголовокФормы()
	
	ЗаголовокФормы = НСтр("ru = 'Создание организации'");
	
	Если Элементы.СтраницыФормы.ТекущаяСтраница <> Элементы.СтраницаВидОрганизации Тогда
		ВыбранноеЗначение = Элементы.ВидОрганизации.СписокВыбора.НайтиПоЗначению(ВидОрганизации);
		Если ВыбранноеЗначение <> Неопределено Тогда
			ЗаголовокФормы = ВыбранноеЗначение.Представление;
		КонецЕсли;
	КонецЕсли;
	
	Возврат ЗаголовокФормы;
	
КонецФункции

&НаКлиенте
Процедура УстановитьВидимостьКнопок()
	
	Элементы.Назад.Видимость = ?(Элементы.СтраницыФормы.ТекущаяСтраница = Элементы.СтраницаГоловнаяОрганизация,Истина,Ложь)
	
КонецПроцедуры

#КонецОбласти
