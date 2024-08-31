fx_version 'adamant'

game 'gta5'

description 'Zuniversity'
lua54 'yes'

version '1.0' 
legacyversion '1.9.1'

shared_script {
	'config.lua',
	'@es_extended/imports.lua'	
}

client_scripts {
	'config.lua',
    'client.lua'
}

server_scripts {
	'config.lua',
	'@oxmysql/lib/MySQL.lua',
	'server.lua'
}

server_exports {
	'GetUniversitieHabilies'
}

