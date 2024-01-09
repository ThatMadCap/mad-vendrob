![MadCap Github Project MAD-VENDROB Banner](<mad-vendrob banner.png>)

# <mad-vendrob>

## Description

Immerse your players in the thrill of petty crime as they take on the challenge of robbing soda vending machines scattered across the map. With a variety of configurable options, this resource offers a dynamic experience tailored to your server's preferences.

Customize the robbery cooldown to control the frequency of heists, and set up police alerts to keep law enforcement on their toes. Require specific items for the robbery or engage players with entertaining minigame options. The rewards are in your hands – configure cash payouts, chances of receiving common items like sodas, and the excitement of rare items, all to enhance the risk and reward factor.

Unleash the excitement of urban mischief with this versatile Vending Machine Robbery resource, where each heist promises cash, common items, and the possibility of scoring rare treasures. It's time to shake up the cityscape and let your players embark on a lucrative life of vending machine crime!

## Preview

https://www.youtube.com/watch?v=l_Q_Bbsz_rg

## Dependencies

* [QBCore Framework](https://github.com/qbcore-framework)
* [qb-target](https://github.com/qbcore-framework/qb-target)
* [ps-ui](https://github.com/Project-Sloth/ps-ui) for circle minigame and notifications
* [ps-dispatch](https://github.com/Project-Sloth/ps-dispatch) for police dispatch notifications
* Tested with lj-inventory/ps-inventory

## Installation

* Download ZIP
* Drag and drop resource into your server files
* Rename folder to "mad-vendrob"
* Start resource through server.cfg

* Add this to your ps-dispatch\shared\config.lua

```lua54
-- MadCap Vending Robbery
['VendingMachineRobbery'] = {
    radius = 120,
    sprite = 66,
    color = 5,
    scale = 1.5,
    length = 2,
    sound = 'Lose_1st',
    sound2 = 'GTAO_FM_Events_Soundset',
    offset = false,
    flash = false
},
```

* Add this to your ps-dispatch\client\alerts.lua

```lua54
-- MadCap Vending Robbery
local function VendingMachineRobbery(camId)
    local coords = GetEntityCoords(cache.ped)
    local dispatchData = {
        message = "Suspicious Activity Reported",
        codeName = 'VendingMachineRobbery',
        code = 'S13P',
        icon = 'fas fa-question',
        priority = 2,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        camId = camId,
        jobs = { 'leo' }
    }
    TriggerServerEvent('ps-dispatch:server:notify', dispatchData)
end
exports('VendingMachineRobbery', VendingMachineRobbery)
```

* Add this to your ps-ui\html\style.css

```css
.warning {
  background-color: rgba(236, 176, 11, 0.85);
  color: #333333;
}
```

## Usage

Take this and use it however you like, consider the credited authors. Do not re-sell.

# Credits

This is the first resource I've released. I wouldn't have been able to do it without learning and borrowing from these resources:

* [ps-signrobbery](https://github.com/Project-Sloth/ps-signrobbery)
* [sp-meterrobbery](https://github.com/ItsSlappy/sp-MeterRobbery)
* [mz-storerobbery](https://github.com/MrZainRP/mz-storerobbery)

Credits:

* [ProjectSloth](https://github.com/Project-Sloth) - Authors of 'ps-signrobbery', 'ps-ui', 'ps-dispatch'
* [ItsSlappy](https://github.com/ItsSlappy) - Author of 'sp-meterrobbery'
* [MrZainRP](https://github.com/MrZainRP) - Author of 'mz-storerobbery'
* [Simon](https://github.com/simsonas86) - Big brain friend
* [Squrky](https://github.com/squrky) - "Advisor"
