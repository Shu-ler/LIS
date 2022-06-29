///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

// Параметры:
//  ОписаниеКомпоненты - см. ВнешниеКомпонентыСервер.ОписаниеПоставляемойОбщейКомпоненты.
//
Процедура ОбновитьОбщуюКомпоненту(ОписаниеКомпоненты) Экспорт
	
	Если Не ОбщегоНазначения.РазделениеВключено() Или ОбщегоНазначения.ДоступноИспользованиеРазделенныхДанных() Тогда 
		ВызватьИсключение
			НСтр("ru = 'Загрузка общих внешних компонент возможна только в неразделенном режиме модели сервиса.'");
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Истина);
	
	ЗаписьЖурналаРегистрации(НСтр("ru = 'Поставляемые внешние компоненты.Загрузка поставляемой компоненты'", 
		ОбщегоНазначения.КодОсновногоЯзыка()),
		УровеньЖурналаРегистрации.Информация,,,
		СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Инициирована загрузка поставляемой обработки
			           |%1'"),
		ВнешниеКомпонентыСлужебный.ПредставлениеКомпоненты(
			ОписаниеКомпоненты.Идентификатор, 
			ОписаниеКомпоненты.Версия)));
	
	НачатьТранзакцию();
	Попытка
		Ссылка = Справочники.ОбщиеВнешниеКомпоненты.НайтиПоИдентификатору(
			ОписаниеКомпоненты.Идентификатор, 
			ОписаниеКомпоненты.Версия);
		
		Если Ссылка.Пустая() Тогда
			ОбщаяКомпонента = Справочники.ОбщиеВнешниеКомпоненты.СоздатьЭлемент();
		Иначе
			Блокировка = Новый БлокировкаДанных;
			ЭлементБлокировки = Блокировка.Добавить("Справочник.ОбщиеВнешниеКомпоненты");
			ЭлементБлокировки.УстановитьЗначение("Ссылка", Ссылка);
			Блокировка.Заблокировать();
			
			ОбщаяКомпонента = Ссылка.ПолучитьОбъект();
			ОбщаяКомпонента.Заблокировать();
		КонецЕсли;
		
		ОбщаяКомпонента.Заполнить(Неопределено); // Конструктор по умолчанию.
		
		ДвоичныеДанныеКомпоненты = Новый ДвоичныеДанные(ОписаниеКомпоненты.ПутьКФайлу);
		Информация = ВнешниеКомпонентыСлужебный.ИнформацияОКомпонентеИзФайла(ДвоичныеДанныеКомпоненты, Ложь);
		
		Если Не Информация.Разобрано Тогда 
			ВызватьИсключение СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Поставляемую компоненту не удалось разобрать
				           |по причине:
				           |%1'"),
				Информация.ОписаниеОшибки);
		КонецЕсли;
		
		ЗаполнитьЗначенияСвойств(ОбщаяКомпонента, Информация.Реквизиты); // По данным манифеста.
		ЗаполнитьЗначенияСвойств(ОбщаяКомпонента, ОписаниеКомпоненты);   // По данным с сайта.
		
		ОбщаяКомпонента.ХранилищеКомпоненты = Новый ХранилищеЗначения(ДвоичныеДанныеКомпоненты);
		
		ОбщаяКомпонента.Записать();
		
		ЗафиксироватьТранзакцию();
	Исключение
		ОтменитьТранзакцию();
		ЗаписьЖурналаРегистрации(
			НСтр("ru = 'Поставляемые внешние компоненты.Загрузка поставляемой компоненты'",
				ОбщегоНазначения.КодОсновногоЯзыка()),
			УровеньЖурналаРегистрации.Ошибка,,,
			ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
	КонецПопытки;
	
	УстановитьПривилегированныйРежим(Ложь);
	
КонецПроцедуры

Функция ЭтоКомпонентаИзХранилища(Местоположение) Экспорт
	
	Возврат СтрНачинаетсяС(Местоположение, "e1cib/data/Справочник.ОбщиеВнешниеКомпоненты.ХранилищеКомпоненты");
	
КонецФункции

// Параметры:
//   Результат     - см. ВнешниеКомпонентыСлужебный.ИнформацияОСохраненнойКомпоненте
//   Идентификатор - Строка               - идентификатор объекта внешней компоненты.
//   Версия        - Строка
//                 - Неопределено - версия компоненты.
// 
Процедура ЗаполнитьИнформациюОКомпоненте(Результат, Версия, Идентификатор) Экспорт
	
	СсылкаИзОбщегоХранилища = Справочники.ОбщиеВнешниеКомпоненты.НайтиПоИдентификатору(Идентификатор, Версия);
	СсылкаИзХранилища = Справочники.ВнешниеКомпоненты.НайтиПоИдентификатору(Идентификатор, Версия);
		
	Если СсылкаИзХранилища.Пустая() Тогда
		Если СсылкаИзОбщегоХранилища.Пустая() Тогда
			Результат.Состояние = "НеНайдена";
		Иначе
			Результат.Состояние = "НайденаВОбщемХранилище";
			Результат.Ссылка = СсылкаИзОбщегоХранилища;
		КонецЕсли;
	Иначе
		Если СсылкаИзОбщегоХранилища.Пустая() Тогда
			Результат.Состояние = "НайденаВХранилище";
			Результат.Ссылка = СсылкаИзХранилища;
		Иначе
			Если ЗначениеЗаполнено(Версия) Тогда
				// Компонента одной и той же версии есть и в общем хранилище, и в хранилище области.
				// Приоритет компоненте области.
				Результат.Состояние = "НайденаВХранилище";
				Результат.Ссылка = СсылкаИзХранилища;
			Иначе
				ВерсияХранилища = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(СсылкаИзХранилища, "ДатаВерсии");
				ВерсияОбщегоХранилища = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(СсылкаИзОбщегоХранилища, "ДатаВерсии");
				
				Если ВерсияОбщегоХранилища > ВерсияХранилища Тогда
					Результат.Состояние = "НайденаВОбщемХранилище";
					Результат.Ссылка = СсылкаИзОбщегоХранилища;
				Иначе
					// Компонента есть и в общем хранилище, и в хранилище области,
					// Приоритет компоненте области.
					Результат.Состояние = "НайденаВХранилище";
					Результат.Ссылка = СсылкаИзХранилища;
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

Функция ВерсииОбщихВнешнихКомпонент() Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ОбщиеВнешниеКомпоненты.Ссылка КАК Ссылка,
	|	ОбщиеВнешниеКомпоненты.ВерсияДанных КАК ВерсияДанных
	|ИЗ
	|	Справочник.ОбщиеВнешниеКомпоненты КАК ОбщиеВнешниеКомпоненты";
	
	Возврат Запрос.Выполнить().Выбрать();

КонецФункции

#Область ОбработчикиСобытийПодсистемКонфигурации

// См. ГрупповоеИзменениеОбъектовПереопределяемый.ПриОпределенииОбъектовСРедактируемымиРеквизитами.
Процедура ПриОпределенииОбъектовСРедактируемымиРеквизитами(Объекты) Экспорт
	
	Объекты.Вставить(Метаданные.Справочники.ОбщиеВнешниеКомпоненты.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	
КонецПроцедуры

// См. ВыгрузкаЗагрузкаДанныхПереопределяемый.ПриЗаполненииТиповИсключаемыхИзВыгрузкиЗагрузки.
Процедура ПриЗаполненииТиповИсключаемыхИзВыгрузкиЗагрузки(Типы) Экспорт
	
	Типы.Добавить(Метаданные.Справочники.ОбщиеВнешниеКомпоненты);
	
КонецПроцедуры

// См. СтандартныеПодсистемыСервер.ПриОтправкеДанныхГлавному.
Процедура ПриОтправкеДанныхГлавному(ЭлементДанных, ОтправкаЭлемента, Получатель) Экспорт
	
	Если ТипЗнч(ЭлементДанных) = Тип("СправочникОбъект.ОбщиеВнешниеКомпоненты") Тогда
		ОтправкаЭлемента = ОтправкаЭлементаДанных.Игнорировать;
	КонецЕсли;
	
КонецПроцедуры

// См. СтандартныеПодсистемыСервер.ПриОтправкеДанныхПодчиненному.
Процедура ПриОтправкеДанныхПодчиненному(ЭлементДанных, ОтправкаЭлемента, СозданиеНачальногоОбраза, Получатель) Экспорт
	
	Если ТипЗнч(ЭлементДанных) = Тип("СправочникОбъект.ОбщиеВнешниеКомпоненты") Тогда
		ОтправкаЭлемента = ОтправкаЭлементаДанных.Игнорировать;
	КонецЕсли;
	
КонецПроцедуры

// См. СтандартныеПодсистемыСервер.ПриПолученииДанныхОтГлавного.
Процедура ПриПолученииДанныхОтГлавного(ЭлементДанных, ПолучениеЭлемента, ОтправкаНазад, Отправитель) Экспорт
	
	Если ТипЗнч(ЭлементДанных) = Тип("СправочникОбъект.ОбщиеВнешниеКомпоненты") Тогда
		ПолучениеЭлемента = ПолучениеЭлементаДанных.Игнорировать;
	КонецЕсли;
	
КонецПроцедуры

// См. СтандартныеПодсистемыСервер.ПриПолученииДанныхОтПодчиненного.
Процедура ПриПолученииДанныхОтПодчиненного(ЭлементДанных, ПолучениеЭлемента, ОтправкаНазад, Отправитель) Экспорт
	
	Если ТипЗнч(ЭлементДанных) = Тип("СправочникОбъект.ОбщиеВнешниеКомпоненты") Тогда
		ПолучениеЭлемента = ПолучениеЭлементаДанных.Игнорировать;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
