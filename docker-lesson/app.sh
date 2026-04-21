#!/bin/bash

# === КОНФИГУРАЦИЯ ===
TARGET_DIR="/opt/devops_workspace"
LOG_FILE="/var/log/devops_setup.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# === ФУНКЦИЯ ЛОГИРОВАНИЯ ===
log() {
    echo "[$TIMESTAMP] $1" | tee -a "$LOG_FILE"
}

# === ПРОВЕРКА ПРАВ ===
if [[ $EUID -ne 0 ]]; then
    log "ОШИБКА: Скрипт требует прав root. Запусти с sudo."
    exit 1
fi

log "🚀 Начало настройки окружения..."

# === 1. Создание директории (идемпотентно) ===
if [ -d "$TARGET_DIR" ]; then
    log "✅ Директория $TARGET_DIR уже существует. Пропускаем."
else
    mkdir -p "$TARGET_DIR" && log "📁 Создана директория: $TARGET_DIR"
fi

# === 2. Создание конфига (только если нет) ===
CONFIG_FILE="$TARGET_DIR/app.conf"
if [ ! -f "$CONFIG_FILE" ]; then
    printf "APP_ENV=production\nLOG_LEVEL=info\n" > "$CONFIG_FILE"
    log "📄 Создан конфигурационный файл: $CONFIG_FILE"
else
    log "🔒 Конфиг $CONFIG_FILE уже существует. Не перезаписываем."
fi

log "✅ Настройка завершена успешно."
exit 0
