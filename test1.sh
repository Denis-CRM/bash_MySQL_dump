mkdir /scripts

vi /scripts/mysql_backup.sh

#Указываем на путь к интерпретатору.
#!/bin/bash
#Задаем системные переменные, чтобы не пришлось в скрипте прописывать полные пути до исполняемых файлов.
PATH=/etc:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

#Задаем переменные

#Каталог, в котором будем сохранять резервные копии.
$destination="/backup/mysql"
#Учетная запись для подключения к базе данных.
$userDB="root"
#Пароль для подключения к базе данных.
$passwordDB="root_passwoed"

# Получить массив таблиц в базе

$table=массив

mysqldump -v -u$userDB -p$passwordDB --no-data base1 > /$destination/dump_base1_nodata.sql

FOR mysqldump -v -uroot -p$passwordDB base1 $table > /$destination/dump_$table_tables.sql























#Дата, когда запускается скрипт.
fdate=`date +%Y-%m-%d`
 
 
find $destination -type d \( -name "*-1[^5]" -o -name "*-[023]?" \) -ctime +30 -exec rm -R {} \; 2>&1
find $destination -type d -name "*-*" -ctime +180 -exec rm -R {} \; 2>&1
mkdir $destination/$fdate 2>&1
 
for dbname in `echo show databases | mysql -u$userDB -p$passwordDB | grep -v Database`; do
    case $dbname in
        information_schema)
            continue ;;
        mysql)
            continue ;;
        performance_schema)
            continue ;;
        test)
            continue ;;
        *) mysqldump --databases --skip-comments -u$userDB -p$passwordDB $dbname | gzip > $destination/$fdate/$dbname.sql.gz ;;
    esac
done;



chmod +x /scripts/mysql_backup.sh

