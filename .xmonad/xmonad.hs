{- xmonad.hs
 - Author: Rohan Jain <crodjer AT gmail DOT com>
 -}

-- Borrowed from the xmonad.hs by �yvind 'Mr.Elendig' Heggstad <mrelendig AT
-- har-ikkje DOT net>

-------------------------------------------------------------------------------
-- Imports --
-- stuff
import XMonad hiding ( (|||) )
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import System.Exit
import System.IO (Handle, hPutStrLn)
import XMonad.Actions.CycleWS
import XMonad.Actions.NoBorders

-- utils
import XMonad.Util.Run (spawnPipe)
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Actions.ConditionalKeys

-- hooks
import XMonad.Hooks.ManageDocks (ToggleStruts(..),avoidStruts,docks,manageDocks)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.ManageHelpers

-- layouts
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Grid
import XMonad.Layout.Tabbed
import XMonad.Layout.PerWorkspace
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.ShowWName
import XMonad.Layout.Spacing
import XMonad.Layout.PerScreen
import XMonad.Layout.Named
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowNavigation
import XMonad.Layout.BoringWindows

-- java swing support
import XMonad.Hooks.SetWMName

-- DBus for polybar support
-- import qualified DBus as D
-- import qualified DBus.Client as D
-- import qualified Codec.Binary.UTF8.String as UTF8

-- Scratchpad
-- import XMonad.Util.Scratchpad

-- color definitions
-- fg        = "#ebdbb2"
-- bg        = "#282828"
-- gray      = "#a89984"
-- bg1       = "#3c3836"
-- bg2       = "#504945"
-- bg3       = "#665c54"
-- bg4       = "#7c6f64"
--
-- green     = "#b8bb26"
-- darkgreen = "#98971a"
-- red       = "#fb4934"
-- darkred   = "#cc241d"
-- yellow    = "#fabd2f"
-- blue      = "#83a598"
-- purple    = "#d3869b"
-- aqua      = "#8ec07c"

colorBack = "#282828"
colorFore = "#ebdbb2"

color01 = "#282828"
color02 = "#cc241d"
color03 = "#98971a"
color04 = "#d79921"
color05 = "#458588"
color06 = "#b16286"
color07 = "#689d6a"
color08 = "#a89984"
color09 = "#928374"
color10 = "#fb4934"
color11 = "#b8bb26"
color12 = "#fabd2f"
color13 = "#83a598"
color14 = "#d3869b"
color15 = "#8ec07c"
color16 = "#ebdbb2"

windowSpacing = 10

-------------------------------------------------------------------------------
-- Main --
{-main :: IO()-}
main = do
  h <- spawnPipe "/usr/bin/xmobar -x 0"
  h' <- spawnPipe "/usr/bin/xmobar -x 1"
  -- h <- spawnPipe "~/.cabal/bin/xmobar"
  -- dbus <- D.connectSession
  -- Request access to the DBus name
  -- D.requestName dbus (D.busName_ "org.xmonad.Log")
  --   [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]

  xmonad $ ewmh $ withUrgencyHook NoUrgencyHook $ docks defaultConfig
             { workspaces = workspaces'
             , modMask = modMask'
             , borderWidth = borderWidth'
             , normalBorderColor = normalBorderColor'
             , focusedBorderColor = focusedBorderColor'
             , terminal = terminal'
             , keys = keys'
             -- , mouseBindings = mouseBindings'
             , logHook = do
                          logHook' h
                          logHook' h'
             -- , logHook = dynamicLogWithPP (myLogHook dbus)
             , layoutHook = layoutHook'
             -- , manageHook = manageHook' <+> manageHook defaultConfig <+> manageScratchPad'
             , manageHook = manageHook' <+> manageHook defaultConfig
             , handleEventHook = fullscreenEventHook
             , focusFollowsMouse  = myFocusFollowsMouse
             , startupHook = do
                              -- spawn "~/.config/polybar/launch.sh"
                              ewmhDesktopsStartup >> setWMName "LG3D"
             }

-------------------------------------------------------------------------------
-- Hooks --

manageHook' :: ManageHook
manageHook' = composeAll
              [ isFullscreen                  --> doFullFloat
              , isDialog                      --> doFloat
              , className     =? "Xmessage"   --> doFloat
              , className     =? "Yakuake"    --> doFloat
              , className     =? "MPlayer"    --> ask >>= doF . W.sink
              , className     =? "MPlayer"    --> doShift "9"
              , manageDocks
              ]

logHook' :: Handle ->  X ()
logHook' h = dynamicLogWithPP (customPP { ppOutput = hPutStrLn h })

-- Override the PP values as you would otherwise, adding colors etc depending
-- on  the statusbar used
-- myLogHook :: D.Client -> PP
-- myLogHook dbus = def
--     { ppOutput = dbusOutput dbus
--     , ppCurrent = wrap ("%{B" ++ bg2 ++ "} ") " %{B-}"
--     , ppVisible = wrap ("%{B" ++ bg1 ++ "} ") " %{B-}"
--     , ppUrgent = wrap ("%{F" ++ red ++ "} ") " %{F-}"
--     , ppHiddenNoWindows = wrap ("%{F" ++ fg ++ "} ") " %{F-}"
--     -- , ppHidden = wrap " " " "
--     , ppWsSep = ""
--     , ppSep = " : "
--     , ppTitle = shorten 40
--     }

-- Emit a DBus signal on log updates
-- dbusOutput :: D.Client -> String -> IO ()
-- dbusOutput dbus str = do
--     let signal = (D.signal objectPath interfaceName memberName) {
--             D.signalBody = [D.toVariant $ UTF8.decodeString str]
--         }
--     D.emit dbus signal
--   where
--     objectPath = D.objectPath_ "/org/xmonad/Log"
--     interfaceName = D.interfaceName_ "org.xmonad.Log"
--     memberName = D.memberName_ "Update"

layoutHook' = customLayout
-- Top-level binding with no type signature:           layoutHook' :: XMonad.Layout.LayoutModifier.ModifiedLayout

-- manageScratchPad' :: ManageHook
-- manageScratchPad' = scratchpadManageHook (W.RationalRect l t w h)
--
--   where
--
--     h = 0.3               -- terminal height, 35%
--     w = 1                 -- terminal width, 100%
--     t = 0                 -- terminal distance from top edge, 0
--     l = 0                 -- terminal distance from left edge, 0

-------------------------------------------------------------------------------
-- Looks --
-- bar
customPP :: PP
customPP = defaultPP
           {
            ppCurrent = xmobarColor color06 "" . wrap ("<box type=Bottom width=2 mb=2 color=" ++ color06 ++ ">") "</box>"
           , ppVisible = xmobarColor color05 "" . wrap "<" ">"
           , ppTitle =  xmobarColor color13 "" . shorten 40
           , ppSep =  "<fc=" ++ color09 ++ "> | </fc>"
           , ppHidden = xmobarColor color04 "" . wrap
                           ("<box type=Bottom width=2 mb=2 color=" ++ color04 ++ ">") "</box>"

           , ppHiddenNoWindows = xmobarColor "#404040" ""
           , ppUrgent = xmobarColor color02 "" . wrap "!" "!"
           , ppLayout = xmobarColor color07 "" . wrap ("<box type=Bottom width=2 mb=2 color=" ++ color07 ++ ">") "</box>" . myLayoutPrinter
           , ppOrder = \(ws:l:t:_) -> [ws, l, t]
           }

myLayoutPrinter :: String -> String
myLayoutPrinter "Spacing Full" = "Full"
myLayoutPrinter "Spacing Tiled" = "Tiled"
myLayoutPrinter "Spacing Wide" = "ThreeCol"
myLayoutPrinter "Tabs" = "Tabs"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

-- borders
borderWidth' :: Dimension
borderWidth' = 1

normalBorderColor', focusedBorderColor' :: String
normalBorderColor'  = "#CCCCCC"
focusedBorderColor' = "#00DD00"
myFont = "xft:MesloLGSForPowerline Nerd Font:pixelsize=12:bold:antialias=true:hinting=true"
myFontLarge = "xft:MesloLGSForPowerline Nerd Font:pixelsize=60:bold:antialias=true:hinting=true"

-- workspaces
workspaces' :: [WorkspaceId]
workspaces' = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]

-- layouts
myTiled = spacing windowSpacing
          $ smartBorders
          $ windowNavigation
          $ subLayout [] myTabbed
          $ boringWindows
          $ named "Tiled"
          $ ResizableTall 1 (3/100) (52/100) []

myWide = spacing windowSpacing
         $smartBorders
         $ windowNavigation
         $ subLayout [] myTabbed
         $ boringWindows
         $ named "Wide"
         $ ThreeColMid 1 (1/20) (1/2)

myFull = spacing windowSpacing $ noBorders $ named "Full" $ Full
myTabbed = noBorders $ named "Tabs" $ tabbed shrinkText defaultTheme {
  fontName = myFont
}
mySWNConfig = defaultSWNConfig
              { swn_font = myFontLarge
              , swn_fade = 1
              , swn_bgcolor = "#dddddd"
              , swn_color = "#000000"
              }
myShowWName = showWName' mySWNConfig

customLayout = myShowWName
              $ avoidStruts 
              $ ifWider 1920 wideLayout normalLayout
              -- $ onWorkspaces ["4", "5", "6"] workLayout
              -- $ onWorkspaces ["8", "9"] (noBorders normalLayout)
              -- $ onWorkspaces ["2"] fullLayout

    where
      wideLayout = myWide ||| myTiled ||| myFull ||| myTabbed
      normalLayout = myTiled ||| myFull ||| myTabbed ||| myWide
      workLayout = myTiled ||| myFull
      fullLayout = myTabbed ||| myFull ||| myTiled

-------------------------------------------------------------------------------
-- Terminal --
terminal' :: String
terminal' = "terminator"
-- terminal' = "urxvt"

myXPConfig = defaultXPConfig
             { promptKeymap = emacsLikeXPKeymap
             , position = Top
             , promptBorderWidth = 1
             , borderColor = "#000000"
             , font = myFont
             }

-------------------------------------------------------------------------------
-- Keys/Button bindings --
-- modmask
modMask' :: KeyMask
modMask' = mod4Mask

-- keys
keys' :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
keys' conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    -- launching and killing programs
    [ ((modMask,                                 xK_Return), spawn $ XMonad.terminal conf)
    -- , ((modMask,                                 xK_p     ), shellPrompt myXPConfig)
    , ((modMask,                                 xK_p     ), spawn "dmenu_run -p 'Run:'")
    , ((modMask .|. shiftMask,                   xK_c     ), kill)
    -- , ((modMask .|. shiftMask,                   xK_p     ), spawn "gmrun")
    , ((modMask .|. shiftMask,                      xK_p     ), shellPrompt myXPConfig)
    , ((modMask .|. shiftMask .|. controlMask,   xK_s     ), spawn "poweroff")
    -- , ((modMask .|. shiftMask .|. controlMask,   xK_l     ), spawn "pkill -u chhetrisushil")
    , ((modMask,                                 xK_d     ), spawn "alock -bg none -c glyph")
    , ((modMask .|. controlMask,                 xK_d     ), spawn "alock -bg image:file=/home/chhetrisushil/Pictures/1752231.jpg -c glyph")

    -- layouts
    , ((modMask,               xK_space ), sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modMask              , xK_b     ), sendMessage ToggleStruts)
    , ((modMask              , xK_f     ), sendMessage $ JumpToLayout "Spacing Full")
    , ((modMask              , xK_r     ), sendMessage $ JumpToLayout "Spacing Tiled")
    , ((modMask              , xK_w     ), sendMessage $ JumpToLayout "Spacing Wide")
    -- Don't need split screens right now :)
    --, ((modMask .|. controlMask, xK_l   ), layoutSplitScreen 2 (TwoPane 0.5 0.5))
    --, ((modMask .|. controlMask, xK_r   ), rescreen)

    -- floating layer stuff
    , ((modMask,               xK_t     ), withFocused $ windows . W.sink)
    , ((modMask,               xK_g     ), withFocused toggleBorder)

    -- refresh
    , ((modMask,               xK_n     ), refresh)

    -- move focus between screens
    , ((modMask .|. controlMask, xK_j   ),  nextScreen)
    , ((modMask .|. controlMask, xK_k   ),  prevScreen)
    , ((modMask,                 xK_z   ),  toggleWS)
    , ((modMask,                 xK_o   ),  shiftNextScreen)

    -- focus
    , ((modMask,               xK_j     ), bindOn LD [("Spacing Full", windows W.focusDown), ("", focusDown)])
    , ((modMask,               xK_k     ), bindOn LD [("Spacing Full", windows W.focusUp), ("", focusUp)])
    , ((modMask,               xK_m     ), focusMaster)

    -- Scratchpad
    -- , ((controlMask,           xK_space), scratchPad)

    -- swapping
    --, ((modMask .|. shiftMask, xK_Return), windows W.swapMaster)
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown)
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp)

    -- increase or decrease number of windows in the master area
    , ((modMask              , xK_comma ), sendMessage (IncMasterN 1))
    , ((modMask              , xK_period), sendMessage (IncMasterN (-1)))

    -- resizing
    , ((modMask,               xK_h     ), sendMessage Shrink)
    , ((modMask,               xK_l     ), sendMessage Expand)
    , ((modMask .|. shiftMask, xK_h     ), sendMessage MirrorShrink)
    , ((modMask .|. shiftMask, xK_l     ), sendMessage MirrorExpand)

    -- sublayouts keybinding
    , ((modMask .|. shiftMask .|. controlMask, xK_h), sendMessage $ pullGroup L)
    , ((modMask .|. shiftMask .|. controlMask, xK_l), sendMessage $ pullGroup R)
    , ((modMask .|. shiftMask .|. controlMask, xK_k), sendMessage $ pullGroup U)
    , ((modMask .|. shiftMask .|. controlMask, xK_j), sendMessage $ pullGroup D)

    -- sublayout merge keybindings
    , ((modMask .|. controlMask, xK_g), withFocused (sendMessage . MergeAll))
    , ((modMask .|. shiftMask .|. controlMask, xK_g), withFocused (sendMessage . UnMerge))

    -- cycle through sublayout windows
    , ((modMask, xK_semicolon), bindOn LD [("Tabs", windows W.focusUp), ("", onGroup W.focusUp')])
    , ((modMask, xK_quoteright), bindOn LD [("Tabs", windows W.focusDown), ("", onGroup W.focusDown')])

    -- XF86AudioMute
    , ((0 , 0x1008ff12), spawn "amixer -q set Master toggle")
    -- XF86AudioLowerVolume
    , ((0 , 0x1008ff11), spawn "amixer -q set Master 1- unmute")
    -- XF86AudioRaiseVolume
    , ((0 , 0x1008ff13), spawn "amixer -q set Master 1+ unmute")
    -- XF86AudioNext
    , ((0 , 0x1008ff17), spawn "mpc next")
    -- XF86AudioPrev
    , ((0 , 0x1008ff16), spawn "mpc prev")
    -- XF86AudioPlay
    , ((0 , 0x1008ff14), spawn "mpc toggle")
    -- XF86Display
    , ((0 , 0x1008ff59), spawn "xset dpms force off")
    -- XF86Display
    , ((0 , 0x1008ff59), spawn "xset dpms force off")
    -- XF86MonBrightnessDown
    -- , ((0 , 0x1008ff03), spawn "xbacklight -dec 2")
    -- XF86MonBrightnessUp
    -- , ((0 , 0x1008ff02), spawn "xbacklight -inc 2")

    -- quit, or restart
    , ((modMask .|. shiftMask, xK_q     ), io exitSuccess)
    , ((modMask              , xK_q     ), restart "xmonad" True)
    ]
    ++
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
    -- mod-control-[1..9] %! Switch to workspace N greedily
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) $ [xK_1 .. xK_9] ++ [xK_0]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask), (W.greedyView, controlMask)]]
      --
      -- where
      --
      --   scratchPad = scratchpadSpawnActionTerminal terminal'
-- mousebindings
-- mouseBindings' (XConfig {XMonad.modMask = modMask}) = M.fromList $
--   [((0, 7), (\w -> nextWS))
--   , ((0, 6), (\w -> prevWS))
--   ]
