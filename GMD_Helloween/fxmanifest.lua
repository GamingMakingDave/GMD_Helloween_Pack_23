fx_version 'adamant'
game 'gta5'

author 'GMD_Scripts'
name 'gmd_helloween'
version '1.0.0'
description 'helloween event party'

lua54 'yes'

ui_page('nui/nui.html')

files {
  'nui/nui.html',
  'nui/js/script.js',
  'nui/css/style.css',
  'nui/data/*.jpg',
  'nui/data/*.mp3'
}


server_script {
	'@oxmysql/lib/MySQL.lua',
	'server/*.lua'
}

client_scripts {
	'client/*.lua'
}

shared_scripts {
	'config.lua'
}

dependencies {
	'es_extended'
}