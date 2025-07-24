#!/bin/bash

# Конфигурация
SLAVE_USER="vboxuser"           # Пользователь для SSH
SLAVE_HOST="192.168.1.84"       # IP или хостнейм slave
MYSQL_USER="root"
MYSQL_PASS="MyRootPassword123!"
BACKUP_DIR="/ansible/backup"
DATE=$(date +"%Y-%m-%d_%H-%M")
TARGET_DIR="$BACKUP_DIR/$DATE"

# Опции SSH
SSH_OPTS="-o StrictHostKeyChecking=no"

# Создаем директорию для резервных копий
mkdir -p "$TARGET_DIR"

echo "[$(date '+%F %T')] Начало бэкапа с slave $SLAVE_USER@$SLAVE_HOST"

# Получаем статус репликации и позицию бинарного лога
BINLOG_INFO=$(ssh $SSH_OPTS $SLAVE_USER@$SLAVE_HOST "mysql -u$MYSQL_USER -p$MYSQL_PASS -e 'SHOW MASTER STATUS\\G'" 2>/dev/null)
MASTER_LOG_FILE=$(echo "$BINLOG_INFO" | grep 'File:' | awk '{print $2}')
MASTER_LOG_POS=$(echo "$BINLOG_INFO" | grep 'Position:' | awk '{print $2}')

echo "[$(date '+%F %T')] Master Log File: $MASTER_LOG_FILE, Position: $MASTER_LOG_POS"

# Сохраняем информацию о бинлоге
echo "Master Log File: $MASTER_LOG_FILE" > "$TARGET_DIR/binlog_info.txt"
echo "Master Log Position: $MASTER_LOG_POS" >> "$TARGET_DIR/binlog_info.txt"

# Получаем список баз данных (исключая системные)
DBS=$(ssh $SSH_OPTS $SLAVE_USER@$SLAVE_HOST "mysql -u$MYSQL_USER -p$MYSQL_PASS -e 'SHOW DATABASES;' | grep -Ev '^(Database|information_schema|performance_schema|mysql|sys)$'")

for DB in $DBS; do
  echo "[$(date '+%F %T')] Бэкап базы: $DB"

  # Создаем директорию под базу
  mkdir -p "$TARGET_DIR/$DB"

  # Получаем список таблиц
  TABLES=$(ssh $SSH_OPTS $SLAVE_USER@$SLAVE_HOST "mysql -u$MYSQL_USER -p$MYSQL_PASS -e 'USE $DB; SHOW TABLES;' | tail -n +2")

  for TABLE in $TABLES; do
    echo "    -> Таблица: $TABLE"
    ssh $SSH_OPTS $SLAVE_USER@$SLAVE_HOST "mysqldump -u$MYSQL_USER -p$MYSQL_PASS --single-transaction --skip-lock-tables --databases $DB --tables $TABLE" > "$TARGET_DIR/$DB/${TABLE}.sql"
  done
done

echo "[$(date '+%F %T')] Бэкап завершен. Файлы сохранены в $TARGET_DIR"
