#!/bin/bash
set -e

git_user='71225919134'
git_pswd='#Magatti2019#'
glpi_dir='/var/www/html/dev.glpi.com.br'
glpi_cred_file="${glpi_dir}/.git-credentials"
script_banco_glpi='/var/www/html/script_inicial_glpi_docker.sql'
path_remote_origin='https://gitlab.poupex.com.br/poupex/software-livre/glpi-poupex.git'

echo "[ ****************** ] Starting Endpoint of Application"
if ! [ -d "/var/www/html/dev.glpi.com.br/vendor" ]; then
    echo "Application not found in /var/www/html/dev.glpi.com.br - Downloading now..."
    if [ "$(ls -A)" ]; then
        echo "WARNING: /var/www/html/dev.glpi.com.br is not empty - press Ctrl+C now if this is an error!"
        ( set -x; ls -A; sleep 10 )
    fi
    echo "[ ****************** ] Execute the clone of the GLPI POUPEX"
    
    cd /var/www/html
    mkdir -p ${glpi_dir}
    cd ${glpi_dir}
    git init
    git remote add origin ${path_remote_origin}
    git config credential.helper "store --file=${glpi_cred_file}"
    echo "https://${git_user}:${git_pswd}@gitlab.poupex.com.br" > "${glpi_cred_file}"
    git remote update
    git checkout -f master

    ls -la ${glpi_dir}
    mv install install.old
fi

echo "[ ****************** ] Changing owner and group from the Project to 'www-data' "
chmod 775 /var/www/html -Rf
chown www-data:www-data -R ${glpi_dir}
yes | cp -av /tmp/src/actions/configs/config_db.php ${glpi_dir}/config 

echo "[ ****************** ] Importing data in database before ending buinid of Application"
#Realiza a carga da base de dados
mysql -u root -h database-mysql-glpi-pipeline -p12345678 < ${script_banco_glpi}

echo "[ ****************** ] Ending Endpoint of Application"
cd ${glpi_dir}
#mv install install.old
echo "[ ****************** ] A Aplicação foi finalizada com sucesso. Successfull!!!!!!!!"
exec "$@"

