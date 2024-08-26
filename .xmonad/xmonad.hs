{- xmonad.hs
 - Author: Sushil Chhetri <chhetrisushil@gmail.com>
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
import XMonad.Actions.CopyWindow
import XMonad.Config

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
-- import XMonad.Hooks.FadeInactive

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
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowNavigation
import XMonad.Layout.BoringWindows
import XMonad.Layout.IndependentScreens
import XMonad.Layout.Renamed

-- imports for splitting screens
import XMonad.Layout.LayoutScreens
import XMonad.Layout.TwoPane

-- java swing support
import XMonad.Hooks.SetWMName

-- Scratchpad
import XMonad.Util.NamedScratchpad
import XMonad.Util.WorkspaceCompare
import XMonad.Util.EZConfig

-- color definitions
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

colorTrayer :: String
colorTrayer = "--tint 0x282828"

-- screen spacing
screenSpacing :: Integer
screenSpacing = 8

-- window spacing
windowSpacing :: Integer
windowSpacing = 8

-- scratchpads
scratchpads = [
    NS "terminal" spawnTerm findTerm manageTerm
    , NS "music" spawnMusic findMusic manageMusic
    ]
  where
    spawnTerm = "urxvtc -name UrxvtScratchpad -e tmux"
    findTerm = (appName =? "UrxvtScratchpad")
    manageTerm = (customFloating $ W.RationalRect l t w h)
      where
        h = 0.3               -- terminal height, 35%
        w = 1                 -- terminal width, 100%
        t = 0                 -- terminal distance from top edge, 0
        l = 0                 -- terminal distance from left edge, 0
    spawnMusic = "urxvtc -name MusicScratchpad -e ncmpcpp"
    findMusic = (appName =? "MusicScratchpad")
    manageMusic = (customFloating $ W.RationalRect l t w h)
      where
        h = 0.9               -- terminal height, 90%
        w = 0.9               -- terminal width, 90%
        t = 0.95 -h
        l = 0.95 -w

-------------------------------------------------------------------------------
-- Main --
{-main :: IO()-}
main = do
  n <- countScreens
  xmprocs <- mapM(\i -> spawnPipe $ "/usr/bin/xmobar -x " ++ show i ++ " /home/chhetrisushil/.xmobarrc") [0..n-1]
  xmprocs' <- mapM(\j -> spawnPipe $ "/usr/bin/xmobar -x " ++ show j ++ " /home/chhetrisushil/.xmobarrc-bottom") [0..n-1]

  xmonad $ ewmhFullscreen . ewmh $ withUrgencyHook NoUrgencyHook $ docks def
             { workspaces = myWorkspaces
             , modMask = modMask'
             , borderWidth = borderWidth'
             , normalBorderColor = normalBorderColor'
             , focusedBorderColor = focusedBorderColor'
             , terminal = terminal'
             , keys = keys'
             -- , mouseBindings = mouseBindings'
             , logHook = do
                          -- fadeInactiveLogHook 0.7 -- fade inactive windows by 70%
                          mapM_(\h -> logHook' $ h) (xmprocs)
                          mapM_(\h -> dynamicLogWithPP $ def {
                              ppOutput = hPutStrLn h
                            , ppOrder = \(ws:l:t:_) -> []
                          })(xmprocs')
             , layoutHook = layoutHook'
             , manageHook = namedScratchpadManageHook scratchpads <+> manageHook' <+> manageHook def
             , focusFollowsMouse  = myFocusFollowsMouse
             , startupHook = myStartupHook
             } `additionalKeysP` myAdditionalKeys

-------------------------------------------------------------------------------
-- Hooks --

myStartupHook :: X ()
myStartupHook = do
                  setWMName "LG3D"

manageHook' :: ManageHook
manageHook' = composeAll
              [ isFullscreen                  --> doFullFloat
              , isDialog                      --> doFloat
              , className     =? "Xmessage"   --> doFloat
              , className     =? "Yakuake"    --> doFloat
              -- , className     =? "MPlayer"    --> ask >>= doF . W.sink -- sink mplayer to avoid overlapping
              , className     =? "MPlayer"    --> doFloat
              , className     =? "MPlayer"    --> doShift "9"
              , className     =? "mpv"        --> doFloat
              , manageDocks
              ]

logHook' :: Handle ->  X ()
logHook' h = dynamicLogWithPP (customPP { ppOutput = hPutStrLn h })

layoutHook' = customLayout
-- Top-level binding with no type signature:           layoutHook' :: XMonad.Layout.LayoutModifier.ModifiedLayout

-------------------------------------------------------------------------------
-- Looks --
-- bar
customPP :: PP
customPP = def
           {
            ppCurrent = xmobarColor color06 "" . wrap ("[<box type=Bottom width=2 mb=2 color=" ++ color06 ++ ">") "</box>]"
           , ppVisible = xmobarColor color05 "" . wrap "<" ">"
           , ppSep =  "<fc=" ++ color09 ++ "> | </fc>"
           , ppHidden = xmobarColor color04 "" . wrap
                           ("<box type=Bottom width=2 mb=2 color=" ++ color04 ++ ">") "</box>"

           , ppHiddenNoWindows = xmobarColor "#404040" ""
           , ppUrgent = xmobarColor color02 "" . wrap "!" "!"
           , ppLayout = xmobarColor color07 "" . wrap ("<box type=Bottom width=2 mb=2 color=" ++ color07 ++ ">") "</box>"
           , ppTitle =  xmobarColor color13 "" . shorten 80
           , ppExtras = [windowCount]
           , ppOrder = \(ws:l:t:ex) -> [ws, l]++ex++[t]
           , ppSort = fmap (. filterOutWs ["NSP"]) getSortByIndex
           }
           where
            windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

-- borders
borderWidth' :: Dimension
borderWidth' = 2

normalBorderColor', focusedBorderColor' :: String
normalBorderColor'  = "#4A4A4A"
focusedBorderColor' = "#00FF15"
myFont = "xft:MesloLGSForPowerline Nerd Font:pixelsize=12:bold:antialias=true:hinting=true"
myFontLarge = "xft:MesloLGSForPowerline Nerd Font:pixelsize=60:bold:antialias=true:hinting=true"

-- workspaces
myWorkspaces :: [WorkspaceId]
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]

-- spacing
-- mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing screenSpacing windowSpacing = spacingRaw False (Border screenSpacing screenSpacing screenSpacing screenSpacing) True (Border windowSpacing windowSpacing windowSpacing windowSpacing) True

-- layouts
myTiled = renamed [XMonad.Layout.Renamed.Replace "Tiled"]
          $ smartBorders
          $ windowNavigation
          $ subLayout [] myTabs
          $ mySpacing screenSpacing windowSpacing
          $ boringWindows
          $ ResizableTall 1 (3/100) (52/100) []

myWide = renamed [XMonad.Layout.Renamed.Replace "Wide"]
         $ smartBorders
         $ windowNavigation
         $ subLayout [] myTabs
         $ mySpacing screenSpacing windowSpacing
         $ boringWindows
         $ ThreeColMid 1 (1/20) (1/2)

myFull = renamed [XMonad.Layout.Renamed.Replace "Full"]
         $ mySpacing screenSpacing windowSpacing 
         $ noBorders
         $ Full

myTabbed = renamed [XMonad.Layout.Renamed.Replace "Tabs"]
           $ noBorders
           $ myTabs

myTabs = tabbed shrinkText def {
          fontName = myFont
         }

mySWNConfig = def
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

myXPConfig = def
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
    , ((modMask .|. shiftMask,                   xK_p     ), shellPrompt myXPConfig)
    , ((modMask .|. shiftMask .|. controlMask,   xK_s     ), spawn "poweroff")
    , ((modMask,                                 xK_d     ), spawn "betterlockscreen -l -- --time-str '%I:%M %p'")
    -- , ((modMask .|. controlMask,                 xK_d     ), spawn "alock -bg image:file=/home/chhetrisushil/Pictures/1752231.jpg -c glyph")

    -- layouts
    , ((modMask,               xK_space ), sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modMask              , xK_b     ), sendMessage ToggleStruts)
    , ((modMask              , xK_f     ), sendMessage $ JumpToLayout "Full")
    , ((modMask              , xK_r     ), sendMessage $ JumpToLayout "Tiled")
    , ((modMask              , xK_w     ), sendMessage $ JumpToLayout "Wide")
    -- Don't need split screens right now :)
    , ((modMask .|. controlMask, xK_l   ), layoutSplitScreen 2 (TwoPane 0.5 0.5))
    , ((modMask .|. controlMask, xK_r   ), rescreen)

    , ((modMask,               xK_g     ), withFocused toggleBorder)

    -- refresh
    , ((modMask,               xK_n     ), refresh)

    -- move focus between screens
    , ((modMask .|. controlMask, xK_j   ),  nextScreen)
    , ((modMask .|. controlMask, xK_k   ),  prevScreen)
    , ((modMask,                 xK_z   ),  toggleWS' ["NSP"])
    , ((modMask,                 xK_o   ),  shiftNextScreen)

    -- focus
    , ((modMask,               xK_j     ), bindOn LD [("Full", windows W.focusDown), ("", focusDown)])
    , ((modMask,               xK_k     ), bindOn LD [("Full", windows W.focusUp), ("", focusUp)])
    , ((modMask,               xK_m     ), focusMaster)

    -- Scratchpad
    , ((mod1Mask,           xK_space), namedScratchpadAction scratchpads "terminal")

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
-- mousebindings
-- mouseBindings' (XConfig {XMonad.modMask = modMask}) = M.fromList $
--   [((0, 7), (\w -> nextWS))
--   , ((0, 6), (\w -> prevWS))
--   ]

---------------------------------------------------------------------------
-- Add additional key bindings, best part is we can add sequencing which --
-- brings more combination possibilities                                 --
---------------------------------------------------------------------------
myAdditionalKeys :: [(String, X ())]
myAdditionalKeys = [
  ("M-a " ++ key, f)
    | (key, f) <- [
    -- this section will bind a sequence with prefix `Mod+a <key>`
    ("r", spawn "urxvtc -e ranger")
    , ("m", namedScratchpadAction scratchpads "music")
    , ("d o t", spawn "urxvtc -e lazygit -p ~/.dotfiles")
    , ("g", spawn "google-chrome-stable")
    , ("a l", spawn "alacritty")
    , ("d p h", spawn "clipdel '.*' | dmenu -p 'Delete paste history: ' -l 10 | clipdel -d")
    ]
  ]
  ++
  [
  -- this section will bind whatever key bindings you add
  ("M-u", spawn "urxvtc")
  , ("M-M1-c", spawn "clipmenu -p 'clipboard:'")
  , ("M-t", withFocused toggleFloat)

  -- keep current window visible in every workspace
  , ("M-s", windows copyToAll)
  , ("M-S-s", killAllOtherCopies)
  ]
  where
      toggleFloat win =
        windows (\s -> if M.member win (W.floating s)
                      then W.sink win s
                      else (W.float win (W.RationalRect l t w h) s)) -- center float the window
                        where
                          h = 0.5
                          w = 0.5
                          l = 0.25
                          t = 0.25
