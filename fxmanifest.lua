fx_version 'cerulean'

game 'gta5'

lua54 'yes'

author 'Lusty94'

description 'Pops Diner Job Script For QB-Core'

version '1.0.0'


client_scripts {
    'client/diner_client.lua',
    'client/diner_unlockedclient.lua',
    'shared/menus.lua',
    'shared/targets.lua'
}

server_scripts {
    'server/diner_server.lua',
    'server/diner_unlockedserver.lua',
    'shared/billing.lua',
} 

shared_scripts { 
	'shared/config.lua',
    '@ox_lib/init.lua'
}

escrow_ignore {
    'shared/config.lua',
    'shared/menus.lua',
    'shared/targets.lua',
    'shared/billing.lua',
    'client/diner_unlockedclient.lua',
    'server/diner_unlockedserver.lua',
}
