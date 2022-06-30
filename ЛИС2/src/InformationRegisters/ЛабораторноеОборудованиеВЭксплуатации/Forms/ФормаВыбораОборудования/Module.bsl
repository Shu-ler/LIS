
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ОборудованиеВЭксплуатации.Параметры.УстановитьЗначениеПараметра("Организация", Параметры.Организация);
	ОборудованиеВЭксплуатации.Параметры.УстановитьЗначениеПараметра("Лаборатория", Параметры.Лаборатория);
	
КонецПроцедуры

&НаКлиенте
Процедура ОборудованиеВЭксплуатацииВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ТекущаяСтрока = Элемент.ТекущиеДанные;
	ПараметрОповещения = СформироватьСтруктуру(ТекущаяСтрока);
	Оповестить(, ПараметрОповещения);
	ЭтаФорма.Закрыть();
	
КонецПроцедуры

&НаСервере
Функция СформироватьСтруктуру(ВыбраннаяСтрока)

	ПараметрОповещения = Новый Структура("Оборудование, РегистрационныйНомер, ИнвентарныйНомер, ЗаводскойНомер",
										ВыбраннаяСтрока.Оборудование, ВыбраннаяСтрока.РегистрационныйНомер, ВыбраннаяСтрока.ИнвентарныйНомер, ВыбраннаяСтрока.ЗаводскойНомер);
	Возврат ПараметрОповещения;

КонецФункции
