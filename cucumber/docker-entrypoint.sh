#!/bin/bash
set -e

git_user='71225919134'
git_pswd='#Magatti2018#'
cucumber_dir='/usr/share/cucumber'
cucumber_cred_file="${cucumber_dir}/.git-credentials"
path_remote_origin='https://gitlab.poupex.com.br/poupex/qa/cucumber/glpi.git'

echo "[ ****************** ] Starting Endpoint of Application"
#if ! [ -d "/usr/share/cucumber" ]; then
    echo "Application not found in ${cucumber_dir} - Cloning now..."
    mkdir -p ${cucumber_dir}
    cd ${cucumber_dir}
    git init
    git remote add origin ${path_remote_origin}
#fi

echo "[ ****************** ] Ending Endpoint of Application"
cd ${cucumber_dir}
git config credential.helper "store --file=${cucumber_cred_file}"
echo "https://${git_user}:${git_pswd}@gitlab.poupex.com.br" > "${cucumber_cred_file}"
git remote update
git checkout -f master
echo "[ ****************** ] Clone Successfull!!!!!!!!"
echo "[ ****************** ] Execute Cucumber........."
cp -av /tmp/config.yml ${cucumber_dir}/features/support
#cp -av /tmp/Gemfile ${cucumber_dir}
#cp -av /tmp/Gemfile.lock ${cucumber_dir}
cp -av /tmp/cucumber.yaml ${cucumber_dir}

bundle config --delete frozen
bundle lock --add-platform ruby
bundle lock --add-platform x86_64-linux
bundle update
gem update
#cucumber

exec "$@"

