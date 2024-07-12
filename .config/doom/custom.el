(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fill-column 150)
 '(magit-todos-insert-after '(bottom) nil nil "Changed by setter of obsolete option `magit-todos-insert-at'")
 '(org-roam-capture-templates
   '(("d" "default" plain
      (file "~/capture-templates/default.org")
      :target
      (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+TITLE: ${title}\12#+DESCRIPTION: %^{Description prompt}\12")
      :unnarrowed t)))
 '(org-safe-remote-resources
   '("\\`https://fniessen\\.github\\.io/org-html-themes/org/theme-readtheorg\\.setup\\'"))
 '(package-selected-packages
   '(lua-mode go-mode lsp-mode org-roam-ui elm-mode all-the-icons-nerd-fonts nerd-icons all-the-icons svelte-mode org-roam org-modern visual-fill-column org-present ox-reveal org-bullets olivetti emojify)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'customize-option 'disabled nil)
(put 'customize-variable 'disabled nil)
