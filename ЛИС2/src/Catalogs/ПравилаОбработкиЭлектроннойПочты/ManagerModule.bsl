///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.ГрупповоеИзменениеОбъектов

// Возвращает реквизиты объекта, которые не рекомендуется редактировать
// с помощью обработки группового изменения реквизитов.
//
// Возвращаемое значение:
//  Массив из Строка
//
Функция РеквизитыНеРедактируемыеВГрупповойОбработке() Экспорт
	
	Результат = Новый Массив;
	Результат.Добавить("Код");
	Результат.Добавить("Наименование");
	Результат.Добавить("КомпоновщикНастроек");
	Результат.Добавить("ПомещатьВПапку");
	Результат.Добавить("РеквизитДопУпорядочивания");
	Результат.Добавить("ПредставлениеОтбора");
	Возврат Результат;
	
КонецФункции

// Конец СтандартныеПодсистемы.ГрупповоеИзменениеОбъектов

// СтандартныеПодсистемы.УправлениеДоступом

// Параметры:
//   Ограничение - см. УправлениеДоступомПереопределяемый.ПриЗаполненииОграниченияДоступа.Ограничение.
//
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт
	
	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Владелец)
	|	ИЛИ ЗначениеРазрешено(Владелец.ВладелецУчетнойЗаписи, ПустаяСсылка КАК Ложь)";
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Применяет правила обработки писем.
//
// Параметры:
//  ПараметрыВыгрузки  - Структура:
//    * ДляПисемВПапке     - СправочникСсылка.ПапкиЭлектронныхПисем - письма, которые находятся в этой папке будут обработаны.
//    * ВключаяПодчиненные - Булево - признак, того что должны обрабатываться письма в подчиненных папках.
//    * ТаблицаПравил      - ТаблицаЗначений - таблица правил, которые должны быть применены.
//  АдресХранилища - Строка - сообщение о результате применения правил.
//
Процедура ПрименитьПравила(ПараметрыВыгрузки, АдресХранилища) Экспорт
	
	ТаблицаСоответствий = Новый ТаблицаЗначений;
	ТаблицаСоответствий.Колонки.Добавить("Папка");
	ТаблицаСоответствий.Колонки.Добавить("Письмо");
	
	ТекстУсловияПоПапке = ?(ПараметрыВыгрузки.ВключаяПодчиненные," В ИЕРАРХИИ(&ПапкаЭлектронногоПисьма) "," = &ПапкаЭлектронногоПисьма ");
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	ВыбранныеПравила.Правило,
	|	ВыбранныеПравила.Применять
	|ПОМЕСТИТЬ ВыбранныеПравила
	|ИЗ
	|	&ВыбранныеПравила КАК ВыбранныеПравила
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВыбранныеПравила.Правило,
	|	ПравилаОбработкиЭлектроннойПочты.КомпоновщикНастроек,
	|	ПравилаОбработкиЭлектроннойПочты.ПомещатьВПапку
	|ИЗ
	|	ВыбранныеПравила КАК ВыбранныеПравила
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ПравилаОбработкиЭлектроннойПочты КАК ПравилаОбработкиЭлектроннойПочты
	|		ПО ВыбранныеПравила.Правило = ПравилаОбработкиЭлектроннойПочты.Ссылка
	|ГДЕ
	|	ВыбранныеПравила.Применять
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ЭлектронноеПисьмоВходящее.Ссылка,
	|	ПредметыПапкиВзаимодействий.ПапкаЭлектронногоПисьма КАК Папка
	|ИЗ
	|	Документ.ЭлектронноеПисьмоВходящее КАК ЭлектронноеПисьмоВходящее
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ПредметыПапкиВзаимодействий КАК ПредметыПапкиВзаимодействий
	|		ПО ПредметыПапкиВзаимодействий.Взаимодействие = ЭлектронноеПисьмоВходящее.Ссылка
	|ГДЕ
	|	ПредметыПапкиВзаимодействий.ПапкаЭлектронногоПисьма " + ТекстУсловияПоПапке +"
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ЭлектронноеПисьмоИсходящее.Ссылка,
	|	ПредметыПапкиВзаимодействий.ПапкаЭлектронногоПисьма
	|ИЗ
	|	Документ.ЭлектронноеПисьмоИсходящее КАК ЭлектронноеПисьмоИсходящее
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ПредметыПапкиВзаимодействий КАК ПредметыПапкиВзаимодействий
	|		ПО ПредметыПапкиВзаимодействий.Взаимодействие = ЭлектронноеПисьмоИсходящее.Ссылка
	|ГДЕ
	|	ПредметыПапкиВзаимодействий.ПапкаЭлектронногоПисьма " + ТекстУсловияПоПапке ;
	
	Запрос.УстановитьПараметр("ВыбранныеПравила", ПараметрыВыгрузки.ТаблицаПравил);
	Запрос.УстановитьПараметр("ПапкаЭлектронногоПисьма", ПараметрыВыгрузки.ДляПисемВПапке);
	
	Результат = Запрос.ВыполнитьПакет();
	Если Результат[2].Пустой() Тогда
		ТекстСообщения = НСтр("ru = 'В выбранной папке нет писем.'");
		ПоместитьВоВременноеХранилище(ТекстСообщения, АдресХранилища);
		Возврат;
	КонецЕсли;
	
	ТаблицаПисем = Результат[2].Выгрузить();
	МассивПисем  = ТаблицаПисем.ВыгрузитьКолонку("Ссылка");
	МассивПапок  = ТаблицаПисем.ВыгрузитьКолонку("Папка");
	МассивПапок  = Взаимодействия.УдалитьПовторяющиесяЭлементыМассива(МассивПапок);
	
	Выборка = Результат[1].Выбрать();
	Пока Выборка.Следующий() Цикл
		
		СхемаПравилаОбработки = ПолучитьМакет("СхемаПравилаОбработкиЭлектроннойПочты");
		
		КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных();
		КомпоновщикНастроек = Новый КомпоновщикНастроекКомпоновкиДанных;
		КомпоновщикНастроек.Инициализировать(Новый ИсточникДоступныхНастроекКомпоновкиДанных(СхемаПравилаОбработки));
		КомпоновщикНастроек.ЗагрузитьНастройки(Выборка.КомпоновщикНастроек.Получить());
		КомпоновщикНастроек.Восстановить(СпособВосстановленияНастроекКомпоновкиДанных.ПроверятьДоступность);
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(КомпоновщикНастроек.Настройки.Отбор,
			"Ссылка",МассивПисем,ВидСравненияКомпоновкиДанных.ВСписке);
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(КомпоновщикНастроек.Настройки.Отбор,
			"Ссылка.УчетнаяЗапись",ПараметрыВыгрузки.УчетнаяЗапись,ВидСравненияКомпоновкиДанных.Равно);
		
		МакетКомпоновкиДанных = КомпоновщикМакета.Выполнить(СхемаПравилаОбработки,
			КомпоновщикНастроек.ПолучитьНастройки(),,,Тип("ГенераторМакетаКомпоновкиДанныхДляКоллекцииЗначений"));
		
		ТекстЗапроса = МакетКомпоновкиДанных.НаборыДанных.ОсновнойНаборДанных.Запрос;
		ЗапросПравило = Новый Запрос(ТекстЗапроса);
		Для каждого Параметр Из МакетКомпоновкиДанных.ЗначенияПараметров Цикл
			ЗапросПравило.Параметры.Вставить(Параметр.Имя, Параметр.Значение);
		КонецЦикла;
		
		РезультатПисьма = ЗапросПравило.Выполнить();
		Если Не РезультатПисьма.Пустой() Тогда
			ВыборкаПисьма = РезультатПисьма.Выбрать();
			Пока ВыборкаПисьма.Следующий() Цикл
				
				НоваяСтрокаТаблицы = ТаблицаСоответствий.Добавить();
				НоваяСтрокаТаблицы.Папка = Выборка.ПомещатьВПапку;
				НоваяСтрокаТаблицы.Письмо = ВыборкаПисьма.Ссылка;
				
				ИндексЭлементаМассиваКУдалению = МассивПисем.Найти(ВыборкаПисьма.Ссылка);
				Если ИндексЭлементаМассиваКУдалению <> Неопределено Тогда
					МассивПисем.Удалить(ИндексЭлементаМассиваКУдалению);
				КонецЕсли;
			КонецЦикла;
		КонецЕсли;
		
	КонецЦикла;
	
	Для каждого СтрокаТаблицы Из ТаблицаСоответствий Цикл
		Взаимодействия.УстановитьПапкуЭлектронногоПисьма(СтрокаТаблицы.Письмо, СтрокаТаблицы.Папка, Ложь);
		Если ЗначениеЗаполнено(СтрокаТаблицы.Папка) И МассивПапок.Найти(СтрокаТаблицы.Папка) = Неопределено Тогда
			 МассивПапок.Добавить(СтрокаТаблицы.Папка);
		КонецЕсли;
	КонецЦикла;
		
	Взаимодействия.РассчитатьРассмотреноПоПапкам(Взаимодействия.ТаблицаДанныхДляРасчетаРассмотрено(МассивПапок, "Папка"));
	
	Если ТаблицаСоответствий.Количество() > 0 Тогда
		ТекстСообщения = НСтр("ru = 'Перенос писем в папки выполнен.'");
	Иначе
		ТекстСообщения =  НСтр("ru = 'Ни одно письмо не было перенесено'");
	КонецЕсли;
	
	ПоместитьВоВременноеХранилище(ТекстСообщения, АдресХранилища);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
