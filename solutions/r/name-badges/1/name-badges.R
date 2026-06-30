# 1-3. Print a badge for an employee
print_name_badge <- function(id, name, department) {
  # Handle department: if NULL, default to "OWNER", else uppercase the department name
  dept_str <- if (is.null(department)) "OWNER" else toupper(department)
  
  # Handle ID presence/absence
  if (is.na(id)) {
    # If id is missing (NA), format without prefix
    paste(name, dept_str, sep = " - ")
  } else {
    # If id is present, format with prefix "[id]"
    id_str <- sprintf("[%s]", id)
    paste(id_str, name, dept_str, sep = " - ")
  }
}

# 4. Calculate the total salary of employees with no ID
salaries_no_id <- function(ids, salaries) {
  # Create a logical mask identifying where ids are missing (NA)
  missing_id_mask <- is.na(ids)
  
  # Filter the salaries using the mask and sum the resulting vector
  sum(salaries[missing_id_mask])
}