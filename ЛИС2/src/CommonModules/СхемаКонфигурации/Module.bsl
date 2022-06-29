#Область СлужебныйПрограммныйИнтерфейс

// Двоичные данные схемы
// 
// Параметры: 
//  АннотироватьСсылочныеТипы - Булево
//  УчитыватьРасширениеДанных - Булево
// 
// Возвращаемое значение: 
//  ДвоичныеДанные
Функция ДвоичныеДанныеСхемы(АннотироватьСсылочныеТипы = Ложь, УчитыватьРасширениеДанных = Истина) Экспорт 	
	
	Если Не УчитыватьРасширениеДанных Тогда
		
		АдресВоВременномХранилище = ПоместитьВоВременноеХранилище(Неопределено);
		
		ПараметрыФоновогоЗадания = Новый Массив;
		ПараметрыФоновогоЗадания.Добавить(АннотироватьСсылочныеТипы);
		ПараметрыФоновогоЗадания.Добавить(АдресВоВременномХранилище);	
		
		ФоновоеЗадание = РасширенияКонфигурации.ВыполнитьФоновоеЗаданиеБезРасширений(
			"СхемаКонфигурации.ПоместитьВоВременноеХранилищеДвоичныеДанныеСхемы", 
			ПараметрыФоновогоЗадания);	
		ФоновоеЗадание = ФоновоеЗадание.ОжидатьЗавершенияВыполнения();
		
		Состояние = ФоновоеЗадание.Состояние;	
		Если Состояние = СостояниеФоновогоЗадания.Отменено Тогда
			ВызватьИсключение НСтр("ru = 'Задание отменено'");
		ИначеЕсли Состояние = СостояниеФоновогоЗадания.ЗавершеноАварийно Тогда
			ВызватьИсключение ТехнологияСервиса.ПодробныйТекстОшибки(ФоновоеЗадание.ИнформацияОбОшибке);
		КонецЕсли;
			
		ДвоичныеДанныеСхемыТекущейКонфигурации = ПолучитьИзВременногоХранилища(АдресВоВременномХранилище);
		УдалитьИзВременногоХранилища(АдресВоВременномХранилище);
		
		Если ДвоичныеДанныеСхемыТекущейКонфигурации = Неопределено Тогда
			ВызватьИсключение НСтр("ru = 'Не удалось получить двоичные данные схемы конфигурации'");
		КонецЕсли;
		
		Возврат ДвоичныеДанныеСхемыТекущейКонфигурации;
		
	КонецЕсли;
		
	НаборСхем = ФабрикаXDTO.ЭкспортСхемыXML(URIПространствИменСхемаКонфигурации());
	Схема = НаборСхем[0];
	Схема.ОбновитьЭлементDOM();
	
	Если АннотироватьСсылочныеТипы Тогда
		
		ТипыТребующиеАннотациюСсылок = ВыгрузкаЗагрузкаДанныхСлужебныйСобытия.ПолучитьТипыТребующиеАннотациюСсылокПриВыгрузке();

		Если ЗначениеЗаполнено(ТипыТребующиеАннотациюСсылок) Тогда

			УказанныеТипы = Новый Соответствие;
			
			Для Каждого Тип Из ТипыТребующиеАннотациюСсылок Цикл
				УказанныеТипы.Вставить(ВыгрузкаЗагрузкаДанныхСлужебный.XMLТипСсылки(Тип), Истина);
			КонецЦикла;

			ПространствоИмен = Новый Соответствие;
			ПространствоИмен.Вставить("xs", "http://www.w3.org/2001/XMLSchema");
			РазыменовательПространствИменDOM = Новый РазыменовательПространствИменDOM(ПространствоИмен);
			ТекстXPath = "/xs:schema/xs:complexType/xs:sequence/xs:element[starts-with(@type,'tns:')]";

			Запрос = Схема.ДокументDOM.СоздатьВыражениеXPath(ТекстXPath, РазыменовательПространствИменDOM);
			Результат = Запрос.Вычислить(Схема.ДокументDOM);

			Пока Истина Цикл

				УзелПоля = Результат.ПолучитьСледующий();
				Если УзелПоля = Неопределено Тогда
					Прервать;
				КонецЕсли;
				АтрибутТип = УзелПоля.Атрибуты.ПолучитьИменованныйЭлемент("type");
				ТипБезNSПрефикса = Сред(АтрибутТип.ТекстовоеСодержимое, СтрДлина("tns:") + 1);

				Если УказанныеТипы.Получить(ТипБезNSПрефикса) = Неопределено Тогда
					Продолжить;
				КонецЕсли;

				УзелПоля.УстановитьАтрибут("nillable", "true");
				УзелПоля.УдалитьАтрибут("type");
			КонецЦикла;
			
		КонецЕсли;
	КонецЕсли;
	
	ПотокЗаписи = Новый ПотокВПамяти();
	
	ЗаписьXML = Новый ЗаписьXML();	
	ЗаписьXML.ОткрытьПоток(ПотокЗаписи);
	
	ЗаписьDOM = Новый ЗаписьDOM;
	ЗаписьDOM.Записать(Схема.ДокументDOM, ЗаписьXML);
	
	ЗаписьXML.Закрыть();
	
	Возврат ПотокЗаписи.ЗакрытьИПолучитьДвоичныеДанные();

КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция URIПространствИменСхемаКонфигурации()
	Возврат "http://v8.1c.ru/8.1/data/enterprise/current-config";   
КонецФункции

Процедура ПоместитьВоВременноеХранилищеДвоичныеДанныеСхемы(АннотироватьСсылочныеТипы, АдресСхемы) Экспорт
	ПоместитьВоВременноеХранилище(
		ДвоичныеДанныеСхемы(АннотироватьСсылочныеТипы),
		АдресСхемы);
КонецПроцедуры

#КонецОбласти
