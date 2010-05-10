--
-- Massimo's Xmonad config files.
-- 
-- EWMH is active to be used by "wmctrl".
-- Improved workspaces navigation.
--
-- At this date (2010-05-10) this file is not used
-- anymore.  I don't even know if it is properly working.
--
--
--

import XMonad
import XMonad.Actions.CycleWS
import XMonad.Actions.DwmPromote
import XMonad.Actions.CopyWindow
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.WindowNavigation 
import XMonad.Layout.Tabbed
import XMonad.Layout.NoBorders
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeysP)
import System.IO

import qualified XMonad.StackSet as W



-- Keys customization
-- TODO:
--   Copy windows
--   Flexible Resize
--   Tabbed layout
massimoKeys = 
    [
     ( "M-<R>", moveTo Next NonEmptyWS )
    ,( "M-<L>", moveTo Prev NonEmptyWS )
    ,( "M-<Tab>", toggleWS )
    ,( "M-<Escape>", kill1)
    ,( "M-b"   , sendMessage ToggleStruts)
    ,( "M-m", dwmpromote )
    -- Applications
    ,( "M-<Return>", spawn "xterm")
    ,( "M-w", spawn "~/config/scripts/firefox-fixtheme.sh" )
    ,( "M-f", spawn "pcmanfm" )
    ,( "M-e", spawn "emacs" ) 
    ]

massimoWS = ["1:main","2:aux", "3:fm" ]  -- Basic
            ++ [ "4:web", "5:comm"  ]  -- Internet
            ++ [ "6:media", "7:p2p" ]  -- Multimedia
            ++ [ "8:sys"]            -- System logs
           

-- Massimo's hooks
massimoLayoutHook = avoidStruts $ smartBorders $ ewmhDesktopsLayout $ layoutHook (defaultConfig) 


massimoLogHook = \out -> do 
                   ewmhDesktopsLogHook
                   (dynamicLogWithPP (massimoPP out))
                   return ()

-- have urgent events flash a yellow dzen bar with black text
massimoUrgencyHook = withUrgencyHook dzenUrgencyHook
    { args = ["-bg", "yellow", "-fg", "black"] }
                   


massimoManageHook = composeAll
    [
      className =? "Emacs"          --> doF (W.shift "1:main" )
    , className =? "OpenOffice.org" --> doF (W.shift "1:main" )
    , className =? "XDvi"           --> doF (W.shift "2:aux"  )
    , className =? "Xpdf"           --> doF (W.shift "2:aux"  )
    , className =? "Evince"         --> doF (W.shift "2:aux"  )
    , className =? "Pcmanfm"        --> doF (W.shift "3:fm"   )
    , className =? "Iceweasel"      --> doF (W.shift "4:web"  )
    , className =? "Firefox"        --> doF (W.shift "4:web"  )
    , className =? "Conkeror"       --> doF (W.shift "4:web"  )
    , className =? "Liferea"        --> doF (W.shift "4:web"  )
    , className =? "Skype"          --> doF (W.shift "5:comm" )
    , className =? "Pidgin"         --> doF (W.shift "5:comm" )
    , className =? "Gmpc"           --> doF (W.shift "6:media")
    , className =? "Amule"          --> doF (W.shift "7:p2p" )
    , className =? "Transmission"   --> doF (W.shift "7:p2p")
    , className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , className =? "Gmessage"       --> doFloat
    , className =? "Xmessage"       --> doFloat
    , className =? "Pinentry"       --> doFloat
    , resource  =? "desktop_window" --> doIgnore ]



-----------------------------------------------------------------------------------
dzen2bar = "dzen2 -bg '#2c2c32' -fg 'grey70' -w 1000 -h 16 -sa c -fn '-*-profont-*-*-*-*-11-*-*-*-*-*-iso8859' -e '' -xs 1 -ta l"
 
main = do 
  sbarProcess <- spawnPipe dzen2bar
  xmonad $ massimoUrgencyHook $ defaultConfig
      { 
      -- Basic Customization
       borderWidth   = 1
      ,terminal      = "xterm"
      ,modMask       = mod4Mask    -- Use WinKey/Mod4 for XMonad
      ,workspaces    = massimoWS
       -- Massimo's hooks
      ,logHook       = massimoLogHook (sbarProcess)
      ,layoutHook    = massimoLayoutHook
      ,manageHook    = massimoManageHook <+> manageDocks <+> manageHook defaultConfig

      } `additionalKeysP` massimoKeys
------------------------------------------------------------------------------------

massimoPP h = defaultPP 
     { ppCurrent = wrap "^fg(#000000)^bg(#a6c292)^p(2)^i(/home/massimo/.xmonad/dzen/has_win.xbm)" "^p(2)^fg()^bg()"
     , ppVisible = wrap "^bg(grey30)^fg(grey75)^p(2)" "^p(2)^fg()^bg()"
     , ppSep     = " ^fg(grey60)^r(3x3)^fg() "
     , ppLayout  = dzenColor "#80AA83" "" .
                   (\x -> case x of
                            "Tall" -> "^i(/home/massimo/.xmonad/dzen/tall.xbm)"
                            "Mirror Tall" -> "^i(/home/massimo/.xmonad/dzen/mtall.xbm)"
                            "Full" -> "^i(/home/massimo/.xmonad/dzen/full.xbm)"
                   )
     , ppTitle   = dzenColor "white" "" . wrap "< " " >" 
     , ppOutput   = hPutStrLn h
     }
 
