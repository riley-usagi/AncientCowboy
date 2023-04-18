# Ancient Cowboy: Idle-игра

Этот репозиторий содержит базовую версию игры, созданной на основе архитектуры EV (**Level: Hard**).

Основной особенностью этого проекта является новый подход к работе с потоком данных в приложении.

🚫 Нет классов. Нет проблем с ARC. Нет ObservedObject, StateObject или EnvironmentObject. Нет проблем, связанных с работой с иерархией View.

## Принцип работы

Есть [перечисление](https://github.com/riley-usagi/AncientCowboy/blob/master/AncientCowboy/Enums/EventEnum.swift), которое содержит все возможные события в приложении, а также список всех действий, которые происходят при возникновении определенного события.

Каждая View в приложении содержит список действий ([пример](https://github.com/riley-usagi/AncientCowboy/blob/master/AncientCowboy/Screens/Inventory/InventoryScreen.swift#L59-L65)), которые происходят только внутри нее.

Вызывая одно событие, вы можете выполнить несколько действий по всему приложению (даже за пределами View).



## Установка

Чтобы использовать этот проект, выполните следующие шаги:

1. Клонируйте репозиторий
2. Откройте проект в Xcode
3. Соберите и запустите проект

## Использование

Чтобы использовать этот проект, просто запустите приложение и начните играть в игру.

## Вклад

Вклады всегда приветствуются! Если у вас есть какие-либо идеи для новых функций,
исправлений ошибок или других улучшений, пожалуйста, создайте issue или pull request.
