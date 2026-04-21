# 1. Базовый образ (лёгкий Debian)
FROM debian:bookworm-slim

# 2. Метаданные (не влияют на работу, но полезны)
LABEL maintainer="your@email.com"
LABEL description="Учебный контейнер: настройка окружения"

# 3. Обновляем кэш и ставим утилиты (одной командой для меньшего слоя)
RUN apt update && \
    apt install -y --no-install-recommends \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 4. Копируем скрипт внутрь образа
COPY ./app.sh /usr/local/bin/app.sh

# 5. Делаем его исполняемым
RUN chmod +x /usr/local/bin/app.sh

# 6. Команда по умолчанию при запуске контейнера
CMD ["/usr/local/bin/app.sh"]
