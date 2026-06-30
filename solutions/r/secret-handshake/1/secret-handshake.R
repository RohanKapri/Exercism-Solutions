handshake <- function(n) {
  # Define the available actions and their corresponding bitmask values
  actions <- c("wink", "double blink", "close your eyes", "jump")
  masks <- c(1, 2, 4, 8)
  
  # Identify which actions are present by checking if the bits are set
  selected_actions <- actions[bitwAnd(n, masks) > 0]
  
  # Check if the 5th bit (16) is set to reverse the order of actions
  if (bitwAnd(n, 16) > 0) {
    selected_actions <- rev(selected_actions)
  }
  
  # Return NULL (which is equivalent to c()) if no actions are matched
  if (length(selected_actions) == 0) {
    return(NULL)
  }
  
  return(selected_actions)
}