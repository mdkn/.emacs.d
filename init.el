(eval-and-compile
?  (customize-set-variable
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

(leaf files
  :doc "file input and output commands for Emacs"
  :global-minor-mode auto-save-visited-mode
  :custom `((auto-save-file-name-transforms . '((".*" ,(locate-user-emacs-file "backup/") t)))
            (backup-directory-alist . '((".*" . ,(locate-user-emacs-file "backup"))
                                        (,tramp-file-name-regexp . nil)))
            (version-control . t)
            (delete-old-versions . t)
            (auto-save-visited-interval . 1)))


(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-t") ctl-x-map)

(defvar daily-report-directory "~/src/org/daily-reports/"
  "Directory where daily reports are saved.")

(defun create-daily-report ()
  "Create or open a daily report file for today with date and time."
  (interactive)
  (unless (file-exists-p daily-report-directory)
    (make-directory daily-report-directory t))
  (let* ((date-time-string (format-time-string "%Y-%m-%d_%H-%M-%S"))
         (file-name (expand-file-name (concat date-time-string ".org") daily-report-directory)))
    (find-file file-name)
    (when (not (file-exists-p file-name))
      (insert (format "#+TITLE: Daily Report - %s\n\n" (format-time-string "%Y-%m-%d %H:%M:%S")))
      (insert "* Summary\n\n")
      (insert "* Tasks\n\n")
      (insert "* Notes\n\n"))
    (save-buffer)))

(global-set-key (kbd "<f9>") 'create-daily-report)

(leaf org
  :doc "Outline-based notes management and organizer"
  :custom ((org-startup-truncated . nil)
           (fill-column . 10000))
  :hook ((org-mode-hook . (lambda ()
                           (auto-fill-mode -1)
                           (visual-line-mode 1)))))

(leaf skk
  :ensure ddskk
  :custom ((default-input-method . "japanese-skk"))
  :config
  (leaf ddskk-posframe
    :ensure t
    :global-minor-mode t))

(global-set-key "\C-x\C-j" 'skk-mode)
(global-set-key "\C-xj" 'skk-auto-fill-mode)
(global-set-key "\C-xt" 'skk-tutorial)
(global-set-key "\C-t\C-t" 'other-window)

(defun list-daily-reports ()
  "List all daily report files in the daily-report directory."
  (interactive)
  (let ((report-files (directory-files daily-report-directory nil "\\.org$")))
    (if report-files
        (with-output-to-temp-buffer "*Daily Reports*"
          (princ "Daily Reports:\n")
          (princ "==============\n\n")
          (dolist (file (sort report-files 'string>))
            (let ((full-path (expand-file-name file daily-report-directory))
                  (summary ""))
              (with-temp-buffer
                (insert-file-contents full-path)
                (when (re-search-forward "^\\* Summary" nil t)
                  (forward-line 1)
                  (let ((summary-start (point)))
                    (when (re-search-forward "^\\* " nil t)
                      (beginning-of-line)
                      (let ((summary-content (string-trim (buffer-substring-no-properties summary-start (point)))))
                        (unless (string-match-p "^[[:space:]]*$" summary-content)
                          (setq summary summary-content)))))))
              (princ (format "%s %s\n" file (if (string-empty-p summary) "" summary)))))
          (with-current-buffer "*Daily Reports*"
            (goto-char (point-min))
            (local-set-key (kbd "RET") 'daily-report-open-at-point)
            (local-set-key (kbd "q") 'quit-window)))
      (message "No daily reports found in %s" daily-report-directory))))

(defun daily-report-open-at-point ()
  "Open the daily report file at point."
  (interactive)
  (let ((line (thing-at-point 'line t)))
    (when (and line (string-match "\\([0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}\\(?:_[0-9]\\{2\\}-[0-9]\\{2\\}-[0-9]\\{2\\}\\)?\\.org\\)" line))
      (let ((filename (match-string 1 line)))
        (quit-window)
        (find-file (expand-file-name filename daily-report-directory))))))

(global-set-key (kbd "<f8>") 'list-daily-reports)

(message "End of loading init.el.")

;; Use y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)
