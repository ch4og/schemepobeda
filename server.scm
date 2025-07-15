#!/usr/bin/env guile
!#

(use-modules (web server)
             (web request)
             (web response)
             (web uri)
             (ice-9 textual-ports)
             (ice-9 regex))

(define (read-file path)
  (if (file-exists? path)
      (call-with-input-file path get-string-all)
      ""))

(define (replace-all str old new)
  (regexp-substitute/global #f (regexp-quote old) str 'pre new 'post))

(define (make-page title dir)
  (let ((template (read-file "template.scmhtml")))
    (replace-all
      (replace-all
        (replace-all
          (replace-all template "{{TITLE}}" title)
          "{{STYLES}}" (string-append (read-file "styles/base.css")
                                     (read-file (string-append "pages/" dir "/styles.css"))))
        "{{CONTENT}}" (read-file (string-append "pages/" dir "/content.html")))
      "{{SCRIPTS}}" (read-file (string-append "pages/" dir "/scripts.js")))))

(define (handler request request-body)
  (let ((path (uri-path (request-uri request))))
    (format #t "GET ~a~%" path)
    (if (or (string=? path "/") (string=? path "/index.html"))
        (values (build-response #:code 200 #:headers '((content-type . (text/html (charset . "utf-8")))))
                (make-page "СХЕМА ПОБЕДА" "home"))
        (values (build-response #:code 404 #:headers '((content-type . (text/html (charset . "utf-8")))))
                (make-page "404 - СХЕМА НЕ НАЙДЕНА" "404")))))

(define (start-server port)
  (format #t "PORT: ~a~%" port)
  (run-server handler 'http `(#:port ,port #:host "0.0.0.0")))

(start-server 
  (if (and (> (length (command-line)) 1)
           (string->number (cadr (command-line))))
      (string->number (cadr (command-line)))
      8080))
