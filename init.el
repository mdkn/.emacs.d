(eval-and-compile
  (customize-set-variable
   'package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                       ("melpa" . "https://melpa.org/packages/")))
  (package-initialize)
  (use-package leaf :ensure t)

  (leaf leaf-keywords
    :ensure t
    :init
    (leaf blackout :ensure t)
    :config
    (leaf-keywords-init)))

(leaf leaf-convert
  :doc "Convert many format to leaf format"
  :ensure t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(leaf-convert blackout leaf-keywords leaf)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(menu-bar-mode -1)
(tool-bar-mode 0)

(leaf auto-save-buffers-enhanced
  (setq auto-save-buffers-enhanced-interval 1)
  (auto-save-buffers-enhanced t))

(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-t") ctl-x-map)

(defvar daily-report-directory "~/src/org/daily-reports/"
  "Directory where daily reports are saved.")

(defun create-daily-report ()
  "Create or open a daily report file for today."
  (interactive)
  (unless (file-exists-p daily-report-directory)
    (make-directory daily-report-directory t))
  (let* ((date-string (format-time-string "%Y-%m-%d"))
         (file-name (expand-file-name (concat date-string ".org") daily-report-directory)))
    (find-file file-name)
    (when (not (file-exists-p file-name))
      (insert (format "#+TITLE: Daily Report - %s\n\n" date-string))
      (insert "* Summary\n\n")
      (insert "* Tasks\n\n")
      (insert "* Notes\n\n"))
    (save-buffer)))

(global-set-key (kbd "<f9>") 'create-daily-report)