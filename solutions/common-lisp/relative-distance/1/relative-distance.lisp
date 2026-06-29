(defpackage :relative-distance
  (:use :cl)
  (:export :degree-of-separation))

(in-package :relative-distance)

(defun degree-of-separation (family-tree person-a person-b)
  "Calculates the minimum degree of separation between person-a and person-b."
  ;; If searching for the same person, distance is 0
  (if (string= person-a person-b)
      (return-from degree-of-separation 0))

  (let ((graph (make-hash-table :test 'equal)))
    
    ;; Local helper function to establish undirected adjacency edges
    (labels ((add-edge (u v)
               (unless (string= u v)
                 (setf (gethash u graph) (adjoin v (gethash u graph) :test #'string=))
                 (setf (gethash v graph) (adjoin u (gethash v graph) :test #'string=)))))
      
      ;; 1. Build the graph adjacency list from the flat entry format: (parent child1 child2 ...)
      (dolist (entry family-tree)
        (let ((parent (first entry))
              (children (rest entry)))
          
          ;; Link the parent to each of their children
          (dolist (child children)
            (add-edge parent child))
          
          ;; Link all siblings directly to each other (separation of 1)
          (loop for tail on children do
            (let ((sibling1 (first tail)))
              (dolist (sibling2 (rest tail))
                (add-edge sibling1 sibling2)))))))

    ;; 2. Execute Breadth-First Search (BFS) to discover the shortest path
    (let ((queue (list (list person-a 0)))
          (visited (make-hash-table :test 'equal)))
      
      (setf (gethash person-a visited) t)
      
      (loop while queue do
        (let* ((current-node (pop queue))
               (curr-person (first current-node))
               (curr-dist (second current-node)))
          
          ;; Target found! Return the accumulated distance
          (if (string= curr-person person-b)
              (return-from degree-of-separation curr-dist))
          
          ;; Visit unvisited neighboring relatives
          (dolist (neighbor (gethash curr-person graph))
            (unless (gethash neighbor visited)
              (setf (gethash neighbor visited) t)
              ;; Append new nodes to the back of the queue (FIFO)
              (setf queue (append queue (list (list neighbor (1+ curr-dist)))))))))
      
      ;; If the queue empties without finding a connection
      nil)))