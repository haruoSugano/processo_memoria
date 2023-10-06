# !/bin/bash

# Diretorio de backup
backup_path=""

#Diretorio onde sera guardado
external_storage=""

#formato do arquivo
date_format=$(date "+%d-%m-%Y")
final_archive="backup-$date_format.tar.gz"

# Onde sera armazenado o arquivo log
log_file=""

#Checando se o dispositivo está conectado na máquina
if ! mountpoint -q -- $external_storage; then
	printf "[$date_format] DEVICE NOT MOUNTED in: $external_storage CHECK IT.\n" >> $log_file
	exit 1
fi

#Inicio do backup
if tar -czSpf "$external_storage/$final_archive" "$backup_path"; then
	printf "[$date_format] BACKUP SUCCESS.\n" >> $log_file
else
	printf "[$date_format] BACKUP ERROR!.\n" >> $log_file
fi

#Excluir os arquivos que tiverem mais de X dias
find $external_storage -mtime +10 -delete
