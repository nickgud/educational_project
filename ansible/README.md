# Репозиторий с конфигурационными файлами для автоматизации настройки и развёртывания ПО (Ansible)   

## Предварительные настройки  
- Используя terraform-скрипты создали новую ВМ в yandex.cloud.  
- С помощью cloud-init на ВМ были сделаны следующие настройки:  
  - создан пользователь ansible (с правами sudo),  
  - добавлен пользователю публичный ключ для входа по ssh.   

 Вывести внешний ip-адрес созданой ВМ можно с помощью следующей команды:  
 ```
 terraform output -raw external_ip_address_vm_1
  ```
Полученный ip-адрес необходимо добавить в inventory. 

В нашем случае при подключении к удаленным серверам используется ssh ключ.  
Согласно докуменации настоятельно рекомендуется использовать ssh-agent.  
```
ssh-agent bash
ssh-add path/to/private/key
```  

## Project structure (структура проекта)  
```  
.
├── ansible.cfg        # конфигурация для ansible
├── group_vars         # содержит файлы с переменными групп
│   ├── all.yml
│   ├── backend.yml
│   └── frontend.yml
├── inventory
│   └── static         # статический ini-файл  со списком серверов
├── playbook.yml       # основной playbook
├── README.md          # файл с описанием проекта
├── roles               
│   ├── backend        # роль для создания backend'a
│   └── frontend       # роль для создания frontend'a 
└── .vault             # файл с паролем от ansible-vault
                       # поэтому он добавлен в .gitignore
```   
## Ansible.cfg (конфигурационный файл)  
В данном файле были определены следующие директивы:  
```  
- inventory           # пути до источника инфо. о серверах
- private_key_file    # закрытый ключ для аутентификации на серверах  
- remote_user         # имя пользователя для подключения к серверам
- roles_path          # расположение ролей 
- host_key_checking   # отключение SSH проверки ключа хоста 
- timeout             # таймаут ожидания 
- callbacks_enabled   # включены некоторые плагины обратных вызовов  
- vault_password_file # файл с паролем от хранилища vault  
````  

## Variables (переменные)  
**group_vars/all.yml**  

| Name | Description | value |
| :---: | :---------:| :---: |
| ansible_connection | Плагин подключения, используемый для выполнения задач | ssh | 
  
**group_vars/backend.yml**  

| Name | Description | value |
|------|:--------:|:--------:|
| backend_service_user | сервисный пользователь  | backend | 
| backend_service_user_group | группа сервисного пользователя | backend | 
| backend_report_directory | директория, в которую бэкенд будет записывать отчёты  | /var/sausage-store/reports | 
| backend_log_directory | директория, в которую бэкенд будет записывать свои логи | /var/sausage-store/log | 
| backend_lib_directory | директория, к которой будет запущен backend | /opt/sausage-store/bin | 
| nexus_repo_backend_url | URL-адрес nexus репозитория | <url_nexus_storage> | 
| backend_version | версия maven актефакта | <num_ver> | 
| nexus_repo_user | имя пользователя от репозитория | можно зашифровать с помощью ansible-vault | 
| nexus_repo_pass | пароль пользователя от репозитория | можно зашифровать с помощью ansible-vault | 

**group_vars/frontend.yml** 

| Name | Description | value |
|------|:--------:|:--------:|
| frontend_service_user | сервисный пользователь | www-data | 
| frontend_service_user_group | группа сервисного пользователя | www-data | 
| frontend_working_directory | директория, из которой веб-сервер будет читать файлы статики | /var/www-data/dist/frontend | 
| nexus_repo_frontend_url | URL-адрес nexus репозитория | <url_nexus_storage> | 
| version_frontend | версия актефакта | <num_ver> | 
| nexus_repo_user | имя пользователя от репозитория | можно зашифровать с помощью ansible-vault | 
| nexus_repo_pass | пароль пользователя от репозитория | можно зашифровать с помощью ansible-vault | 
 
  
## Ansible roles  
- **backend** включает в себя:  
  - установка пакетов java, lxml  
  - создание сервисного пользователя  
  - создание необходимых директорий  
  - загрузка артефактов из Nexus  
  - создание systemd-юнита (с помощью jinja2)  
  - запуск backend'a  
- **frontend** включает в себя:  
  - установка пакетов nodejs, npm, nginx  
  - создание необходимых директорий  
  - загрузка артефактов из Nexus  
  - создание конфигурационного файла для Nginx (с помощью jinja2)  
  - удаление default конфигурационного файла в Nginx  
  - запуск frontend'a  

## Ansible-vault (шифрование чувствительных данных)
В переменных передаются логины и пароли, поэтому они были зашифрованы.  
Можно передать пароль для расшифровки при запуске ansible:  
``` 
ansible-playbook playbook.yaml --ask-vault-pass 
```    
Либо, как в нашем проекте, создать файл с паролем и указать его расположение в файле конфигурции ansible.cfg.  
  
