fx_version 'cerulean'
lua54 'yes'
game 'gta5'

author 'perrituber & roda.scripts'
description 'Elevator system for FiveM'

client_scripts {
    'Client/main.lua',
}

shared_scripts {
    'Config.lua',
    '@ox_lib/init.lua'
}


ui_page {
    'html/index.html',
}

files {
    'html/index.html',
    'html/app.js', 
    'html/style.css',
    'html/fonts/*.otf'
}