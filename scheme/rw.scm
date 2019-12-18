;; Read a text file
(call-with-input-file "input.txt"
  (lambda (input-port)
    (let loop ((x (read-char input-port)))
      (if (not (eof-object? x))
          (begin
            (display x)
            (loop (read-char input-port)))))))

;; Write to a text file
(call-with-output-file "output.txt"
  (lambda (output-port)
    (display "hello, world" output-port))) ;; or (write "hello, world" output-port)

(exit)