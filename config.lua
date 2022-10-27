Config = Config or {}

Config.CopsNeeded = -1

Config.Interval = 1000

Config.ResetTime = 30 * (60 * 2000)

Config.Triggers = {
    ['Target'] = 'qb-target',
    ['Resource'] = 'qb-vangelico',
}
Config.Info = {
    ['Started'] = false,
    ['Power'] = false,
    ['DoorHacked'] = false,
    ['Searched'] = false,
    ['Code'] = 1234,
    ['VaultDoor'] = {},
    ['Loot'] = {
    -- Right Side
    [1] = {['Busy'] = false, ['Open'] = false, ['Name'] = 'Vitrine', ['Type'] = 'lockpick', ['Coords'] = {['X'] = -447.7717, ['Y'] = -72.13509, ['Z'] = 41.287467, ['H'] = 40.0, ['Height'] = 1.5, ['Width'] = 1.6}},
    [2] = {['Busy'] = false, ['Open'] = false, ['Name'] = 'Vitrine', ['Type'] = 'lockpick', ['Coords'] = {['X'] = -449.2984, ['Y'] = -70.90511, ['Z'] = 41.287467, ['H'] = 40.0, ['Height'] = 1.5, ['Width'] = 1.6}},
    [3] = {['Busy'] = false, ['Open'] = false, ['Name'] = 'Vitrine', ['Type'] = 'lockpick', ['Coords'] = {['X'] = -450.5131, ['Y'] = -69.3339, ['Z'] = 41.33, ['H'] = 40.0, ['Height'] = 1.5, ['Width'] = 1.6}},
    [4] = {['Busy'] = false, ['Open'] = false, ['Name'] = 'Vitrine', ['Type'] = 'lockpick', ['Coords'] = {['X'] = -451.5454, ['Y'] = -67.76856, ['Z'] = 41.33, ['H'] = 40.0, ['Height'] = 1.5, ['Width'] = 1.6}},
    [5] = {['Busy'] = false, ['Open'] = false, ['Name'] = 'Vitrine', ['Type'] = 'lockpick', ['Coords'] = {['X'] = -452.8567, ['Y'] = -66.15724, ['Z'] = 41.33, ['H'] = 40.0, ['Height'] = 1.5, ['Width'] = 1.6}},
    [6] = {['Busy'] = false, ['Open'] = false, ['Name'] = 'Vitrine', ['Type'] = 'lockpick', ['Coords'] = {['X'] = -454.0726, ['Y'] = -64.78124, ['Z'] = 41.33, ['H'] = 40.0, ['Height'] = 1.5, ['Width'] = 1.6}},
    -- Left Side
    [7] = {['Busy'] = false, ['Open'] = false, ['Name'] = 'Vitrine', ['Type'] = 'lockpick', ['Coords'] = {['X'] = -460.3364, ['Y'] = -69.76039, ['Z'] = 41.33, ['H'] = 40.0, ['Height'] = 1.5, ['Width'] = 1.6}},
    [8] = {['Busy'] = false, ['Open'] = false, ['Name'] = 'Vitrine', ['Type'] = 'lockpick', ['Coords'] = {['X'] = -459.1668, ['Y'] = -71.25836, ['Z'] = 41.33, ['H'] = 40.0, ['Height'] = 1.5, ['Width'] = 1.6}},
    [9] = {['Busy'] = false, ['Open'] = false, ['Name'] = 'Vitrine', ['Type'] = 'lockpick', ['Coords'] = {['X'] = -457.8565, ['Y'] = -72.72243, ['Z'] = 41.33, ['H'] = 40.0, ['Height'] = 1.5, ['Width'] = 1.6}},
    [10] = {['Busy'] = false, ['Open'] = false, ['Name'] = 'Vitrine', ['Type'] = 'lockpick', ['Coords'] = {['X'] = -456.6455, ['Y'] = -74.34704, ['Z'] = 41.33, ['H'] = 40.0, ['Height'] = 1.5, ['Width'] = 1.6}},
    [11] = {['Busy'] = false, ['Open'] = false, ['Name'] = 'Vitrine', ['Type'] = 'lockpick', ['Coords'] = {['X'] = -455.4187, ['Y'] = -75.85492, ['Z'] = 41.33, ['H'] = 40.0, ['Height'] = 1.5, ['Width'] = 1.6}},
    [12] = {['Busy'] = false, ['Open'] = false, ['Name'] = 'Vitrine', ['Type'] = 'lockpick', ['Coords'] = {['X'] = -454.1662, ['Y'] = -77.27294, ['Z'] = 41.33, ['H'] = 40.0, ['Height'] = 1.5, ['Width'] = 1.6}},
        -- Midden 
    [13] = {['Busy'] = false, ['Open'] = false, ['Name'] = 'Vitrine', ['Type'] = 'lockpick', ['Coords'] = {['X'] = -452.4913, ['Y'] = -72.90595, ['Z'] = 41.33, ['H'] = 40.0, ['Height'] = 1.3, ['Width'] = 2.5}},
    [14] = {['Busy'] = false, ['Open'] = false, ['Name'] = 'Vitrine', ['Type'] = 'lockpick', ['Coords'] = {['X'] = -454.4681, ['Y'] = -70.32781, ['Z'] = 41.33, ['H'] = 40.0, ['Height'] = 1.3, ['Width'] = 2.5}},
    [15] = {['Busy'] = false, ['Open'] = false, ['Name'] = 'Vitrine', ['Type'] = 'lockpick', ['Coords'] = {['X'] = -454.4715, ['Y'] = -72.86576, ['Z'] = 41.33, ['H'] = 40.0, ['Height'] = 2.5, ['Width'] = 0.6}},
    },
    ['SearchLocations'] = {
        [1] = {['Busy'] = false, ['Open'] = false, ['Coords'] = {['X'] = -449.6623, ['Y'] = -61.67795, ['Z'] = 41.33, ['H'] = 40.0}},
        [2] = {['Busy'] = false, ['Open'] = false, ['Coords'] = {['X'] = -447.6206, ['Y'] = -60.40564, ['Z'] = 41.33, ['H'] = 40.0}},
        [3] = {['Busy'] = false, ['Open'] = false, ['Coords'] = {['X'] = -450.1443, ['Y'] = -57.7913, ['Z'] = 41.33, ['H'] = 40.0}},
        [4] = {['Busy'] = false, ['Open'] = false, ['Coords'] = {['X'] = -457.9846, ['Y'] = -67.52528, ['Z'] = 41.33, ['H'] = 40.0}},
        [5] = {['Busy'] = false, ['Open'] = false, ['Coords'] = {['X'] = -448.4586, ['Y'] = -64.0384, ['Z'] = 41.33, ['H'] = 40.0}},

    },
    ['LootSafe'] = {
        [1] = {['Open'] = false, ['Name'] = 'Vault', ['Height'] = 1.5, ['Width'] = 1.6, ['Coords'] = {['X'] = -444.1046, ['Y'] = -70.29561, ['Z'] = 41.167423}},
        [2] = {['Open'] = false, ['Name'] = 'Vault', ['Height'] = 1.5, ['Width'] = 1.6, ['Coords'] = {['X'] = -445.1676, ['Y'] = -68.52987, ['Z'] = 40.905159}},
        [3] = {['Open'] = false, ['Name'] = 'Vault', ['Height'] = 1.5, ['Width'] = 1.6, ['Coords'] = {['X'] = -441.6747, ['Y'] = -66.9444, ['Z'] = 41.507289}},
    },
    ['Rewards'] = { -- Adjust to your likings these are default values
      [1] = {
        ["item"] = "rolex",
        ["amount"] = {
            ["min"] = 1,
            ["max"] = 4
        },
      },
      [2] = {
          ["item"] = "diamond_ring",
          ["amount"] = {
              ["min"] = 1,
              ["max"] = 4
          },
      },
      [3] = {
          ["item"] = "goldchain",
          ["amount"] = {
              ["min"] = 1,
              ["max"] = 4
          },
      },
    },
    ['VaultRewards'] = { -- Adjust to your likings these are default values
      [1] = {
        ["item"] = "rolex",
        ["amount"] = {
            ["min"] = 3,
            ["max"] = 8
        },
      },
      [2] = {
          ["item"] = "diamond_ring",
          ["amount"] = {
              ["min"] = 4,
              ["max"] = 8
          },
      },
      [3] = {
          ["item"] = "goldchain",
          ["amount"] = {
              ["min"] = 5,
              ["max"] = 10
          },
      },
    },
    ['Electricbox'] = {
      [1] = {
          ['X'] = -448.6,
          ['Y'] = 51.15,
          ['Z'] = 44.52,
      },
    },
}

Config.MaleNoHandshoes = {
    [0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [18] = true, [26] = true, [52] = true, [53] = true, [54] = true, [55] = true, [56] = true, [57] = true, [58] = true, [59] = true, [60] = true, [61] = true, [62] = true, [112] = true, [113] = true, [114] = true, [118] = true, [125] = true, [132] = true,
}

Config.FemaleNoHandshoes = {
    [0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [19] = true, [59] = true, [60] = true, [61] = true, [62] = true, [63] = true, [64] = true, [65] = true, [66] = true, [67] = true, [68] = true, [69] = true, [70] = true, [71] = true, [129] = true, [130] = true, [131] = true, [135] = true, [142] = true, [149] = true, [153] = true, [157] = true, [161] = true, [165] = true,
}
