#!/usr/bin/env bash

BASE=$(dirname $0)
PGBIN="/opt/e-SUS/database/postgresql-9.6.13-1-linux-x64/bin"
PGPORT=5433
PGUSER=postgres
PGPASSWORD=esus
DBESUS=esus
DATACOMPLETA=$(date "+%Y%m%d%H%M%S")

source "$BASE/log.sh"

backup_banco_esus() {
    echo "Backup de banco $DBESUS via 'pg_dump'..."

    PGPASSWORD=$PGPASSWORD $PGBIN/pg_dump -d $DBESUS -p $PGPORT -U $PGUSER > "${DBESUS}_${DATACOMPLETA}.backup" && echo "... Finalizado"
}

restorar_banco_esus() {
    echo "Restaurar banco $DBESUS a partir do backup '$1' via 'pg_restore'..."

    PGPASSWORD=$PGPASSWORD $PGBIN/pg_restore -d $DBESUS -p $PGPORT -U $PGUSER < "$1" && echo "... Finalizado"
}

renomear_bd_esus() {
    echo "Renomear banco de dados $DBESUS para ${DBESUS}${DATACOMPLETA} via 'psql'..."

    PGPASSWORD=$PGPASSWORD $PGBIN/psql -d postgres -p $PGPORT -U $PGUSER -c "ALTER DATABASE esus RENAME TO esus${DATACOMPLETA}" && echo "... Finalizado"
}

criar_bd_esus() {
    echo "Criar banco $DBESUS via 'createdb'..."

    PGPASSWORD=$PGPASSWORD $PGBIN/createdb -p $PGPORT -U $PGUSER $DBESUS && echo "... Finalizado"
}

parar_servico_esus() {
    echo "Parando serviço do e-SUS(e-SUS-PEC.service)..."

    sudo systemctl stop e-SUS-PEC.service && echo "... Finalizado"
}

iniciar_servico_esus() {
    echo "Iniciando o serviço do e-SUS(e-SUS-PEC.service)..."

    sudo systemctl start e-SUS-PEC.service && echo "... Finalizado"
}

if [[ $# -eq 0 ]]; then
    echo "Informe como parâmetro o arquivo-backup-postgres-eSUS.backup" | log $0
    exit 1
fi

nome_arquivo=$(basename -- "$1")
extensao="${nome_arquivo##*.}"
if [[ "$extensao" != "backup" ]]; then
    echo "Arquivo de backup deve ter extensão '.backup'" | log $0
    exit 1
fi

backup_banco_esus | log $0
parar_servico_esus | log $0
renomear_bd_esus | log $0
criar_bd_esus | log $0
restorar_banco_esus "$1" | log $0
iniciar_servico_esus | log $0
