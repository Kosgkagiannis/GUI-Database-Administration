package main

import (
	"database/sql"
	"fmt"
	"html/template"
	"net/http"

	_ "github.com/mattn/go-sqlite3"
)

const (
	SQLiteDBPath = "./initdb.sql"
)

var db *sql.DB

func main() {
	var err error
	db, err = sql.Open("sqlite3", SQLiteDBPath)
	if err != nil {
		panic(err)
	}
	defer db.Close()

	http.HandleFunc("/", indexHandler)
	http.HandleFunc("/query", queryHandler)

	fmt.Println("Server is running on :8080")
	http.ListenAndServe(":8080", nil)
}

func indexHandler(w http.ResponseWriter, r *http.Request) {
	tmpl, err := template.ParseFiles("templates/index.html")
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	if err := tmpl.Execute(w, nil); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
	}
}

func queryHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}

	query := r.FormValue("query")

	rows, err := db.Query(query)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	columns, err := rows.Columns()
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	var results [][]interface{}
	for rows.Next() {
		values := make([]interface{}, len(columns))
		for i := range values {
			values[i] = new(interface{})
		}
		if err := rows.Scan(values...); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		results = append(results, values)
	}

	tmpl, err := template.New("result").Parse(resultTemplate)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	data := struct {
		Columns []string
		Results [][]interface{}
	}{
		Columns: columns,
		Results: results,
	}

	if err := tmpl.Execute(w, data); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
	}
}

const resultTemplate = `
<!DOCTYPE html>
<html>
<head>
    <title>Database Administration</title>
</head>
<body>
    <h1>Database Administration</h1>
    
    <form action="/query" method="POST">
        <label for="query">Database Query:</label>
        <textarea id="query" name="query" rows="4" cols="50"></textarea>
        <br>
        <input type="submit" value="Execute Query">
    </form>
    
    <!-- Display query results here -->
    <table border="1">
        <tr>
            {{range .Columns}}
                <th>{{.}}</th>
            {{end}}
        </tr>
        {{range .Results}}
            <tr>
                {{range .}}
                    <td>{{.}}</td>
                {{end}}
            </tr>
        {{end}}
    </table>
</body>
</html>
`
