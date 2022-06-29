///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	Если ЗначениеЗаполнено(СрокДействия) И СрокДействия < ДатаПолучения Тогда
		ТекстСообщения = НСтр("ru = 'Срок действия согласия противоречит дате получения.'");
		ОбщегоНазначения.СообщитьПользователю(ТекстСообщения, , "Объект.СрокДействия", , Отказ);
	КонецЕсли;
	
	// Проверяем, что на указанную дату не было других записей о согласии.
	Согласие = ЗащитаПерсональныхДанных.ДействующееСогласиеНаОбработкуПерсональныхДанных(Субъект, Организация, ДатаПолучения, Ссылка);
	Если Согласие <> Неопределено Тогда
		Если ДатаПолучения = Согласие.ДатаПолучения Тогда
			ТекстСообщения = НСтр("ru = 'На указанную дату уже зарегистрировано согласие.'");
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения, , "Объект.ДатаПолучения", , Отказ);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	ОписаниеРегистрации = ЗащитаПерсональныхДанных.ОписаниеРегистрацииСогласияНаОбработкуПерсональныхДанных();
	ОписаниеРегистрации.Организация = Организация; 
	ОписаниеРегистрации.Субъект = Субъект;
	ОписаниеРегистрации.ДатаРегистрации = ДатаПолучения;
	ОписаниеРегистрации.Действует = Истина;
	ОписаниеРегистрации.СрокДействия = СрокДействия;
	
	ЗащитаПерсональныхДанных.ЗарегистрироватьСведенияОСогласииНаОбработкуПерсональныхДанных(Движения, ОписаниеРегистрации);
	
КонецПроцедуры

#КонецОбласти
	
#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли