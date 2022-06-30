#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.ДополнительныеОтчетыИОбработки
	ДополнительныеОтчетыИОбработки.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ДополнительныеОтчетыИОбработки
		
	Если ОбщегоНазначенияПовтИсп.ДоступноИспользованиеРазделенныхДанных() Тогда
		// GalaktionovVA; Выделение подсистемы ЛИС - Старт
		//ПолучитьЗначениеНормативаПлаты();
		// GalaktionovVA; Выделение подсистемы ЛИС - Финиш
		ПолучитьЗначениеНормативовКачества();
	Иначе
		Элементы.ГруппаНормативПлаты.Видимость = Ложь;
		Элементы.ГруппаНормативыКачества.Видимость = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	Если ОбщегоНазначенияПовтИсп.ДоступноИспользованиеРазделенныхДанных() Тогда
		// GalaktionovVA; Выделение подсистемы ЛИС - Старт
		//ПолучитьЗначениеНормативаПлаты();
		// GalaktionovVA; Выделение подсистемы ЛИС - Финиш
		ПолучитьЗначениеНормативовКачества();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// GalaktionovVA; Выделение подсистемы ЛИС - Старт
//&НаСервере
//Процедура ПолучитьЗначениеНормативаПлаты()
//	
//	Отбор = Новый Структура("ЗагрязняющееВещество", Объект.Ссылка);
//	СтруктураНормативов = РегистрыСведений.НормативыПлатыЗаНегативноеВоздействие.ПолучитьПоследнее(ТекущаяДата(), Отбор);
//	НормативПлатыПДВ = СтруктураНормативов.НормативВПределахНорм;
//	НормативПлатыВСВ = СтруктураНормативов.НормативВПределахЛимитов;
//	
//КонецПроцедуры
// GalaktionovVA; Выделение подсистемы ЛИС - Финиш

&НаСервере
Процедура ПолучитьЗначениеНормативовКачества()
	
	Отбор = Новый Структура("ЗагрязняющееВещество", Объект.Ссылка);
	СтруктураНормативов = РегистрыСведений.НормативыКачестваОкружающейСредыВещества.ПолучитьПоследнее(ТекущаяДатаСеанса(), Отбор);
	НормативКачестваПДКМР = СтруктураНормативов.ПДКМР;
	НормативКачестваПДКСС = СтруктураНормативов.ПДКСС;
	НормативКачестваОБУВ = СтруктураНормативов.ОБУВ;
	
КонецПроцедуры

#КонецОбласти
