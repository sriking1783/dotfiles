;; -*- mode: emacs-lisp -*-
(("paredit-mode"
  ("M-r" . "paredit-raise-sexp")
  ("M-s" . "paredit-slice-sexp")
  ("C-M-{" . "(foo |bar) -> foo (bar)")
  ("C-M-}" . "(foo |bar) -> (foo) bar"))
 ("dired-mode"
  ("% m" . "mark by name")
  ("% g" . "mark by content")
  ("Q" . "query-replace-regexp")
  ("B" . "byte-compile")
  ("$" . "hide-subdir")
  ("i" . "insert-subdir"))
 ("ruby-mode"
  ("C-c C-z" . "ruby-switch-to-inf")
  ("C-x C-r" . "ruby-send-region")
  ("C-x C-e" . "ruby-send-last-sexp")
  ("C-c C-s" . "inf-ruby"))
 ("help-mode"
  ("C-c C-b" . "help-go-back")
  ("C-c C-f" . "help-go-forward"))
 ("Info-mode"
  ("l" . "backward")
  ("r" . "forward")
  ("n" . "next")
  ("p" . "previous")
  ("^" . "up"))
 ("kbd-macros"
  ("C-x (" . "start macro")
  ("C-x )" . "end macro")
  ("C-x e" . "replay macro"))
 ("magit-log-edit-mode"
  ("C-x m" . "leader")
  ("- a" . "insert author")
  ("- s" . "insert signoff")
  ("- S" . "insert submodule summary"))
 ("strftime"
  ("%F" . "2012-12-21")
  ("%Y" . "2012")
  ("%m" . "12")
  ("%d" . "21")
  ("%A" . "Friday")
  ("%a" . "December")
  ("%B" . "Dec"))
 ("cua-rectangle"
  ("M-n" . "seq")
  ("M-R" . "reverse lines"))
 ("org-mode"
  ("C-c C-b" . "backward-same-level")
  ("C-c C-f" . "forward-same-level"))
 ("shell-expansions"
  ("${MISSING:-$EXISTS}" . "$EXISTS")
  ("${MISSING:=value}" . "$MISSING ||= \"value\"")
  ("val=2 ; $(($val + 1)" . "3"))
 ("comint-mode"
  ("M-r" . "history search"))
 ("js2-mode"
  ("C-c C-r" . "js2-refactor")
  ("ag" . "add /*global annotation")
  ("ip" . "introduce param")
  ("ef" . "extract func"))
 ("flamegraph"
  ("pipe-to-perl" . "~/vendor/flamegraph/flamegraph.pl --countname=ms --width=728 > example.svg")))
