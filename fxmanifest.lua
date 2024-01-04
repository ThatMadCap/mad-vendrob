fx_version 'cerulean'
game 'gta5'

author 'MadCap'
description 'Vending Machine Robbery'
version '1.1'

dependency 'qb-core'
dependency 'qb-target'
dependency 'ps-ui'
dependency 'ps-dispatch'

shared_scripts {
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}