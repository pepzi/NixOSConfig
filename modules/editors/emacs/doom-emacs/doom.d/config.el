(setq user-full-name "Robert Sand"
      use-mail-address "robert@pepzi.org")

(setq doom-theme 'doom-gruvbox)
(setq display-line-numbers-type 'relative)
(setq doom-font (font-spec :family "Fira Code" :size 18))

;; Remap CapsLock to Ctrl
;;(start-process-shell-command "xmodmap" nil "xmodmap ~/.Xmodmap")

(start-process-shell-command "setxkbmap" nil
                             "setxkbmap -model pc105 -layout se -variant swea5")

(set-irc-server! "irc.libera.chat"
  `(:tls t
    :port 6697
    :nick "pepzi"
    :sasl-username ,(+pass-get-user "irc/libera.chat")
    :sasl-password (lambda (&rest _) (+pass-get-secret "irc/libera.chat"))
    :channels ("#emacs")))

(setq org-directory "~/org/")
(setq org-roam-directory "~/org/roam")

(setq org-hide-emphasis-markers t)

(setq org-todo-keyword-faces
      '(("TODO"  . (:foreground "red" :weight bold))
        ("NEXT"  . (:foreground "red" :weight bold))
        ("DONE"  . (:foreground "forest green" :weight bold))
        ("WAITING"  . (:foreground "orange" :weight bold))
        ("CANCELLED"  . (:foreground "forest green" :weight bold))
        ("SOMEDAY"  . (:foreground "orange" :weight bold))
        ("OPEN"  . (:foreground "red" :weight bold))
        ("CLOSED"  . (:foreground "forest green" :weight bold))
        ("ONGOING"  . (:foreground "orange" :weight bold))))

(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!/!)")
        (sequence "WAITING(w@/!)" "|" "CANCELLED(c!/!)")
        (sequence "SOMEDAY(s!/!)" "|")
        (sequence "OPEN(O!)" "|" "CLOSED(C!)")
        (sequence "ONGOING(o)" "|")))


(after! elfeed
  (setq elfeed-search-filter "@1-month-ago +unread"))
