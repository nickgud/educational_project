#!/usr/bin/env bash
#
#
#Author: Gudkov N.
#Date: 2024-10-18
#
#==============================================================#
#    Выводит на экран информацию о хосте или пользователях     #
#==============================================================#
# для работы скрипта необходимы права root
# для вывода инфо скрипт запускается с ключом --host, --user или --help
# соответственно для получения информации о хосте, пользователях или справки 
#

# Проверяем имеет ли пользователь root права
if [[ $EUID -ne 0 ]]; then
	printf "Этот скрипт должен быть запущен с правами суперпользователя.\n"
	exit 1	
fi

# Справочная информация
show_help() {
	printf "Использование: get_info_about_system.sh [опции]\n" 
	printf "Опции:\n"
	printf "  --host\tПоказать информацию о хосте\n"
	printf "  --user\tИнформация о пользователях\n"
	printf "  -h, --help\tИнфо. о том, какие параметры поддерживает скрипт\n"
	exit 1
}

# Количество ядер CPU 
get_cpu_cores() {
    cores=$(nproc)
    printf "==============================\nКоличество ядер процессора: $cores\n"
}

# Объем ОП в системе и используемой
get_mem_info() {
	mem_info=$(free -h | awk '/Mem:/ {print "total " $2 "/" "used " $3}')
	printf "==============================\nОбъём оперативной памяти: $mem_info\n"
}

# Информация о дисках
get_disks_info() { # Выводим инфо о разделах, через awk обрабатываем нужные строки и через column форматируем в таблицу
	disks_info=$(df -h --output=source,fstype,size,used,avail | awk 'BEGIN {printf "disk fstype %%avail\n"} !/tmpfs|overlay|udev/ && NR > 1 {print $1,  $2, $5 / $3 * 100 "%"}' | column -t)
	# Выводим заголовок
	printf "==============================\nИнформация о дисках:\n"
	# Выводим информацию о дисках
	printf '%b\n' "$disks_info"
}

# Средняя загрузка системы
get_lavrg() {
	lavrg=$(cut -d " " -f-3 /proc/loadavg)
	printf "==============================\nСредняя загрузка системы(1m,5m,15m): $lavrg\n"
}

# Текущее время в системе
get_time_sys() {
	time_sys=$(date +"%F %R %Z")
	printf "==============================\nТекущее время в системе: $time_sys\n"
}

# Текущее время работы системы
get_uptime_sys() {
	uptime_sys=$(uptime -p | cut -d " " -f2-)
	printf "==============================\nВремя работы системы(uptime): $uptime_sys\n"
}

# Инфо о сетевых интерфейсах
get_net_info() {
	file=$(date +%s)
	#вывод сетевых интерфейсов в файл
	step1=$(ip -br addr show | awk '{print $1, $2, $3}' | sort > /tmp/interface1.$file)
	#вывод статистики по сетевым инферфейсам в файл
	step2=$(awk 'FNR>2 {print $1, $2, $4, $11, $12}' /proc/net/dev | sort | cut -d " " -f2- > /tmp/interface2.$file)
	#объединение файлов в один
	step3=$(paste /tmp/interface1.$file /tmp/interface2.$file > /tmp/interface3.$file)
	#добавление в файл строки с заголовками и форматирование в таблицу 
	step4=$(printf "INTERFACE STATUS ADDR RX-PACK RX-ER TX-PACK TX-ERR\n" | cat  - /tmp/interface3.$file  | column -t) 
	printf "==============================\nСписок сетевых интерфейсов, статут, IP, кол-во пакетов и ошибок:\n$step4\n"
}

# Порты, которые слушаются в системе
get_port() {
	list_port=$(ss -tuapnH state listening | awk '{print $1 "\t" $4}')
	printf "==============================\nСписок занятых портов:\n$list_port\n"
}

# Список пользователей в системе
get_users() {
	users=$(awk 'BEGIN {FS=":"; printf "==============================\nСписок пользователей в системе:\nUserName\tHomePath\n--------\t----------\n"; a=1} {if($3==0||$3>=1000&&$3!=65534) print a++, "-", $1 "\t" $6}' /etc/passwd)
	printf "$users\n"
}

# Список root-пользователей в системе
get_roots() {
     roots=$(cut -d: -f1 < /etc/passwd | xargs -L1 sudo -l -U | sed -n /may\ run/p | cut -d " " -f2 | nl -n ln -s ' - ' -w 1) 
     printf "==============================\nСписок root-пользователей в системе:\nUserName\n--------\n$roots\n"
}

# Список залогиненных пользователей
get_active_users() {
	active_users=$(who -m | awk 'BEGIN {printf "==============================\nСписок пользователей вошедших в систему:\nUserName\tTimeLogin\n--------\t----------\n"; a=1} {print a++, "-", $1 "\t" $3, $4}')
	printf "$active_users\n"
}


# Объявление длинных ключей
OPTIONS=$(getopt -o "h" -l "host,user,help" -- "$@")  

# Парсинг аргументов
eval set -- "$OPTIONS"

# Обработка аргументов
while true; do
  case "$1" in
    -h|--help)
      printf "Показать справку\n"
      show_help
      break ;;
    --host)
      printf "Обработка --host\n"
      get_cpu_cores
      get_mem_info
      get_disks_info
      get_lavrg
      get_time_sys
      get_uptime_sys
      get_net_info
      get_port
      shift
      break ;;
    --user)
      printf "Обработка --user\n"
      get_users
      get_active_users
      get_roots
      shift
      break  ;;
    *)
      show_help
      break ;;
  esac
done
