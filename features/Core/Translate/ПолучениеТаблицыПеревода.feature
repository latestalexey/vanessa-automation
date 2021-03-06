# language: ru

@IgnoreOn82Builds
@IgnoreOnOFBuilds
@IgnoreOnWeb
@IgnoreOn836
@IgnoreOn837




Функционал: Получение таблицы перевода

Как пользователь
Я хочу чтобы я мог получить таблицу перевода на экране
Чтобы я мог сделать перевод шагов на любой язык

Контекст: 
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий
	
	
	

Сценарий: Получение таблицы перевода
	Когда Я открываю VanessaAutomation в режиме TestClient со стандартной библиотекой
	
	Когда В поле с именем "КаталогФичСлужебный" я указываю путь к служебной фиче "ФичаДляПроверкиРаботыКеш"
	И     Я нажимаю на кнопку перезагрузить сценарии в Vanessa-Automation TestClient
	
	И     я перехожу к закладке "Сервис"
	И     из выпадающего списка "Язык генератора Gherkin" я выбираю "English"

	И     я перехожу к закладке "Работа с UI"

	И     я нажимаю на кнопку "Добавить известный шаг"
	Тогда открылось окно "Известные шаги: Vanessa Automation*"
	И     я нажимаю на кнопку "Показать перевод"
	
	Тогда открылось окно "Таблица"