let g:vimDir = $HOME.'/.vim'

let s:pluginDef  = g:vimDir.'/vimconfig/pluglist.vim'
let s:pluginConf = g:vimDir.'/vimconfig/plugconfig.vim'

let s:configSetting = g:vimDir.'/vimconfig/setup.vim'
let s:configMapping = g:vimDir.'/vimconfig/mapping.vim'

let s:userConfig  = g:vimDir.'/local.vim'

" Loads the global config, mapping and settings
exec ":source ".s:configSetting
exec ":source ".s:configMapping

" Loads plugins def and config
exec ":source ".s:pluginDef
exec ":source ".s:pluginConf


" user configuration from .vim folder
if filereadable(s:userConfig)
   exec ":source ".s:userConfig
endif

" user configuration from local folder
if filereadable('local.vim')
   exec ":source local.vim"
endif
