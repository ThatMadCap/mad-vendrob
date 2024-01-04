Config = {}

-- ROBBERY CONFIG --
Config.HeistCooldown = 1800000 -- Robbery Cooldown (in milliseconds - '1800000' is 30 minutes)
Config.PoliceAlert = 60 -- This is a % out of 100 to alert police
Config.RequiredPolice = 0 -- Required Police Count (set to 0 for no check)
Config.RequiredItem = 'lockpick' -- Item needed to rob the object
Config.ProgressBarSpeed = 20000 -- Length for all progress bars

-- TARGET CONFIG --
Config.ObjectLabel = 'Break into the vending machine' -- Third-eye label
Config.ObjectIcon = 'fa-solid fa-sack-dollar' -- Third-eye icon (default 'fas fa-sackdollar')

-- MINIGAME CONFIG -- 
Config.MinigameNumberofCircles = 6 -- Number of circles in the lockpick minigame
Config.MinigameMS = 30 -- Speed of the minigame (in milliseconds)

-- CASH REWARD CONFIG --
Config.CashChance = 100 -- This is a % out of 100 to receive cash
Config.MinReward = 5 -- Minimum Reward $
Config.MaxReward = 50 -- Maximum Reward $

-- COMMON ITEMS REWARD -- 
Config.CommonItemsChance = 75 -- This is a % out of 100 to receive an item from the CommonItems list
Config.CommonItemAmount = 1 -- Amount of the item you receive when you get an item from CommonItems
Config.CommonItems = { -- Items you have a chance to get 1 of:
    "cola",
    "ecoladiet",
    "sprunk",
    "sprunklight",
    "orang_o_tang",
    "cranberry",
}

-- RARE ITEMS REWARD -- 
Config.RareItemsChance = 10 -- This is a % out of 100 to receive an item from the RareItems list
Config.RareItemAmount = 1 -- Amount of the item you receive when you get an item from RareItems
Config.RareItems = { -- Items you have a chance to get 1 of:
    "usb2",
}

-- ROBBABLE OBJECTS --
Config.VendingObjects = {
    'prop_vend_soda_01', -- red cola soda vending machine
    'prop_vend_soda_02', -- green cola vending machine
    'sf_prop_sf_vend_drink_01a', -- 'junk' soda vending machine
    'ch_chint10_vending_smallroom_01', -- red cola soda vending machine 
}

-- TEXT --
Config.AttemptRobbery = 'Trying the lock...'
Config.RobberySuccess = 'You managed to break in!'
Config.RobberyFail = 'You bent the lockpick'
Config.ProgressBarText = 'Robbing vending machine...'
Config.HeistCooldownNotify = 'For some reason you can\'t do this right now...'
Config.NotEnoughCops = 'For some reason you can\'t do this right now...'
Config.CommonRewardText = "Something fell out of the machine..."