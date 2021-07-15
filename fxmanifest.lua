fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'DuncanEll - (SUPREME)'
description 'supreme_aircon'
version '1.0.0'

dependencies {
    "PolyZone"
}

client_script {
    'client.lua',
	'@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',

}

client_scripts {
    'client/client.lua',
    'client/cl_sellscrap.lua',
}

server_scripts {
    'server/server.lua',
    'server/sv_sellscrap.lua',
}

shared_scripts {
    'config.lua',
}