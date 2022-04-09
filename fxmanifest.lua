fx_version 'cerulean'
game 'gta5'

description 'QB-Clothing'
version '1.0.0'

ui_page 'html/index.html'

shared_scripts {
	'config.lua'
}

client_scripts {
    '@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/ComboZone.lua',
    'client/main.lua'
}
files {
	'html/index.html',
	'html/style.css',
	'html/reset.css',
	'html/*.js'
}

dependencies {
	'qb-core'
}
