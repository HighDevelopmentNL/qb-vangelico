fx_version 'cerulean'
game 'gta5'

description 'QB-Vangelico by HighDevelopment'
version '1.0.0'

ui_page 'html/index.html'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locale/en.lua',
    'locale/*.lua',
    'config.lua',
}
client_script {
    'client/*.lua',
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
}

server_script 'server/server.lua'

files {
    'html/index.html',
    'html/css/style.css',
    'html/js/script.js',
}

lua54 'yes'