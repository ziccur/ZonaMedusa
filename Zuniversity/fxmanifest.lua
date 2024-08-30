fx_version 'adamant'

game 'gta5'

description 'Ziccur University'
lua54 'yes'

version '1.0' 
legacyversion '1.9.1'

client_scripts {
    'client.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server.lua',
}

shared_script '@es_extended/imports.lua'

server_exports {
	'GetUniversitieHabilies'
}

