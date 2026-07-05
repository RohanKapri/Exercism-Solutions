(defmodule robot-simulator
  (export (create 0)
          (place 3)
          (direction 1)
          (position 1)
          (left 1)
          (right 1)
          (advance 1)
          (control 2)

          ;; gen_server stuff
          (init 1)
          (handle_cast 2)
          (handle_call 3)
          (handle_info 2)
          (terminate 2)
          (code_change 3))
  (behaviour gen_server))

;;; ============================================================================
;;; Helper functions - Direction and Position Logic
;;; ============================================================================

(defun turn-left
  "Rotate direction 90 degrees counter-clockwise"
  (('north) 'west)
  (('west) 'south)
  (('south) 'east)
  (('east) 'north)
  ((_) 'undefined))

(defun turn-right
  "Rotate direction 90 degrees clockwise"
  (('north) 'east)
  (('east) 'south)
  (('south) 'west)
  (('west) 'north)
  ((_) 'undefined))

(defun advance-pos
  "Calculate new position after advancing one step in the given direction"
  (('north (tuple x y)) (tuple x (+ y 1)))
  (('south (tuple x y)) (tuple x (- y 1)))
  (('east (tuple x y)) (tuple (+ x 1) y))
  (('west (tuple x y)) (tuple (- x 1) y))
  ((_ pos) pos))

(defun process-command
  "Process a single command character and update state"
  ((#\R (tuple dir pos)) (tuple (turn-right dir) pos))
  ((#\L (tuple dir pos)) (tuple (turn-left dir) pos))
  ((#\A (tuple dir pos)) (tuple dir (advance-pos dir pos)))
  ((_ state) state))

;;; ============================================================================
;;; Public API functions
;;; ============================================================================
(defun create
  "Create a new robot simulator instance"
  ([]
   (case (gen_server:start_link 'robot-simulator '() '())
     ((tuple 'ok pid) pid)
     ((tuple 'error reason) (error reason)))))

(defun direction
  "Get the current direction the robot is facing"
  ([robot] (gen_server:call robot 'direction)))

(defun position
  "Get the current position of the robot"
  ([robot] (gen_server:call robot 'position)))

(defun place
  "Place the robot at a specific position facing a specific direction"
  ([robot direction position]
   (gen_server:call robot (tuple 'place direction position))))

(defun left
  "Turn the robot left (counter-clockwise)"
  ([robot] (gen_server:call robot 'left)))

(defun right
  "Turn the robot right (clockwise)"
  ([robot] (gen_server:call robot 'right)))

(defun advance
  "Move the robot forward one step in its current direction"
  ([robot] (gen_server:call robot 'advance)))

(defun control
  "Execute a series of commands on the robot"
  ([robot string] (gen_server:call robot (tuple 'control string))))

;;; ============================================================================
;;; gen_server callbacks
;;; ============================================================================

(defun init
  "Initialize the robot with undefined direction and position"
  ([_args]
   (tuple 'ok (tuple 'undefined (tuple 'undefined 'undefined)))))

(defun handle_call
  "Handle synchronous calls to the robot server"
  ;; Query current direction
  (('direction _from (tuple dir pos))
   (tuple 'reply dir (tuple dir pos)))
  
  ;; Query current position
  (('position _from (tuple dir pos))
   (tuple 'reply pos (tuple dir pos)))
  
  ;; Place robot at new position and direction
  (((tuple 'place direction position) _from _state)
   (tuple 'reply 'ok (tuple direction position)))
  
  ;; Turn left
  (('left _from (tuple dir pos))
   (let ((new-dir (turn-left dir)))
     (tuple 'reply 'ok (tuple new-dir pos))))
  
  ;; Turn right
  (('right _from (tuple dir pos))
   (let ((new-dir (turn-right dir)))
     (tuple 'reply 'ok (tuple new-dir pos))))
  
  ;; Advance forward
  (('advance _from (tuple dir pos))
   (let ((new-pos (advance-pos dir pos)))
     (tuple 'reply 'ok (tuple dir new-pos))))
  
  ;; Execute command string
  (((tuple 'control commands) _from state)
   (let ((new-state (lists:foldl
                      (lambda (char acc) (process-command char acc))
                      state
                      commands)))
     (tuple 'reply 'ok new-state)))
  
  ;; Catch-all for unknown requests
  ((_request _from state)
   (tuple 'reply (tuple 'error 'unknown_request) state)))

(defun handle_cast
  "Handle asynchronous messages (none expected for this robot)"
  ([_msg state]
   (tuple 'noreply state)))

(defun handle_info
  "Handle other messages (none expected for this robot)"
  ([_info state]
   (tuple 'noreply state)))

(defun terminate
  "Clean up when the robot process is stopping"
  ([_reason _state]
   'ok))

(defun code_change
  "Handle hot code upgrades"
  ([_old-vsn state _extra]
   (tuple 'ok state)))
   