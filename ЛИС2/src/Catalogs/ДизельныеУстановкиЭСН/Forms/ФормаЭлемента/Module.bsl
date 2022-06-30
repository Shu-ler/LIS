#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура РедактироватьОсновныеСведения(Команда)
	ПараметрыФормы = Новый Структура("Ключ", Объект.Владелец);
	Оповещение = Новый ОписаниеОповещения("РедактироватьОсновныеСведенияЗавершение", ЭтотОбъект);
	ОткрытьФорму("Справочник.ИсточникиЗагрязнения.ФормаОбъекта", ПараметрыФормы, ЭтаФорма,,,,Оповещение,РежимОткрытияОкнаФормы.БлокироватьОкноВладельца)
КонецПроцедуры
 
&НаКлиенте
Процедура РедактироватьОсновныеСведенияЗавершение(РезультатЗакрытия, ДополнительныеПараметры) Экспорт
	
	Прочитать();
	
КонецПроцедуры

&НаКлиенте
Процедура СправкаПоГруппамНажатие(Элемент) // Моисеев Е.П. 28.09.2017 начало

	ОткрытьСправкуФормы();
	
КонецПроцедуры // Моисеев Е.П. 28.09.2017 конец

&НаКлиенте
Процедура ПриОткрытии(Отказ)
// {EXTCODE 27.10.2017 Ушаков А.Е.
Если Объект.Ссылка.Пустая() И Не ЗначениеЗаполнено(Объект.Владелец) Тогда 
		ПараметрыОткрытия = Новый Структура;
		ПараметрыОткрытия.Вставить("ТолькоИВ",Истина);
		ПереченьВидыИВ = Новый Массив;
		ПереченьВидыИВ.Добавить(ПредопределенноеЗначение("Справочник.ВидыИВ.ДизельнаяУстановка"));
		ПараметрыОткрытия.Вставить("ПереченьВидыИВ",ПереченьВидыИВ);
		Оповещение = Новый ОписаниеОповещения("ВыборИсточникаЗагрязнения", ЭтотОбъект);
		ОткрытьФорму("Справочник.ИсточникиЗагрязнения.ФормаВыбора",ПараметрыОткрытия,ЭтаФорма,,,,Оповещение,РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	КонецЕсли;
// }EXTCODE 27.10.2017 Ушаков А.Е.
КонецПроцедуры

&НаКлиенте
Процедура ВыборИсточникаЗагрязнения(Результат, ДополнительныеПараметры) Экспорт // {EXTCODE 27.10.2017 Ушаков А.Е.

	Если Результат <> Неопределено Тогда 
		Объект.Владелец = Результат;
	Иначе 
		Закрыть();
	КонецЕсли;

КонецПроцедуры // ВыборИсточникаЗагрязнения() // }EXTCODE 27.10.2017 Ушаков А.Е.


#КонецОбласти
