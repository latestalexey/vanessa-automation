﻿# vanessa-automation

[![Открытый чат проекта https://gitter.im/vanessa-automation](https://badges.gitter.im/vanessa-automation.svg)](https://gitter.im/vanessa-automation?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![Build Status](http://84.237.195.35:32005/buildStatus/icon?job=VAFullCheck)](http://84.237.195.35:32005/job/VAFullCheck/)

## BDD for 1С:Enterprise

Текущий релиз в ветке [Master: 1.2.019](https://github.com/Pr-Mex/vanessa-automation/tree/master)
Разработка ведется в ветке [Develop](https://github.com/Pr-Mex/vanessa-automation/tree/develop).

В данном репозитории хранятся только исходники.
Вы можете собрать необходимые файлы сами, либо скачать готовую сборку в [релизах](https://github.com/Pr-Mex/vanessa-automation/releases).
При первом скачивании репозитория необходимо собрать файлы обработок.
1. Чтобы работала сборка epf надо установить [OneScript](http://oscript.io) версии 1.0.20 или выше.
2. Также, чтобы работала сборка epf надо установить платформу [1С:Предприятие 8.3.10](https://releases.1c.ru).
3. Для запуска сборки epf из исходников надо запустить Compile.bat
4. Скрипты по сборке/разборке файлов взяты [отсюда](https://github.com/Pr-Mex/ExternalModulesConverterFor1C)

Чтобы зафиксировать изменения epf файлов, нужно запустить Decompile.bat.

Проект использует принцип формирования автодокументации в формате Markdown и видео:
* Видео инструкции лежат [здесь](https://www.youtube.com/channel/UC114RqHhG__1gET8pzs3AHA/playlists) 
* Также рекомендуется посмотреть вот [этот вебинар](http://infostart.ru/webinars/537546/) 
* Возможно вам поможет [этот FAQ](https://github.com/Pr-Mex/vanessa-automation/blob/develop/F.A.Q.MD)

Чтобы у вас работало автосоздание видеоинструкций необходимо установить дополнительный софт. Инструкция [здесь](https://github.com/Pr-Mex/vanessa-automation/blob/develop/MakeAutoVideo.md) 
Также по автовидеоинструкциям есть вот это замечательное [видео](https://www.youtube.com/watch?v=BfXowJH5uP0)

Список отличий проекта Vanessa-automation от проекта ADD можно посмотреть [тут](https://github.com/Pr-Mex/vanessa-automation/blob/develop/NotAdd.MD)

Порядок установки Vanessa-Automation под Windows:
* [интерпретатор 1Script](http://oscript.io/downloads) - для работы с иходными файлами 1С с помощью проекта Precommit1C
* [утилита Allure](http://allure.qatools.ru/) - для формирования отчётов о результатах прохождения тестов

Все должно быть установлено так, чтобы быть доступным через переменную `%PATH%`

Клонируйте данный репозиторий с помощью **ms-git**

```
git clone https://github.com/Pr-Mex/vanessa-automation.git
```

Инициализируйте подмодули репозитория с помощью **ms-git**

```
git submodule update --init --recursive
```

При использовании `SourceTree` используйте команду `Clone (Клонировать)`

Обязательно ознакомьтесь с:
* руководством контрибьютора [CONTRIBUTING.md](./.github/CONTRIBUTING.md)
* известные проблемы [KNOWN-PROBLEMS.md](./doc/KNOWN-PROBLEMS.md)

## Описание простого использования

* пишем feature файлы в формате Gherkin - обычно используется редактор Notepad++, Sublime IDE (Vanessa Extension) или связанный проект **vanessa-bdd-editor**

```Gherkin

# encoding: utf-8
# language: ru

Функционал: Запуск и получение результатов запуска сценариев
Как любой разработчик продукта
Я хочу иметь возможность запустить проверку сценариев поведения на конфигурации 1С:Предприятие

# Контекст сценария выполняется всегда перед каждым сценарием

Контекст:
Когда существует разрабатываемая мною конфигурация 1С
И существуют требования заказчика к ожидаемому поведения в каталоге ".\features"

# Каждый сценарий состоит из последовательных связанных шагов

Сценарий: Запуск в консольном режиме
Дано Пусть существует файл ".\vb-execute-profile.json"
И в переменную окружения V83PATH установлено значение "C:\Program Files (x86)\1cv8\8.3.6.2151\bin\1cv8.exe"
Когда я запускаю командную строку '%V83PATH% /Execute .\vanessa-automation.epf /C"StartFeaturePlayer;VBParams=.\vb-execute-profile.json'
Тогда появляется файл с результатами '.\BuildStatus.log'
И в каталоге ".\allurereport" существует HTML отчет о результатах проверки сценариев

Сценарий: Запуск в интерактивном режиме
Дано Пусть я открыл обработку "vanessa-automation.epf"
Когда Я нажал кнопку "Загрузить фичи из каталога"
И указал каталог с требованиями заказчика равным ".\features"
И затем нажал кнопку "Сгенерировать шаблоны обработок"
Также в каталоге ".\features" возникли epf файлы идентичные имени feature файла
И при нажатии кнопки "Запустить сценарии" я вижу автоматизированный запуск обработок с признаком "pending" (ожидает реализации)
```

### Классический вариант использования (без интерактивного режима)

Фактически классический вариант использования представляет собой следующий рутинный порядок:
* зафиксировали требования к информационной системе;
* создали автоматизированные сценарии проверки в виде epf файлов;
* наполнили шаги сценариев (сниппеты) кодом проверки поведения;
* запустили сценарии проверки поведения и убедились, что они НЕ работают;
* разработали функционал;
* запустили сценарии проверки поведения;
* убедились что сценарии проверки работают и отчет о проверки показывает "Зелёный" статус.

### Использование в режиме проверки поведения пользовательского интерфейса

Для команд уже имеющих функционал или производящих доработку типовых конфигураций в интерфейсе Taxi, действует упрощенный порядок использования:
* зафиксировали требования к информационной системе;
* создали автоматизированные сценарии проверки в виде epf файлов;
* разработали управляемые формы или рабочие столы конфигурации в режиме прототипирования;
* запустили запись интерактивных действий пользователя в режиме **менеджера тестирования**;
* получившимся кодом наполнили обработки проверки поведения;
* дополнили код проверки, кодом проверки данных если это необходимо;
* разработали основной функционал;
* запустили сценарии проверки поведения;
* убедились что сценарии проверки работают и отчет о проверки показывает "Зелёный" статус.

## Кто пишет feature файлы ?

Обратите внимание, что фактически feature файлы могут писать все участники команды:
* менеджер проекта - если обнаружил что заказчику необходимо новое поведение;
* бизнес или системный аналитик - на основе собранных требований и технических заданий;
* ведущий разработки - если обнаружил, что требования недостаточно структурированы;
* архитектор или эксперт 1С - если текущие сценарии некорректно спроектированы с точки зрения метаданных.
* тестироровщик - когда пишет сценарии для проверки поведения

Если вы не уверены в правильности ожидаемого поведения, используйте для этого системы тэгов, как то:
* "@Draft@"  - черновик требования
* "@Предварительно" - начальные заметки

и подобные им обозначения

## Файл профиля запуска обработки

Для запуска в консольном режиме используется понятие *профиль консольного запуска*. Профиль консольного запуска предназначен для удобной передачи параметров. Профиль запуска представляет собой текстовый файл в формате JSON.

Текущие параметры запуска:
* **Каталог фич** - каталог где собраны требования заказчика описанные на языке Gherkin
* **ВыполнитьСценарии** - признак того, что необходимо запустить выполнение сценариев
* **ДелатьОтчетВФорматеАллюр** - признак того, что необходимо формировать HTML отчёт о результатах проверки
* **КаталогOutputAllureБазовый** - адрес каталога для где будет формироваться HTML отчёт
* **ЗавершитьРаботуСистемы** - признак того, что окончанию работы необходимо завершить работу 1С предприятия
* **ВыгружатьСтатусВыполненияСценариевВФайл** - признак, что необходимо формировать файл с финальным статусом проверки
* **ПутьКФайлуДляВыгрузкиСтатуасВыполненияСценариев** - по данному пути будет сформирован файл со статусом проверки (обычно используется на серверах сборки для автоматизированного указания статуса сборки)
* **СписокТеговИсключение** - массив текстовых тэгов, для исключения из проверки (используется например для черновиков сценариев и требований)
* **СписокТеговОтбор** - массив текстовых тэгов для запуска проверки поведения по сценариям, содержащим любой из указанных тэгов

Пример подобного JSON файла можно найти [здесь](https://github.com/Pr-Mex/vanessa-automation/tree/develop/tools/JSON)


Профиль запуска предназначен для простого консольного запуска, пример подобной командной строки выглядит так:

```
%V83PATH% /Execute C:\vanessa-automation\vanessa-automation.epf /C"StartFeaturePlayer;VBParams=C:\VBParams.json"
```

Примеры запуска можно увидеть в [данном каталоге](https://github.com/Pr-Mex/vanessa-automation/tree/develop/tools/JSON)

## Загрузка глобальных переменных из внешнего файла
Чтобы не зашивать в тесты все плавающие пользовательские переменные, такие как имена баз, строки подключения, логины, пароли и др., имеется возможность вынести эти переменные во внешний файл user_settings.json. Это может быть особенно полезно, когда над фичами работает команда, и у каждого участника существуют свои настройки подключения к базам.
   
Чтобы воспользоваться этой функциональности, нужно выполнить следующее:

 1.  У себя в каталоге с обработкой ванессы создать файл user_settings.json. Сам файл user_settings.json должен отвечать специальному формату:
``` json
{
    "userSettings": [
        {
            "user": "USERNAME_1",
            "settings": {
                "ИМЯ_ПЕРЕМЕННОЙ_1": "ЗНАЧЕНИЕ_ПЕРЕМЕННОЙ_1",
                "ИМЯ_ПЕРЕМЕННОЙ_2": "ЗНАЧЕНИЕ_ПЕРЕМЕННОЙ_2",
            }
        },
        {
            "user": "USERNAME_2",
            "settings": {
                "ИМЯ_ПЕРЕМЕННОЙ_1": "ЗНАЧЕНИЕ_ПЕРЕМЕННОЙ_1",
                "ИМЯ_ПЕРЕМЕННОЙ_2": "ЗНАЧЕНИЕ_ПЕРЕМЕННОЙ_2",
            }
        }
    ]
}
```

2. В свойства user поставить доменное (локальное) имя пользователя, для которого должны применяться настройки. Именно по этому свойству будет определяться, какие пользовательские настройки нужно загружать.

3. В свойстве settings прописать конкретные настройки для каждого пользователя. Состав настроек необязательно должен совпадать между пользователями, для какого-то пользователя настройки могут отсутствовать. 

4. Открыть обработку AD - файл user_settings.json подтянется автоматически из каталога, в котором находится AD (поле каталог инструментов на вкладке Сервис). Если такого файла нет, то загрузка молча игнорируется. Имеется возможность указать свой каталог загрузки настроек, он подчиняется свойству Каталог проекта на вкладке Сервис.
    
Если файл найден, то на основании текущего имени пользователя компьютера или домена (которое определяется через WShell скрипт), ищутся настройки текущего пользователя и загружаются только они. Если настройки не найдены, то выводится предупредительное сообщение.


## ЧаВо
Находится [здесь](https://github.com/Pr-Mex/vanessa-automation/blob/develop/F.A.Q.MD)

## Замечания:

* пожелания к использованию можно фиксировать в виде Github Issues;

## Родительский проект

* Проект Vanessa-Automation является продолжением проекта [Vanessa-Behavior 1.1.131](https://github.com/silverbulleters/vanessa-behavior)

## Полезные ссылки:

* [Cucumber](https://cukes.info/)
* [Автоматизированное тестирование 1С](http://v8.1c.ru/overview/Term_000000816.htm)
* [Yandex Allure](http://allure.qatools.ru/)
* [Selenium](http://docs.seleniumhq.org/)
* [Дэн Норт](http://en.wikipedia.org/wiki/Acceptance_test-driven_development)
* [Vanessa-Automation — инструмент тестирования прикладных решений на платформе «1С: Предприятие» @Хабрахабр](https://habr.com/post/418303/)
* [Vanessa-Automation — инструмент автодокументирования прикладных решений на платформе «1С: Предприятие». Кино и BDD. @Хабрахабр](https://habr.com/post/420175/)


## Лицензии

* основная лицензия продукта - BSD v3
* лицензии стороннего кода - Apache License, GitHub CLA, Freeware, etc

