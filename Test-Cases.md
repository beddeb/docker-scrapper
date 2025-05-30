## Тест-кейсы

---
### **1. Тестирование Telegram Bot**

#### **TC-BOT-01: Инициализация бота**
- **ID**: TC-BOT-01  
- **Заголовок**: Проверка обработки команды `/start`  
- **Предусловия**: Бот запущен и доступен  
- **Шаги**:  
  1. Отправить команду `/start`  
- **Ожидаемый результат**:  
  - Приветственное сообщение с инструкциями  
  - Кнопки основных команд (если предусмотрены)  
- **Постусловия**: -  
- **Статус**: [ ] Success [ ] Failed [ ] Blocked  

#### **TC-BOT-02: Добавление валидного URL**
- **ID**: TC-BOT-02  
- **Заголовок**: Проверка команды `/track` с корректным URL  
- **Предусловия**: Пользователь авторизован  
- **Шаги**:  
  1. Отправить `/track https://example.com`  
  2. Запросить `/list`  
- **Ожидаемый результат**:  
  - Подтверждение добавления URL  
  - URL отображается в списке  
- **Постусловия**: Удалить URL через `/untrack`  
- **Статус**: [ ] Success [ ] Failed [ ] Blocked  

#### **TC-BOT-03: Добавление невалидного URL**
- **ID**: TC-BOT-03  
- **Заголовок**: Проверка обработки некорректного URL  
- **Шаги**:  
  1. Отправить `/track invalid-url`  
- **Ожидаемый результат**:  
  - Сообщение об ошибке валидации  
  - URL не добавляется в систему  
- **Постусловия**: -  
- **Статус**: [ ] Success [ ] Failed [ ] Blocked  

#### **TC-BOT-04: Удаление URL**
- **ID**: TC-BOT-04  
- **Заголовок**: Проверка команды `/untrack`  
- **Предусловия**: URL `https://example.com` добавлен ранее  
- **Шаги**:  
  1. Отправить `/untrack https://example.com`  
  2. Запросить `/list`  
- **Ожидаемый результат**:  
  - Подтверждение удаления  
  - URL отсутствует в списке  
- **Постусловия**: -  
- **Статус**: [ ] Success [ ] Failed [ ] Blocked  

#### **TC-BOT-05: Поиск по тегам**
- **ID**: TC-BOT-05  
- **Заголовок**: Проверка команды `/search`  
- **Предусловия**:  
  - Добавлены URL:  
    - `/track https://news.example.com --tag news`  
    - `/track https://tech.example.com --tag tech`  
- **Шаги**:  
  1. Отправить `/search news`  
- **Ожидаемый результат**:  
  - Отображается только `https://news.example.com`  
- **Постусловия**: Удалить тестовые URL  
- **Статус**: [ ] Success [ ] Failed [ ] Blocked  

---

### **2. Тестирование Scrapper Service**

#### **TC-SCR-01: Обнаружение изменений**
- **ID**: TC-SCR-01  
- **Заголовок**: Проверка реакции на изменение контента  
- **Предусловия**:  
  - URL с тестовой страницей добавлен в систему  
  - Контент страницы изменен вручную  
- **Шаги**:  
  1. Дождаться цикла проверки (или запустить вручную)  
  2. Проверить логи сервиса  
- **Ожидаемый результат**:  
  - В логах запись об обнаружении изменений  
  - Пользователь получает уведомление  
- **Постусловия**: Вернуть исходный контент  
- **Статус**: [ ] Success [ ] Failed [ ] Blocked  

#### **TC-SCR-02: Обработка недоступного ресурса**
- **ID**: TC-SCR-02  
- **Заголовок**: Проверка реакции на HTTP 404  
- **Предусловия**: URL ведет на несуществующую страницу  
- **Шаги**:  
  1. Добавить `/track http://invalid.example`  
  2. Проверить логи через 5 минут  
- **Ожидаемый результат**:  
  - Запись в логах о недоступности ресурса  
  - Отсутствие уведомлений пользователю  
- **Постусловия**: Удалить URL  
- **Статус**: [ ] Success [ ] Failed [ ] Blocked  

#### **TC-SCR-03: Проверка заголовков страницы**
- **ID**: TC-SCR-03  
- **Заголовок**: Обнаружение изменений в `<title>`  
- **Предусловия**: URL с изменяемым `<title>` добавлен в систему  
- **Шаги**:  
  1. Изменить `<title>` страницы  
  2. Дождаться цикла проверки  
- **Ожидаемый результат**:  
  - Уведомление об изменении заголовка  
- **Постусловия**: Вернуть исходный `<title>`  
- **Статус**: [ ] Success [ ] Failed [ ] Blocked  

---

### **3. Интеграционные тесты**

#### **TC-INT-01: Сквозное уведомление**
- **ID**: TC-INT-01  
- **Заголовок**: Проверка полного цикла от изменения до уведомления  
- **Предусловия**: Пользователь подписан на тестовый URL  
- **Шаги**:  
  1. Вручную изменить контент страницы  
  2. Дождаться выполнения проверки  
  3. Проверить Telegram-чат  
- **Ожидаемый результат**:  
  - Корректное уведомление с деталями изменений  
- **Постусловия**: Вернуть исходный контент  
- **Статус**: [ ] Success [ ] Failed [ ] Blocked  

#### **TC-INT-02: Восстановление после сбоя**
- **ID**: TC-INT-02  
- **Заголовок**: Проверка сохранения данных при рестарте  
- **Предусловия**: Есть активные подписки  
- **Шаги**:  
  1. Выполнить `docker-compose restart`  
  2. Запросить `/list`  
- **Ожидаемый результат**:  
  - Список подписок идентичен состоянию до перезапуска  
- **Постусловия**: -  
- **Статус**: [ ] Success [ ] Failed [ ] Blocked  

---

### **4. Тесты производительности**

#### **TC-PERF-01: Нагрузка 100+ URL**
- **ID**: TC-PERF-01  
- **Заголовок**: Проверка обработки большого числа ресурсов  
- **Шаги**:  
  1. Добавить 100 тестовых URL  
  2. Замерить время полного цикла проверки  
- **Ожидаемый результат**:  
  - Время цикла ≤ 15 минут  
  - Нет ошибок в логах  
- **Постусловия**: Очистить тестовые данные  
- **Статус**: [ ] Success [ ] Failed [ ] Blocked  

#### **TC-PERF-02: Параллельная обработка**
- **ID**: TC-PERF-02  
- **Заголовок**: Проверка многопоточной работы  
- **Шаги**:  
  1. Добавить 10 URL с искусственной задержкой ответа (3 сек)  
  2. Запустить проверку  
  3. Проанализировать логи  
- **Ожидаемый результат**:  
  - URL проверяются параллельно  
  - Общее время выполнения < 30 секунд  
- **Постусловия**: Удалить тестовые URL  
- **Статус**: [ ] Success [ ] Failed [ ] Blocked  

---

### **5. Тесты безопасности**

#### **TC-SEC-01: SQL-инъекции**
- **ID**: TC-SEC-01  
- **Заголовок**: Проверка устойчивости к инъекциям  
- **Шаги**:  
  1. Отправить `/track '; DROP TABLE subscriptions--`  
- **Ожидаемый результат**:  
  - Команда отклонена  
  - БД не повреждена  
- **Постусловия**: -  
- **Статус**: [ ] Success [ ] Failed [ ] Blocked  

#### **TC-SEC-02: XSS-атаки**
- **ID**: TC-SEC-02  
- **Заголовок**: Проверка фильтрации JavaScript  
- **Шаги**:  
  1. Отправить `/track javascript:alert(1)`  
- **Ожидаемый результат**:  
  - URL отклонен как небезопасный  
- **Постусловия**: -  
- **Статус**: [ ] Success [ ] Failed [ ] Blocked  

#### **TC-SEC-03: Доступ к внутренним ресурсам**
- **ID**: TC-SEC-03  
- **Заголовок**: Попытка доступа к localhost  
- **Шаги**:  
  1. Отправить `/track http://localhost:8081/admin`  
- **Ожидаемый результат**:  
  - URL отклонен с сообщением о запрете внутренних адресов  
- **Постусловия**: -  
- **Статус**: [ ] Success [ ] Failed [ ] Blocked  

---

### **6. Тесты API**

#### **TC-API-01: Swagger Documentation**
- **ID**: TC-API-01  
- **Заголовок**: Проверка доступности Swagger UI  
- **Шаги**:  
  1. Открыть `http://localhost:8080/swagger-ui.html`  
  2. Открыть `http://localhost:8081/swagger-ui.html`  
- **Ожидаемый результат**:  
  - Документация загружается без ошибок  
  - Доступны все задекларированные endpoints  
- **Постусловия**: -  
- **Статус**: [ ] Success [ ] Failed [ ] Blocked  

#### **TC-API-02: Health Check**
- **ID**: TC-API-02  
- **Заголовок**: Проверка эндпоинта здоровья  
- **Шаги**:  
  1. Отправить GET `/actuator/health` к каждому сервису  
- **Ожидаемый результат**:  
  - Статус `UP` для всех компонентов  
- **Постусловия**: -  
- **Статус**: [ ] Success [ ] Failed [ ] Blocked  

---
