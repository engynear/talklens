# TalkLens

TalkLens - это система для анализа и сбора метрик из различных мессенджеров.

## Требования

- Docker и Docker Compose
- Git
- Yandex GPT API ключ
- Yandex Cloud Folder ID
- Goose (для миграций)

## Установка на Linux

1. Клонируйте все необходимые репозитории в корень проекта:

```bash
git clone https://github.com/engynear/talklens.analyzer.git
git clone https://github.com/engynear/talklens.collector.git
git clone https://github.com/engynear/talklens.frontend.git
git clone https://github.com/engynear/talklens.auth.git
```

2. Создайте файл конфигурации:

```bash
cp .env.example .env
```

3. Отредактируйте файл `.env` и добавьте следующие значения:
```
API_KEY=ваш_ключ_api
FOLDER_ID=ваш_folder_id
```

## Запуск

1. Запустите все сервисы с помощью Docker Compose:

```bash
docker compose up -d
```

2. Дождитесь полного запуска контейнеров с базами данных (PostgreSQL и ClickHouse)

3. Выполните миграции (примеры команд):

```bash
goose -dir ./migrations/clickhouse/ clickhouse "clickhouse://clickhouse:clickhouse@localhost:9002/talklens" up
goose -dir ./migrations/postgres/ postgres "postgres://postgres:postgres@localhost:6543/talklens?sslmode=disable" up
```

## Структура проекта

- `talklens.analyzer` - сервис для анализа сообщений
- `talklens.collector` - сервис для сбора метрик из мессенджеров
- `talklens.frontend` - веб-интерфейс
- `talklens.auth` - сервис аутентификации
