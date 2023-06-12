import XMonad

main :: IO ()
main = do
    xmonad def {
            modMask = mod4Mask -- use Super rather than Alt
    }

-- TODO:

-- https://github.com/bchurchill/xmonad-pulsevolume

-- xmobar
-- gutters between/around windows
-- background (might belong in xinitrc)
-- keys:
--   Super-F: switch to a Firefox window. If none, open Firefox
--   : lock screen
--   : switch this app's audio output(/input)
--   : audio
--     : louder/quieter/mute globally
--     : louder/quieter/mute this app
--     : different input/output per-app
--   : screenshots
--     : whole screen
--     : single window
--     : single monitor
--     : selected region
--   : clipboard
--     : history
--     : input shortcuts
--   : refresh displays
--   : (toggle mirroring)
-- all screens switch as one ?
-- show what I have on all spaces
-- urgency?

-- Gimp: all windows always floating
