#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)

	ОткрытьФорму("Справочник.Организации.ФормаСписка",
				 ,
				 ПараметрыВыполненияКоманды.Источник,
				 ПараметрыВыполненияКоманды.Уникальность,
				 ,
				 ,
				 ,
				 РежимОткрытияОкнаФормы.Независимый);

КонецПроцедуры

#КонецОбласти