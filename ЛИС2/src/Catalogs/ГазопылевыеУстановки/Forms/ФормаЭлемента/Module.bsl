
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЭффективностьПГОУ.Параметры.УстановитьЗначениеПараметра("ПГОУ", Объект.Ссылка);
	
	// Работа с бизнес-процессами
	Если Обработки.СозданиеНСИ.ИспользоватьМеханизмБизнесПроцессов( Объект.Ссылка ) Тогда
		БП_ПоддержкаБизнесПроцессовСервер.ОбработатьОткрытиеФормаОбъекта( ЭтотОбъект );
		ЭтотОбъект.ТолькоПросмотр = Не Обработки.СозданиеНСИ.ЭлементДоступенДляРедактирования( Объект.Ссылка );
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	// Работа с бизнес-процессами
	Если Обработки.СозданиеНСИ.ИспользоватьМеханизмБизнесПроцессов( Объект.Ссылка ) Тогда
		Обработки.СозданиеНСИ.ПроверитьЗаполнениеРеквизитов( ЭтотОбъект, Отказ );
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере( ТекущийОбъект, ПараметрыЗаписи )
	
	// Работа с бизнес-процессами
	ПослеЗаписиОбъектаБизнесПроцессаНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием( Отказ, СтандартнаяОбработка )
	
	// Работа с бизнес-процессами
	Если Не ЗакрыватьБезусловно И ЗадачаИсполнителяНеЗавершенаНаСервере() Тогда 
		текОповещение = Новый ОписаниеОповещения( "ПослеЗакрытияВопросаЗакрытиеФормы", ЭтотОбъект );	
		ПоказатьВопрос( текОповещение, "Отправить на согласование введенные данные о пылегазоочистной установке '" + Объект.Ссылка + "'?", РежимДиалогаВопрос.ДаНет );

		Отказ				= Истина;
		ЗакрыватьБезусловно = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПроцентОчисткиЗВПриИзменении( Элемент )

	ПроверитьКорректностьПроцентОчисткиНаСервере( Элементы.ПроцентОчисткиЗВ.ТекущаяСтрока );
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ПроверитьКорректностьПроцентОчисткиНаСервере( фпИдентификаторСтроки )	
	
	текСтрока = Объект.ПроцентОчисткиЗВ.НайтиПоИдентификатору( фпИдентификаторСтроки );
	Если текСтрока = Неопределено Или текСтрока.ПроцентОчистки = 0 Тогда 
		Возврат;
	КонецЕсли;

	стрРезультатПроверки = Справочники.ПриродоохранныеТехнологии.ПроверитьКорректностьПроцентОчистки( Объект.ПриродоохраннаяТехнология,
																									  текСтрока.ЗагрязняющееВещество,	
																									  текСтрока.ПроцентОчистки
																									);
	Если Не ПустаяСтрока( стрРезультатПроверки ) Тогда 
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю( стрРезультатПроверки );
		текСтрока.ПроцентОчистки = 0;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

// Работа с бизнес-процессами
#Область ФункцииБизнесПроцессов

&НаКлиенте
Процедура ВыполнитьЗадачу( Команда ) Экспорт
	
	Если Модифицированность Тогда
		текОповещение = Новый ОписаниеОповещения( "ПослеЗакрытияВопросаЗаписи", ЭтотОбъект, Команда );	
		ПоказатьВопрос( текОповещение, "Для выполнения операции объект должен быть записан. Записать?", РежимДиалогаВопрос.ДаНет );		
	Иначе
		стрКомментарий = "";
		
		текОповещение  = Новый ОписаниеОповещения( "ПослеВводаКомментария", ЭтотОбъект );	
		
		ПоказатьВводСтроки( текОповещение, стрКомментарий, "Введите комментарий выполненной задачи" );
		
		ЗавершитьЗадачуНаСервере( Команда.Имя );
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗакрытияВопросаЗаписи( Результат, Команда ) Экспорт
	
	Если Результат = КодВозвратаДиалога.Да Тогда 
		Записать();
		ВыполнитьЗадачу( Команда );
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗакрытияВопросаЗакрытиеФормы( Результат, ДополнительныеПараметры ) Экспорт
	
	Если Результат = КодВозвратаДиалога.Да Тогда 
		текКомандаВыполнения = ПолучитьКомандуВыполнения();
		Если текКомандаВыполнения <> Неопределено Тогда 
			ВыполнитьЗадачу( текКомандаВыполнения );
		КонецЕсли;
	Иначе
		Закрыть();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеВводаКомментария( фпКомментарий, фпПараметры ) Экспорт
	
	Если Не ПустаяСтрока( фпКомментарий ) Тогда
		УстановитьКомментарийЗадачиНаСервере( ЭтотОбъект.БП_ВыполняемаяЗадача, фпКомментарий );	
	КонецЕсли;
	
	Если Открыта() Тогда 
		Закрыть();
	КонецЕсли;
	
	Оповестить( "БП_ВыполнениеЗадачи", Объект.Ссылка );
	
КонецПроцедуры

&НаКлиенте
Процедура БП_ВыполнитьЗадачу( Команда )
	
	БП_ПоддержкаБизнесПроцессовКлиент.ВыполнитьЗадачу( ЭтотОбъект, Команда );
	
КонецПроцедуры

&НаКлиенте
Функция ПолучитьКомандуВыполнения()
	
	Для Каждого текКоманда Из Команды Цикл 	
		Если текКоманда.Действие = "БП_ВыполнитьЗадачу" Тогда 
			Возврат текКоманда;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции

&НаСервере
Функция ЗадачаИсполнителяНеЗавершенаНаСервере()
	
	Возврат ( Элементы.Найти( "БП_ВыполняемаяЗадача" ) <> Неопределено И
		 	  Не ЭтотОбъект["БП_ВыполняемаяЗадача"].Выполнена И
		 	  ЭтотОбъект["БП_ВыполняемаяЗадача"].ТочкаМаршрута.Порядок = 1 );
	
КонецФункции

&НаСервере
Процедура ЗапуститьБизнесПроцессСогласованияНаСервере()
	
	Обработки.СозданиеНСИ.ЗапуститьБизнесПроцессСогласования( Объект.Ссылка );
	
	БП_ПоддержкаБизнесПроцессовСервер.ОбработатьОткрытиеФормаОбъекта( ЭтотОбъект );
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиОбъектаБизнесПроцессаНаСервере()
	
	Если Обработки.СозданиеНСИ.ИспользоватьМеханизмБизнесПроцессов( Объект.Ссылка ) Тогда
		ЗапуститьБизнесПроцессСогласованияНаСервере();
	КонецЕсли;
	
КонецПроцедуры	

&НаСервере
Процедура ЗавершитьЗадачуНаСервере( фпИмяКоманды )

	текНомер  = Сред( фпИмяКоманды, 12 );
	текСтатус = ЭтаФорма["БП_Статус" + текНомер];
	
	БП_ПоддержкаБизнесПроцессовСервер.ЗавершитьЗадачу( ЭтотОбъект.БП_ВыполняемаяЗадача, ЭтотОбъект.БП_ВыполняемаяЗадача.БизнесПроцесс, текСтатус );

	Обработки.СозданиеНСИ.УстановитьРеквизитыПоБизнесПроцессу( ЭтотОбъект.БП_ВыполняемаяЗадача, Объект.Ссылка );
	
КонецПроцедуры	

&НаСервереБезКонтекста
Процедура УстановитьКомментарийЗадачиНаСервере( фпЗадача, фпКомментарий )
	
	Обработки.СозданиеНСИ.УстановитьРеквизитКомментарий( фпЗадача, фпКомментарий );
	
КонецПроцедуры

&НаКлиенте
Процедура ПриродоохраннаяТехнологияПриИзменении( Элемент )
	
	Если ЗначениеЗаполнено( Объект.ПриродоохраннаяТехнология ) Тогда
		Если Объект.ПроцентОчисткиЗВ.Количество() > 0 Тогда
			текОповещение = Новый ОписаниеОповещения( "ПослеЗакрытияВопросаЗаполнитьПроцентОчистки", ЭтотОбъект );	
			ПоказатьВопрос( текОповещение, "Перезаполнить табличную часть по природоохранной технологии?", РежимДиалогаВопрос.ДаНет );
		Иначе
			ЗаполнитьПроцентОчисткиЗВНаСервере();
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗакрытияВопросаЗаполнитьПроцентОчистки( Результат, ДополнительныеПараметры ) Экспорт
	
	Если Результат = КодВозвратаДиалога.Да Тогда
		ЗаполнитьПроцентОчисткиЗВНаСервере();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьПроцентОчисткиЗВНаСервере()
	
	Объект.ПроцентОчисткиЗВ.Загрузить( Объект.ПриродоохраннаяТехнология.Эффетивность.Выгрузить() )

КонецПроцедуры

&НаКлиенте
Процедура ЭффективностьПГОУПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	
	Отказ = Истина;
	
	Если Не Объект.Ссылка.Пустая() Тогда 
		
		ЗначенияЗаполнения = Новый Структура("ПылегазоочистнаяУстановка", Объект.Ссылка);
		ПараметрыОткрытия = Новый Структура("ЗначенияЗаполнения", ЗначенияЗаполнения);
		
		ОткрытьФорму("РегистрСведений.ЭффективностьПГОУ.ФормаЗаписи", ПараметрыОткрытия,,,,,,);
	Иначе
		ПоказатьПредупреждение(,НСтр("ru = 'Для ввода эффективности ПГОУ элемент справочника должен быть записан.'"));
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

