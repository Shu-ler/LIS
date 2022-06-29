&НаКлиенте
Перем КонтекстЭДО Экспорт;

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ПриОткрытииЗавершение", ЭтотОбъект);
	ДокументооборотСКОКлиент.ПолучитьКонтекстЭДО(ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытииЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	КонтекстЭДО = Результат.КонтекстЭДО;
	
	Если КонтекстЭДО <> Неопределено Тогда
		
		КриптографияЭДКОКлиент.ОтобразитьПредставлениеСертификата(
			ЭтоЭлектроннаяПодписьВМоделиСервиса, 
			Элементы.Сертификат, 
			Объект.Сертификаты,
			ЭтотОбъект,
			"СертификатПредставление");
			
	Иначе
		
		Элементы.Сертификат.РедактированиеТекста = Ложь;
		Элементы.Сертификат.КнопкаВыбора = Ложь;
		Элементы.Сертификат.КнопкаОткрытия = Ложь;
		
		Если Объект.Сертификаты.Количество() <> 0 Тогда
			СертификатПредставление = "Сертификатов: " + Объект.Сертификаты.Количество();
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура НаименованиеПриИзменении(Элемент)
	Если ПустаяСтрока(Объект.ПолноеНаименование) Тогда
		Объект.ПолноеНаименование = Объект.Наименование
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПолноеНаименованиеПриИзменении(Элемент)
	
	Если ПустаяСтрока(Объект.Наименование) Тогда
		Объект.Наименование = Объект.ПолноеНаименование
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура СертификатНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	Оповещение = Новый ОписаниеОповещения(
		"СертификатНачалоВыбораЗавершение", ЭтотОбъект, Новый Структура("Элемент", Элемент));

	КриптографияЭДКОКлиент.ВыбратьСертификат(
		Оповещение, ЭтоЭлектроннаяПодписьВМоделиСервиса, Объект.Сертификаты, "AddressBook",, Истина);

КонецПроцедуры

&НаКлиенте
Процедура СертификатНачалоВыбораЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Элемент = ДополнительныеПараметры.Элемент;
	
	Если Результат.Выполнено Тогда
		Объект.Сертификаты.Очистить();
		Если ТипЗнч(Результат.ВыбранноеЗначение) = Тип("Структура") Тогда
			НовСтр = Объект.Сертификаты.Добавить();
			НовСтр.Сертификат = Результат.ВыбранноеЗначение.Отпечаток;
		Иначе
			Для Каждого Стр Из Результат.ВыбранноеЗначение Цикл
				НовСтр = Объект.Сертификаты.Добавить();
				НовСтр.Сертификат = Стр.Отпечаток;
			КонецЦикла;
		КонецЕсли;
		
		КриптографияЭДКОКлиент.ОтобразитьПредставлениеСертификата(
			ЭтоЭлектроннаяПодписьВМоделиСервиса, 
			Элемент, 
			Объект.Сертификаты,
			ЭтотОбъект,
			"СертификатПредставление");
			
		Модифицированность = Истина;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СертификатОткрытие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	Сертификаты = Новый Массив;
	Для Каждого СтрокаТаблицы Из Объект.Сертификаты Цикл
		Сертификаты.Добавить(Новый Структура("Отпечаток, ЭтоЭлектроннаяПодписьВМоделиСервиса", 
			СтрокаТаблицы.Сертификат, ЭтоЭлектроннаяПодписьВМоделиСервиса));
	КонецЦикла;
	
	КриптографияЭДКОКлиент.ПоказатьСертификат(Сертификаты);
	
КонецПроцедуры

&НаКлиенте
Процедура ОтпечатокОчистка(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	Объект.Сертификаты.Очистить();
	КриптографияЭДКОКлиент.ОтобразитьПредставлениеСертификата(
		ЭтоЭлектроннаяПодписьВМоделиСервиса, 
		Элемент, 
		Объект.Сертификаты,
		ЭтотОбъект,
		"СертификатПредставление");
	Модифицированность = Истина;

КонецПроцедуры

&НаКлиенте
Процедура АдресСайтаОткрытие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ОписаниеОповещения = Новый ОписаниеОповещения("АдресСайтаОткрытиеЗавершение", ЭтотОбъект);
	ТекстСообщения = НСтр("ru = 'Для работы подсистемы документооборота с контролирующими органами необходимо установить расширение работы с файлами.'");
	ОбщегоНазначенияКлиент.ПоказатьВопросОбУстановкеРасширенияРаботыСФайлами(ОписаниеОповещения, ТекстСообщения, Истина); 
	
КонецПроцедуры

&НаКлиенте
Процедура АдресСайтаОткрытиеЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат Тогда
		Если НЕ ПустаяСтрока(Объект.АдресСайта) Тогда
			ОбщегоНазначенияКлиент.ПерейтиПоСсылке(Объект.АдресСайта);
		КонецЕсли;
	Иначе
		ПерейтиПоНавигационнойСсылке(Объект.АдресСайта);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЭтоЭлектроннаяПодписьВМоделиСервиса = ЭлектроннаяПодписьВМоделиСервисаВызовСервера.ЭтоЭлектроннаяПодписьВМоделиСервиса();
	
КонецПроцедуры
