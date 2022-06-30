#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ОбновитьФорму()
	
	Если Не ЗначениеЗаполнено(Объект.ВидГрафика) Тогда
		Возврат;
	КонецЕсли;
	
	Если Объект.ВидГрафика = ПредопределенноеЗначение("Перечисление.РазделыУчетаЭкоаналитическогоКонтроля.АтмосферныйВоздух")  Тогда
		МассивТиповАтмосфера = Новый Массив;
		МассивТиповАтмосфера.Добавить(Тип("СправочникСсылка.СанитарноЗащитныеЗоны"));
		МассивТиповАтмосфера.Добавить(Тип("СправочникСсылка.СелитебныеЗоны"));
		
		Элементы.ОсновноеОбъектЗагрязнения.ОграничениеТипа = Новый ОписаниеТипов(МассивТиповАтмосфера);
		Элементы.ОсновноеОбъектЗагрязнения.ВыбиратьТип 	   = Истина;
		
		Элементы.ЗагрязняющиеВеществаЗагрязняющееВещество.ОграничениеТипа = Новый ОписаниеТипов("СправочникСсылка.ЗВАтмосфера");
		Элементы.ЗагрязняющиеВеществаЗагрязняющееВещество.ВыбиратьТип 	  = Ложь;
		
		НоваяСвязь = Новый СвязьПараметраВыбора("Отбор.ОбъектОтбораПроб", "Элементы.Основное.ТекущиеДанные.ОбъектЗагрязнения");
		
		НовыйМассив = Новый Массив();
		НовыйМассив.Добавить(НоваяСвязь);
		
		НовыеСвязи = Новый ФиксированныйМассив(НовыйМассив);
		
		Элементы.ОсновноеТочкаКонтроля.СвязиПараметровВыбора = НовыеСвязи;
		
		Элементы.ОсновноеОбъектЗагрязнения.Видимость = Истина;
		Элементы.ОсновноеТочкаКонтроля.Видимость = Истина; 
		
	ИначеЕсли Объект.ВидГрафика = ПредопределенноеЗначение("Перечисление.РазделыУчетаЭкоаналитическогоКонтроля.ПромышленныеВыбросы")  Тогда
		Элементы.ОсновноеОбъектЗагрязнения.ОграничениеТипа = Новый ОписаниеТипов("СправочникСсылка.ИсточникиЗагрязнения");
		Элементы.ОсновноеОбъектЗагрязнения.ВыбиратьТип 	   = Ложь;
		
		Элементы.ЗагрязняющиеВеществаЗагрязняющееВещество.ОграничениеТипа = Новый ОписаниеТипов("СправочникСсылка.ЗВАтмосфера");
		Элементы.ЗагрязняющиеВеществаЗагрязняющееВещество.ВыбиратьТип 	  = Ложь;
		
		Элементы.ОсновноеОбъектЗагрязнения.Видимость = Истина;
		Элементы.ОсновноеТочкаКонтроля.Видимость = Ложь;
		
	ИначеЕсли Объект.ВидГрафика = ПредопределенноеЗначение("Перечисление.РазделыУчетаЭкоаналитическогоКонтроля.СточныеВоды")  Тогда
		Элементы.ОсновноеОбъектЗагрязнения.ОграничениеТипа = Новый ОписаниеТипов("СправочникСсылка.ВыпускиВВоду");
		Элементы.ОсновноеОбъектЗагрязнения.ВыбиратьТип 	   = Ложь;
		
		МассивТиповЗВПриродныеВоды = Новый Массив;
		МассивТиповЗВПриродныеВоды.Добавить(Тип("СправочникСсылка.ЗВВода"));
		МассивТиповЗВПриродныеВоды.Добавить(Тип("СправочникСсылка.КонтролируемыеПоказателиВВоде"));
	
		Элементы.ЗагрязняющиеВеществаЗагрязняющееВещество.ОграничениеТипа = Новый ОписаниеТипов(МассивТиповЗВПриродныеВоды);
		Элементы.ЗагрязняющиеВеществаЗагрязняющееВещество.ВыбиратьТип 	  = Истина;
		
		НоваяСвязь = Новый СвязьПараметраВыбора("Отбор.ОбъектОтбораПроб", "Элементы.Основное.ТекущиеДанные.ОбъектЗагрязнения");
		
		НовыйМассив = Новый Массив();
		НовыйМассив.Добавить(НоваяСвязь);
		
		НовыеСвязи = Новый ФиксированныйМассив(НовыйМассив);
		
		Элементы.ОсновноеТочкаКонтроля.СвязиПараметровВыбора = НовыеСвязи;		
		
		Элементы.ОсновноеОбъектЗагрязнения.Видимость = Истина;
		Элементы.ОсновноеТочкаКонтроля.Видимость = Истина;
	ИначеЕсли Объект.ВидГрафика = ПредопределенноеЗначение("Перечисление.РазделыУчетаЭкоаналитическогоКонтроля.ПриродныеВоды")  Тогда
		МассивТиповПриродныеВоды = Новый Массив;
		МассивТиповПриродныеВоды.Добавить(Тип("СправочникСсылка.Скважины"));
		МассивТиповПриродныеВоды.Добавить(Тип("СправочникСсылка.ВыпускиВВоду"));
		МассивТиповПриродныеВоды.Добавить(Тип("СправочникСсылка.ВодныеОбъекты"));
		МассивТиповПриродныеВоды.Добавить(Тип("СправочникСсылка.Водозаборы"));
		
		Элементы.ОсновноеОбъектЗагрязнения.ОграничениеТипа = Новый ОписаниеТипов(МассивТиповПриродныеВоды);
		Элементы.ОсновноеОбъектЗагрязнения.ВыбиратьТип 	   = Истина;
		
		МассивТиповЗВПриродныеВоды = Новый Массив;
		МассивТиповЗВПриродныеВоды.Добавить(Тип("СправочникСсылка.ЗВВода"));
		МассивТиповЗВПриродныеВоды.Добавить(Тип("СправочникСсылка.КонтролируемыеПоказателиВВоде"));
	
		Элементы.ЗагрязняющиеВеществаЗагрязняющееВещество.ОграничениеТипа = Новый ОписаниеТипов(МассивТиповЗВПриродныеВоды);
		Элементы.ЗагрязняющиеВеществаЗагрязняющееВещество.ВыбиратьТип 	  = Истина;
		
		НоваяСвязь = Новый СвязьПараметраВыбора("Отбор.ОбъектОтбораПроб", "Элементы.Основное.ТекущиеДанные.ОбъектЗагрязнения");
		
		НовыйМассив = Новый Массив();
		НовыйМассив.Добавить(НоваяСвязь);
		
		НовыеСвязи = Новый ФиксированныйМассив(НовыйМассив);
		
		Элементы.ОсновноеТочкаКонтроля.СвязиПараметровВыбора = НовыеСвязи;
		
		Элементы.ОсновноеОбъектЗагрязнения.Видимость = Истина;
		Элементы.ОсновноеТочкаКонтроля.Видимость = Истина;
	ИначеЕсли Объект.ВидГрафика = ПредопределенноеЗначение("Перечисление.РазделыУчетаЭкоаналитическогоКонтроля.Почвы")  Тогда
		Элементы.ЗагрязняющиеВеществаЗагрязняющееВещество.ОграничениеТипа = Новый ОписаниеТипов("СправочникСсылка.КонтролируемыеПараметрыВПочвеДонныхОтложениях");
		Элементы.ЗагрязняющиеВеществаЗагрязняющееВещество.ВыбиратьТип 	  = Ложь;
		
		Элементы.ОсновноеОбъектЗагрязнения.Видимость = Ложь;
		Элементы.ОсновноеТочкаКонтроля.Видимость = Истина;
	ИначеЕсли Объект.ВидГрафика = ПредопределенноеЗначение("Перечисление.РазделыУчетаЭкоаналитическогоКонтроля.ДонныеОтложения")  Тогда
		Элементы.ОсновноеОбъектЗагрязнения.ОграничениеТипа = Новый ОписаниеТипов("СправочникСсылка.ВодныеОбъекты");
		Элементы.ОсновноеОбъектЗагрязнения.ВыбиратьТип 	   = Ложь;
		
		Элементы.ЗагрязняющиеВеществаЗагрязняющееВещество.ОграничениеТипа = Новый ОписаниеТипов("СправочникСсылка.КонтролируемыеПараметрыВПочвеДонныхОтложениях");
		Элементы.ЗагрязняющиеВеществаЗагрязняющееВещество.ВыбиратьТип 	  = Ложь;
		
		Элементы.ОсновноеОбъектЗагрязнения.Видимость = Истина;
		Элементы.ОсновноеТочкаКонтроля.Видимость = Истина;
	ИначеЕсли Объект.ВидГрафика = ПредопределенноеЗначение("Перечисление.РазделыУчетаЭкоаналитическогоКонтроля.ФизическиеФакторы")  Тогда
		Элементы.ЗагрязняющиеВеществаЗагрязняющееВещество.ОграничениеТипа = Новый ОписаниеТипов("СправочникСсылка.ФакторыФизическогоВоздействия");
		Элементы.ЗагрязняющиеВеществаЗагрязняющееВещество.ВыбиратьТип 	  = Ложь;
		
		Элементы.ОсновноеОбъектЗагрязнения.Видимость = Ложь;
		Элементы.ОсновноеТочкаКонтроля.Видимость = Истина;
	ИначеЕсли Объект.ВидГрафика = ПредопределенноеЗначение("Перечисление.РазделыУчетаЭкоаналитическогоКонтроля.АтмосферныеОсадки")  Тогда
		Элементы.ЗагрязняющиеВеществаЗагрязняющееВещество.ОграничениеТипа = Новый ОписаниеТипов("СправочникСсылка.ВеществаИПараметрыВАтмосферныхОсадках");
		Элементы.ЗагрязняющиеВеществаЗагрязняющееВещество.ВыбиратьТип 	  = Ложь;
		
		Элементы.ОсновноеОбъектЗагрязнения.Видимость = Ложь;
		Элементы.ОсновноеТочкаКонтроля.Видимость = Истина;
	КонецЕсли;
	
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьУникальныйИдентификаторСтроки(СтрокаТабличнойЧасти, Копирование = Ложь);
	
	Если СтрокаТабличнойЧасти <> Неопределено Тогда 
		Если Не ЗначениеЗаполнено(СтрокаТабличнойЧасти.КлючСтроки) ИЛИ Копирование Тогда 
			СтрокаТабличнойЧасти.КлючСтроки = Новый УникальныйИдентификатор();
		КонецЕсли; // Если Не ЗначениеЗаполнено(СтрокаТабличнойЧасти.УникальныйИдентификатор) ИЛИ Копирование Тогда  
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьОтветНаВопросОбУдаленииСтрокиОбъектовЗагрязнения(Результат, ДопПараметры) Экспорт 
	
	Если Результат = КодВозвратаДиалога.Да Тогда 
		
		Для Каждого СтрокаУдаления Из ДопПараметры.МассивСтрокДляУдаления Цикл 
			
			Объект.ЗагрязняющиеВещества.Удалить(СтрокаУдаления);
			
		КонецЦикла; // Для Каждого СтрокаУдаления Из МассивСтрокДляУдаления Цикл 	
		
		Объект.Основное.Удалить(ДопПараметры.ТекСтрока);
		
	КонецЕсли; // Если Результат = КодВозвратаДиалога.Да Тогда	
	
КонецПроцедуры // Процедура ОбработатьОтветНаВопросОбУдаленииСтрокиОбъектовЗагрязнения(Результат, МассивСтрокДляУдаления)


&НаКлиенте
Процедура ВыполнитьПослеЗакрытияПланированияОтбора(Результат, ДополнительныеПараметры) Экспорт

	Если Результат <> Неопределено Тогда

		ПолучитьДанныеПланированияОтбораИзВременногоХранилища(Результат);	
		
		Модифицированность = Истина;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ПоместитьДанныеПланированияОтбораВоВременноеХранилище()
	
	ТаблицаПланированияОтбора = Объект.Основное.Выгрузить(, "ПлановаяДатаОт, ПлановаяДатаДо, Организация, ТочкаКонтроля");
	ТаблицаПланированияОтбора.Колонки.ТочкаКонтроля.Заголовок = "Точка контроля";
	
	// Для формы планироания событий требуются колонки "ДатаНачала", "ДатаОкончания"
	// Набор остальных колонок может быть произвольным, они будут созданы динамически
	ТаблицаПланированияОтбора.Колонки.Вставить(0, "ДатаНачала");
	ТаблицаПланированияОтбора.Колонки.Вставить(1, "ДатаОкончания");
	Для каждого ПланированиеОтбора из ТаблицаПланированияОтбора Цикл
		ПланированиеОтбора.ДатаНачала = ПланированиеОтбора.ПлановаяДатаОт;
		ПланированиеОтбора.ДатаОкончания = ПланированиеОтбора.ПлановаяДатаДо;
	КонецЦикла;
	ТаблицаПланированияОтбора.Колонки.Удалить("ПлановаяДатаОт");
	ТаблицаПланированияОтбора.Колонки.Удалить("ПлановаяДатаДо");
		
	Возврат ПоместитьВоВременноеХранилище(ТаблицаПланированияОтбора, УникальныйИдентификатор);
	
КонецФункции

&НаСервере
Процедура ПолучитьДанныеПланированияОтбораИзВременногоХранилища(АдресВременногоХранилища)
	
	ТаблицаПланированияОтбора = ПолучитьИзВременногоХранилища(АдресВременногоХранилища);
	Для каждого ПланированиеОтбора из ТаблицаПланированияОтбора Цикл
		
		Отбор = новый Структура;
		Отбор.Вставить("Организация", ПланированиеОтбора.Организация);
		Отбор.Вставить("ТочкаКонтроля", ПланированиеОтбора.ТочкаКонтроля);
		НайденныеСтроки = Объект.Основное.НайтиСтроки(Отбор);
		Для каждого НайденнаяСтрока из НайденныеСтроки Цикл
			НайденнаяСтрока.ПлановаяДатаОт = ПланированиеОтбора.ДатаНачала;
			НайденнаяСтрока.ПлановаяДатаДо = ПланированиеОтбора.ДатаОкончания;
		КонецЦикла;
		
	КонецЦикла;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ОбновитьФорму();
КонецПроцедуры


&НаКлиенте
Процедура ВидГрафикаПриИзменении(Элемент)
	Объект.Основное.Очистить();
	Объект.ЗагрязняющиеВещества.Очистить();
	
	ОбновитьФорму();
КонецПроцедуры


&НаКлиенте
Процедура ОсновноеПриАктивизацииСтроки(Элемент)
	ТекСтрока = Элемент.ТекущиеДанные;
	
	Если ТекСтрока <> Неопределено Тогда 
		
		СтруктураОтбора = Новый Структура("КлючСтроки", ТекСтрока.КлючСтроки);		
		Элементы["ЗагрязняющиеВещества"].ОтборСтрок = Новый ФиксированнаяСтруктура(СтруктураОтбора);
		
	Иначе
		СтруктураОтбора = Новый Структура("КлючСтроки", "");		
		Элементы["ЗагрязняющиеВещества"].ОтборСтрок = Новый ФиксированнаяСтруктура(СтруктураОтбора);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОсновноеПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	СтрокаТЧ = Элемент.ТекущиеДанные;		
	ЗаполнитьУникальныйИдентификаторСтроки(СтрокаТЧ, Копирование);
КонецПроцедуры

&НаКлиенте
Процедура ОсновноеПередУдалением(Элемент, Отказ)
	ТекСтрока = Элемент.ТекущиеДанные;
	Отказ = Истина;
	
	Если ТекСтрока <> Неопределено Тогда 
		Отбор = Новый Структура;
		Отбор.Вставить("КлючСтроки", ТекСтрока.КлючСтроки);
		
		МассивСтрокДляУдаления = Объект.ЗагрязняющиеВещества.НайтиСтроки(Отбор);
		
		ДопПараметры = Новый Структура("МассивСтрокДляУдаления, ТекСтрока", МассивСтрокДляУдаления, ТекСтрока);
		
		Если МассивСтрокДляУдаления.Количество() > 0 Тогда 
			
			Оповещание = Новый ОписаниеОповещения("ОбработатьОтветНаВопросОбУдаленииСтрокиОбъектовЗагрязнения", ЭтаФорма, ДопПараметры);	
			ПоказатьВопрос(Оповещание, НСтр("ru = 'Строки таблицы ""Загрязняющие вещества"" будут удалены. Продолжить?';"), РежимДиалогаВопрос.ДаНет);
			
		Иначе 	
			
			Отказ = Ложь;
			
		КонецЕсли; // Если МассивСтрокДляУдаления.Количество() > 0 Тогда 		
		
	КонецЕсли; // Если ТекСтрока <> Неопределено Тогда
КонецПроцедуры

&НаКлиенте
Процедура ОсновноеПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	Если Не ЗначениеЗаполнено(Объект.ВидГрафика) Тогда
		Сообщить("Вид графика не заполнен!");
		Отказ = Истина;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОсновноеОбъектЗагрязненияПриИзменении(Элемент)
	Если ТипЗнч(Элементы.Основное.ТекущиеДанные.ОбъектЗагрязнения) = Тип("СправочникСсылка.ВодныеОбъекты") Тогда
		ОсновноеОбъектЗагрязненияПриИзмененииНаСервере()
	Иначе
		ОбновитьФорму();
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ОсновноеОбъектЗагрязненияПриИзмененииНаСервере()
	НоваяСвязь = Новый СвязьПараметраВыбора("Отбор.ОбъектКонтроля", "Элементы.Основное.ТекущиеДанные.ОбъектЗагрязнения");
	
	НовыйМассив = Новый Массив();
	НовыйМассив.Добавить(НоваяСвязь);
	
	НовыеСвязи = Новый ФиксированныйМассив(НовыйМассив);
	
	Элементы.ОсновноеТочкаКонтроля.СвязиПараметровВыбора = НовыеСвязи;
КонецПроцедуры

&НаКлиенте
Процедура ОсновноеОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	Если ТипЗнч(ВыбранноеЗначение) = Тип("ДокументСсылка.ПланГрафикЭкоаналитическогоКонтроля") Тогда
		ОсновноеОбработкаВыбораНаСервере(ВыбранноеЗначение);
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ОсновноеОбработкаВыбораНаСервере(ПланГрафик)
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ВидГрафика", Объект.ВидГрафика);
	Запрос.УстановитьПараметр("Ссылка", ПланГрафик);
	Запрос.Текст = "ВЫБРАТЬ
	               |	ПланГрафикЭкоаналитическогоКонтроляОбъектыЗагрязнения.ЗагрязняющийОбъект,
	               |	ПланГрафикЭкоаналитическогоКонтроляОбъектыЗагрязнения.ТочкаКонтроля,
	               |	ПланГрафикЭкоаналитическогоКонтроляОбъектыЗагрязнения.КоличествоЗамеров,
	               |	ПланГрафикЭкоаналитическогоКонтроляОбъектыЗагрязнения.ПериодичностьЗамеров,
	               |	ПланГрафикЭкоаналитическогоКонтроляОбъектыЗагрязнения.ОсуществлениеКонтроля,
	               |	ПланГрафикЭкоаналитическогоКонтроляОбъектыЗагрязнения.УникальныйИдентификатор
	               |ИЗ
	               |	Документ.ПланГрафикЭкоаналитическогоКонтроля.ОбъектыЗагрязнения КАК ПланГрафикЭкоаналитическогоКонтроляОбъектыЗагрязнения
	               |ГДЕ
	               |	ПланГрафикЭкоаналитическогоКонтроляОбъектыЗагрязнения.Ссылка = &Ссылка
	               |	И ПланГрафикЭкоаналитическогоКонтроляОбъектыЗагрязнения.РазделУчета = &ВидГрафика";
				   
	Результат = Запрос.Выполнить().Выгрузить();
	
	Если Результат.Количество() = 0 Тогда
		Сообщить("Нет данных для заполнения");
		Возврат;
	КонецЕсли;
	
	Для Каждого Строка Из Результат Цикл
		
		НоваяСтрока = Объект.Основное.Добавить();
		
		НоваяСтрока.Организация 				= ПланГрафик.Организация;
		НоваяСтрока.ОбъектЗагрязнения 			= Строка.ЗагрязняющийОбъект;
		НоваяСтрока.ТочкаКонтроля				= Строка.ТочкаКонтроля;
		НоваяСтрока.КоличествоЗамеров			= Строка.КоличествоЗамеров;
		НоваяСтрока.ПериодичностьЗамеров		= Строка.ПериодичностьЗамеров;
		НоваяСтрока.КемОсуществляетсяКонтроль 	= Строка.ОсуществлениеКонтроля;
		НоваяСтрока.КлючСтроки 					= Новый УникальныйИдентификатор();
		
		ПараметрыОтбора = Новый Структура;
		ПараметрыОтбора.Вставить("УникальныйИдентификатор", Строка.УникальныйИдентификатор);

		НайденныеСтроки = ПланГрафик.ЗагрязняющиеВещества.НайтиСтроки(ПараметрыОтбора);
		
		Для Каждого СтрокаЗВ Из НайденныеСтроки Цикл
			
			НоваяСтрокаЗВ = Объект.ЗагрязняющиеВещества.Добавить();
			
			НоваяСтрокаЗВ.ЗагрязняющееВещество = СтрокаЗВ.ЗагрязняющееВещество;
			
			НоваяСтрокаЗВ.КлючСтроки = НоваяСтрока.КлючСтроки;
			
		КонецЦикла;		
		
	КонецЦикла;
	
	//заполним методики
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Лаборатория", Объект.Лаборатория);
	Запрос.УстановитьПараметр("РазделУчета", Объект.ВидГрафика);
	Запрос.УстановитьПараметр("ТаблицаЗВ", Объект.ЗагрязняющиеВещества.Выгрузить());
	Запрос.Текст = "ВЫБРАТЬ
	               |	ТаблицаЗВ.ЗагрязняющееВещество,
	               |	ТаблицаЗВ.КлючСтроки,
	               |	ТаблицаЗВ.МетодикаАнализа
	               |ПОМЕСТИТЬ втТаблицаЗВ
	               |ИЗ
	               |	&ТаблицаЗВ КАК ТаблицаЗВ
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ
	               |	лис_ПриложениеКАттестатуАккредитации.ЗагрязняющееВещество,
	               |	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ лис_ПриложениеКАттестатуАккредитации.Методика) КАК КоличествоМетодик,
	               |	МАКСИМУМ(лис_ПриложениеКАттестатуАккредитации.Методика) КАК Методика
	               |ПОМЕСТИТЬ втМетодики
	               |ИЗ
	               |	РегистрСведений.лис_ПриложениеКАттестатуАккредитации КАК лис_ПриложениеКАттестатуАккредитации
	               |ГДЕ
	               |	лис_ПриложениеКАттестатуАккредитации.РазделУчета = &РазделУчета
	               |	И лис_ПриложениеКАттестатуАккредитации.Лаборатория = &Лаборатория
	               |	И лис_ПриложениеКАттестатуАккредитации.ЗагрязняющееВещество В
	               |			(ВЫБРАТЬ
	               |				втТаблицаЗВ.ЗагрязняющееВещество
	               |			ИЗ
	               |				втТаблицаЗВ КАК втТаблицаЗВ)
	               |
	               |СГРУППИРОВАТЬ ПО
	               |	лис_ПриложениеКАттестатуАккредитации.ЗагрязняющееВещество
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ
	               |	втТаблицаЗВ.ЗагрязняющееВещество,
	               |	втТаблицаЗВ.КлючСтроки,
	               |	ВЫБОР
	               |		КОГДА втТаблицаЗВ.МетодикаАнализа = ЗНАЧЕНИЕ(Справочник.МетодикиОпределенияИзмеренияАнализа.ПустаяСсылка)
	               |				ИЛИ втТаблицаЗВ.МетодикаАнализа ЕСТЬ NULL
	               |			ТОГДА втМетодики.Методика
	               |		ИНАЧЕ втТаблицаЗВ.МетодикаАнализа
	               |	КОНЕЦ КАК МетодикаАнализа
	               |ИЗ
	               |	втТаблицаЗВ КАК втТаблицаЗВ
	               |		ЛЕВОЕ СОЕДИНЕНИЕ втМетодики КАК втМетодики
	               |		ПО втТаблицаЗВ.ЗагрязняющееВещество = втМетодики.ЗагрязняющееВещество
	               |			И (втМетодики.КоличествоМетодик = 1)";
	Объект.ЗагрязняющиеВещества.Загрузить(Запрос.Выполнить().Выгрузить());
КонецПроцедуры


&НаКлиенте
Процедура ЗагрязняющиеВеществаПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	Если НоваяСтрока Тогда 
		ТекСтрокаОбъектыЗагрязнения = Элементы.Основное.ТекущиеДанные;
		
		Если ТекСтрокаОбъектыЗагрязнения <> Неопределено Тогда
			
			ТекСтрока = Элемент.ТекущиеДанные;
			ТекСтрока.КлючСтроки = ТекСтрокаОбъектыЗагрязнения.КлючСтроки;
			
		Иначе
		    Сообщить("Не выбрана строка плана!");
			Отказ = Истина;
			Возврат;
		КонецЕсли; // Если ТекСтрокаОбъектыЗагрязнения <> Неопределено Тогда	
		
	КонецЕсли; // Если НоваяСтрока Тогда
КонецПроцедуры

&НаКлиенте
Процедура ЗагрязняющиеВеществаПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	ТекСтрокаОбъектыЗагрязнения = Элементы.Основное.ТекущиеДанные;
	
	Если ТекСтрокаОбъектыЗагрязнения = Неопределено Тогда
		
		Сообщить("Не выбрана строка плана!");
		Отказ = Истина;
	КонецЕсли; // Если ТекСтрокаОбъектыЗагрязнения <> Неопределено Тогда
КонецПроцедуры


&НаКлиенте
Процедура ЗаполнитьИзПланГрафика(Команда)
	Форма = ПолучитьФорму("Документ.ПланГрафикЭкоаналитическогоКонтроля.ФормаВыбора", , Элементы.Основное);
	Форма.Открыть();
КонецПроцедуры

&НаКлиенте
Процедура ПланироватьОтбор(Команда)
	
	ПараметрыПланированияОтбора = новый Структура;
	ПараметрыПланированияОтбора.Вставить("АдресВременногоХранилища", ПоместитьДанныеПланированияОтбораВоВременноеХранилище());
	
	ВыполнитьПослеЗакрытияПланированияОтбора = новый ОписаниеОповещения("ВыполнитьПослеЗакрытияПланированияОтбора", ЭтотОбъект);
	
	ОткрытьФорму("Документ.лис_ПланОтбораПроб.Форма.ФормаПланированияСобытий", ПараметрыПланированияОтбора, ЭтаФорма, , ВариантОткрытияОкна.ОтдельноеОкно, , ВыполнитьПослеЗакрытияПланированияОтбора, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);

КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	Перем Поле;
	
	// период
	Если ЗначениеЗаполнено(Объект.ПериодС) И ЗначениеЗаполнено(Объект.ПериодПо)  Тогда
		Если (Объект.ПериодПо < Объект.ПериодС) Тогда
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Дата окончания периода должна быть больше даты начала периода '"),,"ПериодПо","Объект",Отказ);
		КонецЕсли;
	КонецЕсли;
	
	// Основное - плановые даты
	Для каждого ТекСтр Из Объект.Основное Цикл
		Если ТекСтр.ПлановаяДатаОт > ТекСтр.ПлановаяДатаДо Тогда
			Поле = ОбщегоНазначенияКлиентСервер.ПутьКТабличнойЧасти("Основное",ТекСтр.НомерСтроки,"ПлановаяДатаОт");
            ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Нижняя граница диапазона должна быть меньше или равна верхней'"),,Поле,"Объект",Отказ);
		КонецЕсли; 
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	// вызовем проверку заполнения дополнительно при записи (при проведении вызывается автоматически)
	Если ПараметрыЗаписи.РежимЗаписи = РежимЗаписиДокумента.Запись Тогда
		Отказ = НЕ ПроверитьЗаполнение();
	КонецЕсли;
КонецПроцедуры


#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыОсновное

&НаКлиенте
Процедура ОсновноеПередОкончаниемРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования, Отказ)
	
	// проверим на дубль
	Если Не ОтменаРедактирования Тогда
		ПроверитьДублированиеСтрок_Основное(Элемент, Отказ);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Выполняет проверку добавляемой строки на дубли с табличной части
//
// Параметры:
//  ИмяТабличнойЧасти		 - Строка - имя табличной части объекта
//  КлючевыеРеквизиты		 - Структура - Ключ - имя реквизита; Значение - значение
//  НомерРедактируемойСтроки - Число - номер редактируемой строки 
//  СтрокиДубли			 	 - Массив - (возвращаемый) массив номеров строк-дублей
// 
// Возвращаемое значение:
//   Булево - Истина - строк с такими же значениями ключевых реквизитов нет
//
&НаСервере
Функция ЭтоУникальнаяСтрока(ИмяТабличнойЧасти, КлючевыеРеквизиты, НомерРедактируемойСтроки, СтрокиДубли = Неопределено)
	Перем Результат, НайденныеСтроки;
	
	Результат = Истина;
	НайденныеСтроки = Объект[ИмяТабличнойЧасти].НайтиСтроки(КлючевыеРеквизиты);
	
	Для каждого ТекСтрока Из НайденныеСтроки Цикл
		Если ТекСтрока.НомерСтроки <> НомерРедактируемойСтроки Тогда
			Результат = Ложь;
			Если СтрокиДубли = Неопределено Тогда // не требуется возвращать массив найденных строк-дублей
				Прервать;
			Иначе
				СтрокиДубли.Добавить(ТекСтрока.НомерСтроки);
			КонецЕсли; 
		КонецЕсли; 
	КонецЦикла;
		
	Возврат Результат;
КонецФункции


// Проверяет дублирование строк, сообщает об ошибке
//
// Параметры:
//	Элемент 		- ТаблицаФормы  - таблица формы в которой редактируется строка
//  Отказ	 		- Булево - возвращаемый параметр. Истина - обнаружены дубли строк
//	ЭтоФизФактор    - Булево - влияет на текст ссобщения об ошибке. Истина - фактор физического воздействия, Ложь - загрязняющее вещество.
//
&НаКлиенте
Процедура ПроверитьДублированиеСтрок_Основное(Элемент, Отказ)
	
	СтрокиДубли = Новый Массив;
	
	КлючевыеРеквизиты = Новый Структура("Организация, ОбъектЗагрязнения, ТочкаКонтроля, КемОсуществляетсяКонтроль");
	ЗаполнитьЗначенияСвойств(КлючевыеРеквизиты,Элемент.ТекущиеДанные);
	Если НЕ ЭтоУникальнаяСтрока("Основное", КлючевыеРеквизиты, Элемент.ТекущиеДанные.НомерСтроки, СтрокиДубли) Тогда
		СообщениеОбОшибке = "Строка №"+Элемент.ТекущиеДанные.НомерСтроки+" частично или полностью дублирует данные в строке №"+СтрокиДубли[0]+". Если это не ошибка сообщение можно игнорировать.";
		
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(СообщениеОбОшибке,,"Основное["+(Элемент.ТекущиеДанные.НомерСтроки-1)+"].НомерСтроки","Объект");
	КонецЕсли;

КонецПроцедуры // ПроверитьДублированиеСтрок_Основное()

#КонецОбласти
