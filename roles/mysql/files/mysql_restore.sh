#!/bin/bash

# Конфигурация
MASTER_HOST="192.168.1.126"        # IP или хост master
MASTER_USER="vboxuser"             # SSH-пользователь для master
MYSQL_USER="root"
MYSQL_PASS="MyRootPassword123!"
BACKUP_DIR="/ansible/backup"

# Находим последний бэкап
LATEST_BACKUP=$(ls -1 $BACKUP_DIR | sort | tail -n 1)
FULL_BACKUP_PATH="$BACKUP_DIR/$LATEST_BACKUP"

if [ ! -d "$FULL_BACKUP_PATH" ]; then
    echo "Ошибка: не найдено бэкапов в $BACKUP_DIR"
    exit 1
fi

echo "[$(date '+%F %T')] Копируем бэкап $FULL_BACKUP_PATH на $MASTER_USER@$MASTER_HOST:/tmp/mysql_restore"
ssh $MASTER_USER@$MASTER_HOST "mkdir -p /tmp/mysql_restore"
scp -r "$FULL_BACKUP_PATH" $MASTER_USER@$MASTER_HOST:/tmp/mysql_restore/

echo "[$(date '+%F %T')] Восстанавливаем базы на master $MASTER_HOST"
ssh $MASTER_USER@$MASTER_HOST "
    MYSQL_USER='$MYSQL_USER'
    MYSQL_PASS='$MYSQL_PASS'
    BACKUP_DIR='/tmp/mysql_restore/$LATEST_BACKUP'

    for DB in \$(ls \"\$BACKUP_DIR\"); do
        if [ \"\$DB\" == \"binlog_info.txt\" ]; then
            continue
        fi
        echo \"Восстанавливаем базу: \$DB\"
        mysql -u\$MYSQL_USER -p\$MYSQL_PASS -e \"CREATE DATABASE IF NOT EXISTS \\\`\$DB\\\`;\"
        for TABLE_FILE in \"\$BACKUP_DIR/\$DB\"/*.sql; do
            TABLE=\$(basename \"\$TABLE_FILE\" .sql)
            echo \"    -> Таблица: \$TABLE\"
            mysql -u\$MYSQL_USER -p\$MYSQL_PASS \"\$DB\" < \"\$TABLE_FILE\"
        done
    done
"

echo "[$(date '+%F %T')] Восстановление завершено."
