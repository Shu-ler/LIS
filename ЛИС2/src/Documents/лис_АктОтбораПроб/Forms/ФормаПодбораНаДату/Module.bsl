
&НаКлиенте
Процедура ПланОтбораПриИзменении(Элемент)
	
	Элементы.Сформировать.Доступность = Ложь;
	Элементы.КоличествоАктов.Видимость = Ложь;
	КоличествоАктов = 0;
	Отборы.Параметры.УстановитьЗначениеПараметра("ПланОтбораПроб", ПланОтбора);	
		
КонецПроцедуры

&НаКлиенте
Процедура ДатаОтбораПриИзменении(Элемент)
	
	Элементы.Сформировать.Доступность = Ложь;
	Элементы.КоличествоАктов.Видимость = Ложь;
	КоличествоАктов = 0;
	Отборы.Параметры.УстановитьЗначениеПараметра("ДатаОтбора", ДатаОтбора);	
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ДатаОтбора = ТекущаяДата();
	Отборы.Параметры.УстановитьЗначениеПараметра("ДатаОтбора", ДатаОтбора);
	Отборы.Параметры.УстановитьЗначениеПараметра("ПланОтбораПроб", Документы.лис_ПланОтбораПроб.ПустаяСсылка());
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборыПриАктивизацииСтроки(Элемент)
	
	Если ЗначениеЗаполнено(Элементы.Отборы.ТекущаяСтрока) Тогда
		Элементы.Сформировать.Доступность = Истина;
		Элементы.КоличествоАктов.Видимость = Истина;
		ВыделенныеСтроки = Элементы.Отборы.ВыделенныеСтроки;
		КоличествоАктов = 0;
		Для каждого НомерСтроки Из ВыделенныеСтроки Цикл
			ТекущаяСтрока = Элементы.Отборы.ДанныеСтроки(НомерСтроки);
			КоличествоАктов = КоличествоАктов + ОпределитьКоличествоАктов(ТекущаяСтрока);
		КонецЦикла;		
	КонецЕсли;	
	
КонецПроцедуры

&НаСервере
Функция ОпределитьКоличествоАктов(ТекущаяСтрока)
	
	Если ТекущаяСтрока.ПериодичностьЗамеров = Перечисления.ПериодыПроверкиЭкоаналитическогоКонтроля.День Тогда
		Возврат ТекущаяСтрока.КоличествоЗамеров;
	Иначе
		Возврат 1;
	КонецЕсли;	
		
КонецФункции

&НаКлиенте
Процедура Сформировать(Команда)
	
	ВыделенныеСтроки = Элементы.Отборы.ВыделенныеСтроки;
	Для каждого НомерСтроки Из ВыделенныеСтроки Цикл
		ТекущаяСтрока = Элементы.Отборы.ДанныеСтроки(НомерСтроки);
		СформироватьАктыОтбора(ТекущаяСтрока);
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура СформироватьАктыОтбора(ТекущаяСтрока)

	Если ТекущаяСтрока.ПериодичностьЗамеров = Перечисления.ПериодыПроверкиЭкоаналитическогоКонтроля.День Тогда
		НеобходимоАктов = ТекущаяСтрока.КоличествоЗамеров;
	Иначе
		НеобходимоАктов = 1;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	лис_ПланОтбораПробЗагрязняющиеВещества.ЗагрязняющееВещество,
	|	лис_ПланОтбораПробЗагрязняющиеВещества.МетодикаАнализа
	|ИЗ
	|	Документ.лис_ПланОтбораПроб.ЗагрязняющиеВещества КАК лис_ПланОтбораПробЗагрязняющиеВещества
	|ГДЕ
	|	лис_ПланОтбораПробЗагрязняющиеВещества.Ссылка = &Ссылка
	|	И лис_ПланОтбораПробЗагрязняющиеВещества.КлючСтроки = &КлючСтроки";
	Запрос.УстановитьПараметр("Ссылка", ПланОтбора);
	Запрос.УстановитьПараметр("КлючСтроки", ТекущаяСтрока.КлючСтроки);
	
	Вещества = Запрос.Выполнить().Выгрузить();
	
	СозданоАктов = 0;
	Пока СозданоАктов < НеобходимоАктов Цикл
		
		НовыйДокумент = Документы.лис_АктОтбораПроб.СоздатьДокумент();
		НовыйДокумент.Дата = ДатаОтбора;
		НовыйДокумент.ДатаОтбора = ДатаОтбора;
		НовыйДокумент.Организация = ТекущаяСтрока.Организация;
		НовыйДокумент.Лаборатория = ПланОтбора.Лаборатория;
		
		
		Для каждого Строка Из Вещества Цикл
			СтрокаПробы = НовыйДокумент.Пробы.Добавить();
			СтрокаПробы.ОпределяемыйПоказатель = Строка.ЗагрязняющееВещество;
			//СтрокаПробы.ТочкаОтбораПробы = ТекущаяСтрока.
		КонецЦикла;		
		
		НовыйДокумент.КоличествоПроб = НовыйДокумент.Пробы.Количество();
		НовыйДокумент.Записать(РежимЗаписиДокумента.Запись);
		
		СозданоАктов = СозданоАктов + 1;
	КонецЦикла; 
		
КонецПроцедуры


