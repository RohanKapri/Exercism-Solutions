(defmodule bank-account
  (export (balance 1)
          (charge 2)
          (close 1)
          (create 0)
          (deposit 2)
          (open 1)
          (withdraw 2)))

(defun create ()
  (spawn
    (lambda ()
      (receive))))

(defun open (account)
  (case (get account)
    ('undefined
      (put account 0)
      account)
    (_
      #(error "account already open"))))

(defun close (account)
  (case (get account)
    ('undefined
      #(error "account not open"))
    (_
      (erase account)
      'ok)))

(defun balance (account)
  (case (get account)
    ('undefined
      #(error "account not open"))
    (balance
      balance)))

(defun deposit (account amount)
  (cond
    ((< amount 0)
      #(error "amount must be greater than 0"))
    ((== (get account) 'undefined)
      #(error "account not open"))
    ('true
      (put account (+ (get account) amount))
      'ok)))

(defun withdraw (account amount)
  (cond
    ((< amount 0)
      #(error "amount must be greater than 0"))
    ((== (get account) 'undefined)
      #(error "account not open"))
    ((> amount (get account))
      #(error "amount must be less than balance"))
    ('true
      (put account (- (get account) amount))
      'ok)))

(defun charge (account amount)
  (withdraw account amount))