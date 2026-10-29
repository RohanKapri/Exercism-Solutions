package sqlbuilder

import "strings"

// ColumnValue represents a single database column and its corresponding value
// to be used in SQL INSERT statements.
type ColumnValue struct {
	Column string
	Value  string
}

// BuildSelectQuery generates a valid SQL SELECT query for the specified table and columns.
// If the columns slice is empty or nil, it defaults to the wildcard "*".
func BuildSelectQuery(table string, columns []string) string {
	var sb strings.Builder
	sb.WriteString("SELECT ")
	if len(columns) == 0 {
		sb.WriteString("*")
	} else {
		for i := 0; i < len(columns); i++ {
			sb.WriteString(columns[i])
			if i != len(columns)-1 {
				sb.WriteString(", ")
			}
		}
	}
	sb.WriteString(" FROM ")
	sb.WriteString(table)
	sb.WriteString(";")
	return sb.String()
}

// BuildBatchInserts generates a slice of individual SQL INSERT statements for the provided rows.
// Empty rows are skipped, and values must be enclosed in single quotes.
func BuildBatchInserts(table string, rows [][]ColumnValue) []string {
	var column, value, query strings.Builder
	var queries []string = make([]string, 0)
	for _, row := range rows {
		for index, col := range row {
			if index == 0 {
				column.WriteRune('(')
				value.WriteRune('(')
			}
			column.WriteString(col.Column)
			value.WriteString("'")
			value.WriteString(col.Value)
			value.WriteString("'")
			if index < len(row)-1 {
				column.WriteString(", ")
				value.WriteString(", ")
			} else {
				column.WriteRune(')')
				value.WriteRune(')')
			}
		}
		query.WriteString("INSERT INTO ")
		query.WriteString(table)
		query.WriteString(" ")
		query.WriteString(column.String())
		query.WriteString(" VALUES ")
		query.WriteString(value.String())
		query.WriteRune(';')
		queries = append(queries, query.String())
		column.Reset()
		value.Reset()
		query.Reset()
	}
	return queries
}
