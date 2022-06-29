///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныеПроцедурыИФункции

Процедура ЗаписатьЗамеры(Замеры) Экспорт
	Если ТипЗнч(Замеры) = Тип("РезультатЗапроса") Тогда
		ЗаписатьРезультатЗапроса(Замеры);
	КонецЕсли;
КонецПроцедуры

Процедура ЗаписатьРезультатЗапроса(Замеры)
	Если НЕ Замеры.Пустой() Тогда
		НулевойИдентификатор = ОбщегоНазначенияКлиентСервер.ПустойУникальныйИдентификатор();
		
		НаборЗаписей = СоздатьНаборЗаписей();
		
		Выборка = Замеры.Выбрать();
		Пока Выборка.Следующий() Цикл
			Если Выборка.КомментарийСтатистики <> НулевойИдентификатор Тогда
				НовЗапись = НаборЗаписей.Добавить();
				НовЗапись.Период = Выборка.Период;
				НовЗапись.ОперацияСтатистики = Выборка.ОперацияСтатистики;
				НовЗапись.КомментарийСтатистики = Выборка.КомментарийСтатистики;
				НовЗапись.ИдентификаторУдаления = Выборка.ИдентификаторУдаления;
				НовЗапись.КоличествоЗначений = Выборка.КоличествоЗначений;
				НовЗапись.ПериодОкончание = Выборка.ПериодОкончание;
			КонецЕсли;
		КонецЦикла;
		
		НаборЗаписей.ОбменДанными.Загрузка = Истина;
		НаборЗаписей.Записать(Ложь);
	КонецЕсли;
КонецПроцедуры

Функция ПолучитьАгрегированныеЗаписи(ГраницаАгрегирования, ОбработатьЗаписиДо, ПериодАгрегации, ПериодУдаления) Экспорт
	Запрос = Новый Запрос;
	Запрос.Текст = "
	|ВЫБРАТЬ
	|	ДОБАВИТЬКДАТЕ(ДАТАВРЕМЯ(2015,1,1),СЕКУНДА, ВЫРАЗИТЬ((РАЗНОСТЬДАТ(ДАТАВРЕМЯ(2015,1,1), ЗамерыКомментарииСтатистики.Период, СЕКУНДА) + 63555667200)/&ПериодАгрегации - 0.5 КАК ЧИСЛО(11,0)) * &ПериодАгрегации - 63555667200) КАК Период,
	|	ДОБАВИТЬКДАТЕ(ДАТАВРЕМЯ(2015,1,1),СЕКУНДА, ВЫРАЗИТЬ((РАЗНОСТЬДАТ(ДАТАВРЕМЯ(2015,1,1), ЗамерыКомментарииСтатистики.Период, СЕКУНДА) + 63555667200)/&ПериодАгрегации - 0.5 КАК ЧИСЛО(11,0)) * &ПериодАгрегации - 63555667200 + &ПериодАгрегации - 1) КАК ПериодОкончание,
	|	ДОБАВИТЬКДАТЕ(ДАТАВРЕМЯ(2015,1,1),СЕКУНДА, ВЫРАЗИТЬ((РАЗНОСТЬДАТ(ДАТАВРЕМЯ(2015,1,1), ЗамерыКомментарииСтатистики.Период, СЕКУНДА) + 63555667200)/&ПериодУдаления - 0.5 КАК ЧИСЛО(11,0)) * &ПериодУдаления - 63555667200) КАК ИдентификаторУдаления,
	|	ЗамерыКомментарииСтатистики.ОперацияСтатистики,
	|	ЗамерыКомментарииСтатистики.КомментарийСтатистики,
	|	СУММА(ЗамерыКомментарииСтатистики.КоличествоЗначений) КАК КоличествоЗначений
	|ИЗ
	|	РегистрСведений.ЗамерыКомментарииСтатистики КАК ЗамерыКомментарииСтатистики
	|ГДЕ
	|	ЗамерыКомментарииСтатистики.Период >= &ГраницаАгрегирования
	|	И ЗамерыКомментарииСтатистики.Период < &ОбработатьЗаписиДо
	|СГРУППИРОВАТЬ ПО
	|	ДОБАВИТЬКДАТЕ(ДАТАВРЕМЯ(2015,1,1),СЕКУНДА, ВЫРАЗИТЬ((РАЗНОСТЬДАТ(ДАТАВРЕМЯ(2015,1,1), ЗамерыКомментарииСтатистики.Период, СЕКУНДА) + 63555667200)/&ПериодАгрегации - 0.5 КАК ЧИСЛО(11,0)) * &ПериодАгрегации - 63555667200),
	|	ДОБАВИТЬКДАТЕ(ДАТАВРЕМЯ(2015,1,1),СЕКУНДА, ВЫРАЗИТЬ((РАЗНОСТЬДАТ(ДАТАВРЕМЯ(2015,1,1), ЗамерыКомментарииСтатистики.Период, СЕКУНДА) + 63555667200)/&ПериодАгрегации - 0.5 КАК ЧИСЛО(11,0)) * &ПериодАгрегации - 63555667200 + &ПериодАгрегации - 1),
	|	ДОБАВИТЬКДАТЕ(ДАТАВРЕМЯ(2015,1,1),СЕКУНДА, ВЫРАЗИТЬ((РАЗНОСТЬДАТ(ДАТАВРЕМЯ(2015,1,1), ЗамерыКомментарииСтатистики.Период, СЕКУНДА) + 63555667200)/&ПериодУдаления - 0.5 КАК ЧИСЛО(11,0)) * &ПериодУдаления - 63555667200),
	|	ЗамерыКомментарииСтатистики.ОперацияСтатистики,
	|	ЗамерыКомментарииСтатистики.КомментарийСтатистики
	|";
	
	Запрос.УстановитьПараметр("ГраницаАгрегирования", ГраницаАгрегирования);
	Запрос.УстановитьПараметр("ОбработатьЗаписиДо", ОбработатьЗаписиДо);
	Запрос.УстановитьПараметр("ПериодАгрегации", ПериодАгрегации);
	Запрос.УстановитьПараметр("ПериодУдаления", ПериодУдаления);
	РезультатЗапроса = Запрос.Выполнить();
	
	Возврат РезультатЗапроса;
КонецФункции

Процедура УдалитьЗаписи(ГраницаАгрегирования, ОбработатьЗаписиДо) Экспорт
	Запрос = Новый Запрос;
	Запрос.Текст = "
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ЗамерыКомментарииСтатистики.ИдентификаторУдаления	
	|ИЗ
	|	РегистрСведений.ЗамерыКомментарииСтатистики КАК ЗамерыКомментарииСтатистики
	|ГДЕ
	|	ЗамерыКомментарииСтатистики.Период >= &ГраницаАгрегирования
	|	И ЗамерыКомментарииСтатистики.Период < &ОбработатьЗаписиДо
	|";
	
	Запрос.УстановитьПараметр("ГраницаАгрегирования", ГраницаАгрегирования);
	Запрос.УстановитьПараметр("ОбработатьЗаписиДо", ОбработатьЗаписиДо);
	
	РезультатЗапроса = Запрос.Выполнить();
	Выборка = РезультатЗапроса.Выбрать();
	
	НаборЗаписей = СоздатьНаборЗаписей();
	Пока Выборка.Следующий() Цикл
		
		НаборЗаписей.Отбор.ИдентификаторУдаления.Установить(Выборка.ИдентификаторУдаления);
		НаборЗаписей.Записать(Истина);
	КонецЦикла;
КонецПроцедуры

Функция ПолучитьЗамеры(ДатаНачала, ДатаОкончания, ПериодУдаления) Экспорт
	Запрос = Новый Запрос;
	Запрос.Текст = "
	|ВЫБРАТЬ
	|	ОперацииСтатистики.Наименование КАК ОперацияСтатистики,
	|	ДОБАВИТЬКДАТЕ(ДАТАВРЕМЯ(2015,1,1),СЕКУНДА, ВЫРАЗИТЬ((РАЗНОСТЬДАТ(ДАТАВРЕМЯ(2015,1,1), ЗамерыКомментарииСтатистики.Период, СЕКУНДА) + 63555667200)/&ПериодУдаления - 0.5 КАК ЧИСЛО(11,0)) * &ПериодУдаления - 63555667200) КАК Период,
	|	КомментарииСтатистики.Наименование КАК КомментарийСтатистики,
	|	СУММА(ЗамерыКомментарииСтатистики.КоличествоЗначений) КАК КоличествоЗначений
	|ИЗ
	|	РегистрСведений.ЗамерыКомментарииСтатистики КАК ЗамерыКомментарииСтатистики
	|ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|	РегистрСведений.ОперацииСтатистики КАК ОперацииСтатистики
	|ПО
	|	ЗамерыКомментарииСтатистики.ОперацияСтатистики = ОперацииСтатистики.ИдентификаторОперации
	|ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|	РегистрСведений.КомментарииСтатистики КАК КомментарииСтатистики
	|ПО
	|	ЗамерыКомментарииСтатистики.КомментарийСтатистики = КомментарииСтатистики.ИдентификаторКомментария
	|ГДЕ
	|	ЗамерыКомментарииСтатистики.Период >= &ДатаНачала
	|	И ЗамерыКомментарииСтатистики.ПериодОкончание <= &ДатаОкончания
	|	И ЗамерыКомментарииСтатистики.ИдентификаторУдаления < ДОБАВИТЬКДАТЕ(ДАТАВРЕМЯ(2015,1,1),СЕКУНДА, ВЫРАЗИТЬ((РАЗНОСТЬДАТ(ДАТАВРЕМЯ(2015,1,1), &ДатаОкончания, СЕКУНДА) + 63555667200)/&ПериодУдаления - 0.5 КАК ЧИСЛО(11,0)) * &ПериодУдаления - 63555667200)
	|СГРУППИРОВАТЬ ПО
	|	ДОБАВИТЬКДАТЕ(ДАТАВРЕМЯ(2015,1,1),СЕКУНДА, ВЫРАЗИТЬ((РАЗНОСТЬДАТ(ДАТАВРЕМЯ(2015,1,1), ЗамерыКомментарииСтатистики.Период, СЕКУНДА) + 63555667200)/&ПериодУдаления - 0.5 КАК ЧИСЛО(11,0)) * &ПериодУдаления - 63555667200),
	|	ОперацииСтатистики.Наименование,
	|	КомментарииСтатистики.Наименование
	|УПОРЯДОЧИТЬ ПО
	|	ДОБАВИТЬКДАТЕ(ДАТАВРЕМЯ(2015,1,1),СЕКУНДА, ВЫРАЗИТЬ((РАЗНОСТЬДАТ(ДАТАВРЕМЯ(2015,1,1), ЗамерыКомментарииСтатистики.Период, СЕКУНДА) + 63555667200)/&ПериодУдаления - 0.5 КАК ЧИСЛО(11,0)) * &ПериодУдаления - 63555667200),
	|	ОперацииСтатистики.Наименование,
	|	КомментарииСтатистики.Наименование
	|";
	
	Запрос.УстановитьПараметр("ДатаНачала", ДатаНачала);
	Запрос.УстановитьПараметр("ДатаОкончания", ДатаОкончания);
	Запрос.УстановитьПараметр("ПериодУдаления", ПериодУдаления);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Возврат РезультатЗапроса;	
КонецФункции

#КонецОбласти

#КонецЕсли