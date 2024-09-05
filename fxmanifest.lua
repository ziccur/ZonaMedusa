fx_version 'adamant'

game 'gta5'

description 'ZonaMedusa'
lua54 'yes'

version '1.0' 
legacyversion '1.9.1'

shared_script {
	'@es_extended/imports.lua',
	'@es_extended/locale.lua',
	'locales/em.lua',
	'locales/es.lua',
	'config.lua'
}

client_scripts {
	'config.lua',
    'client/client.lua'
}

server_scripts {
	'config.lua',
	'server/server.lua'
}

dependency{
	'es_extended',
	'esx_banking',
} 