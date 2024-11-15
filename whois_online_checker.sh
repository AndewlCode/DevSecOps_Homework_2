#!/bin/bash

# Получаем список активных соединений на 8000 порту honeypot'a
connections=$(netstat -tn | grep ":8000 " | awk '{print $5}' | cut -d':' -f1)

# Проверяем, есть ли активные соединения
# Если нет, пишем в лог
if [ -z "$connections" ]; then
  echo "Нет активных соединений на 8000 порту." >> /tmp/whois_checker
else
  # Для каждого IP-адреса выполняем команду whois и записываем результат в файл
  for ip in $connections; do
    echo "Сведения по IP - адресу: $ip" >> /tmp/whois_checker
    whois $ip >> /tmp/whois_checker
    echo "" >> /tmp/whois_checker
  done
fi
